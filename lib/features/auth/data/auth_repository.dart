import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:http/http.dart' as http;
import '../../../core/constants.dart';

class AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: AppConstants.gmailScopes,
  );
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  GoogleSignInAccount? _currentUser;
  Map<String, String>? _authHeaders;

  GoogleSignInAccount? get currentUser => _currentUser;

  Future<bool> isSignedIn() async {
    return _googleSignIn.isSignedIn();
  }

  /// Attempt silent sign in (restore previous session)
  Future<GoogleSignInAccount?> trySilentSignIn() async {
    try {
      _currentUser = await _googleSignIn.signInSilently();
      if (_currentUser != null) {
        await _cacheUserInfo(_currentUser!);
        _authHeaders = await _currentUser!.authHeaders;
      }
      return _currentUser;
    } catch (e) {
      debugPrint('Silent sign in failed: $e');
      return null;
    }
  }

  /// Interactive sign in
  Future<GoogleSignInAccount?> signIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();
      if (_currentUser != null) {
        await _cacheUserInfo(_currentUser!);
        _authHeaders = await _currentUser!.authHeaders;
      }
      return _currentUser;
    } catch (e) {
      debugPrint('Sign in failed: $e');
      rethrow;
    }
  }

  /// Sign out and clear stored tokens
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _secureStorage.deleteAll();
    _currentUser = null;
    _authHeaders = null;
  }

  /// Get authenticated HTTP client for Gmail API calls
  Future<http.Client> getAuthenticatedClient() async {
    if (_currentUser == null) {
      final restored = await trySilentSignIn();
      if (restored == null) {
        throw Exception('Not authenticated. Please sign in.');
      }
    }

    // Refresh auth headers (handles token refresh automatically)
    try {
      _authHeaders = await _currentUser!.authHeaders;
    } catch (e) {
      // Token refresh failed, try re-authenticating
      _currentUser = await _googleSignIn.signInSilently();
      if (_currentUser == null) {
        throw Exception('Session expired. Please sign in again.');
      }
      _authHeaders = await _currentUser!.authHeaders;
    }

    return _GoogleAuthClient(_authHeaders!);
  }

  /// Get Gmail API service
  Future<gmail.GmailApi> getGmailApi() async {
    final client = await getAuthenticatedClient();
    return gmail.GmailApi(client);
  }

  /// Get cached user info
  Future<Map<String, String?>> getCachedUserInfo() async {
    return {
      'email': await _secureStorage.read(key: AppConstants.keyUserEmail),
      'name': await _secureStorage.read(key: AppConstants.keyUserName),
      'photo': await _secureStorage.read(key: AppConstants.keyUserPhoto),
    };
  }

  Future<void> _cacheUserInfo(GoogleSignInAccount user) async {
    await _secureStorage.write(
      key: AppConstants.keyUserEmail,
      value: user.email,
    );
    await _secureStorage.write(
      key: AppConstants.keyUserName,
      value: user.displayName ?? '',
    );
    await _secureStorage.write(
      key: AppConstants.keyUserPhoto,
      value: user.photoUrl ?? '',
    );
  }
}

/// Custom HTTP client that adds auth headers to every request
class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _inner = http.Client();

  _GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
