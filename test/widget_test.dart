import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gmail_sub/app.dart';

void main() {
  testWidgets('SubTrack app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SubTrackApp()));
    await tester.pump();
    // App should render without crashing
    expect(find.textContaining('SubTrack'), findsAny);
  });
}
