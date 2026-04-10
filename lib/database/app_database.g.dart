// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, Subscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _serviceNameMeta =
      const VerificationMeta('serviceName');
  @override
  late final GeneratedColumn<String> serviceName = GeneratedColumn<String>(
      'service_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serviceCategoryMeta =
      const VerificationMeta('serviceCategory');
  @override
  late final GeneratedColumn<String> serviceCategory = GeneratedColumn<String>(
      'service_category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _senderEmailMeta =
      const VerificationMeta('senderEmail');
  @override
  late final GeneratedColumn<String> senderEmail = GeneratedColumn<String>(
      'sender_email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _senderDomainMeta =
      const VerificationMeta('senderDomain');
  @override
  late final GeneratedColumn<String> senderDomain = GeneratedColumn<String>(
      'sender_domain', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typicalAmountMeta =
      const VerificationMeta('typicalAmount');
  @override
  late final GeneratedColumn<double> typicalAmount = GeneratedColumn<double>(
      'typical_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('USD'));
  static const VerificationMeta _billingCycleMeta =
      const VerificationMeta('billingCycle');
  @override
  late final GeneratedColumn<String> billingCycle = GeneratedColumn<String>(
      'billing_cycle', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('monthly'));
  static const VerificationMeta _firstSeenDateMeta =
      const VerificationMeta('firstSeenDate');
  @override
  late final GeneratedColumn<DateTime> firstSeenDate =
      GeneratedColumn<DateTime>('first_seen_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastSeenDateMeta =
      const VerificationMeta('lastSeenDate');
  @override
  late final GeneratedColumn<DateTime> lastSeenDate = GeneratedColumn<DateTime>(
      'last_seen_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _logoUrlMeta =
      const VerificationMeta('logoUrl');
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
      'logo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        serviceName,
        serviceCategory,
        senderEmail,
        senderDomain,
        typicalAmount,
        currency,
        billingCycle,
        firstSeenDate,
        lastSeenDate,
        isActive,
        logoUrl,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(Insertable<Subscription> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('service_name')) {
      context.handle(
          _serviceNameMeta,
          serviceName.isAcceptableOrUnknown(
              data['service_name']!, _serviceNameMeta));
    } else if (isInserting) {
      context.missing(_serviceNameMeta);
    }
    if (data.containsKey('service_category')) {
      context.handle(
          _serviceCategoryMeta,
          serviceCategory.isAcceptableOrUnknown(
              data['service_category']!, _serviceCategoryMeta));
    }
    if (data.containsKey('sender_email')) {
      context.handle(
          _senderEmailMeta,
          senderEmail.isAcceptableOrUnknown(
              data['sender_email']!, _senderEmailMeta));
    } else if (isInserting) {
      context.missing(_senderEmailMeta);
    }
    if (data.containsKey('sender_domain')) {
      context.handle(
          _senderDomainMeta,
          senderDomain.isAcceptableOrUnknown(
              data['sender_domain']!, _senderDomainMeta));
    } else if (isInserting) {
      context.missing(_senderDomainMeta);
    }
    if (data.containsKey('typical_amount')) {
      context.handle(
          _typicalAmountMeta,
          typicalAmount.isAcceptableOrUnknown(
              data['typical_amount']!, _typicalAmountMeta));
    } else if (isInserting) {
      context.missing(_typicalAmountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('billing_cycle')) {
      context.handle(
          _billingCycleMeta,
          billingCycle.isAcceptableOrUnknown(
              data['billing_cycle']!, _billingCycleMeta));
    }
    if (data.containsKey('first_seen_date')) {
      context.handle(
          _firstSeenDateMeta,
          firstSeenDate.isAcceptableOrUnknown(
              data['first_seen_date']!, _firstSeenDateMeta));
    } else if (isInserting) {
      context.missing(_firstSeenDateMeta);
    }
    if (data.containsKey('last_seen_date')) {
      context.handle(
          _lastSeenDateMeta,
          lastSeenDate.isAcceptableOrUnknown(
              data['last_seen_date']!, _lastSeenDateMeta));
    } else if (isInserting) {
      context.missing(_lastSeenDateMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('logo_url')) {
      context.handle(_logoUrlMeta,
          logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscription(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      serviceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_name'])!,
      serviceCategory: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}service_category']),
      senderEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sender_email'])!,
      senderDomain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sender_domain'])!,
      typicalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}typical_amount'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      billingCycle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}billing_cycle'])!,
      firstSeenDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}first_seen_date'])!,
      lastSeenDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_seen_date'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      logoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_url']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }
}

class Subscription extends DataClass implements Insertable<Subscription> {
  final int id;
  final String serviceName;
  final String? serviceCategory;
  final String senderEmail;
  final String senderDomain;
  final double typicalAmount;
  final String currency;
  final String billingCycle;
  final DateTime firstSeenDate;
  final DateTime lastSeenDate;
  final bool isActive;
  final String? logoUrl;
  final String? notes;
  const Subscription(
      {required this.id,
      required this.serviceName,
      this.serviceCategory,
      required this.senderEmail,
      required this.senderDomain,
      required this.typicalAmount,
      required this.currency,
      required this.billingCycle,
      required this.firstSeenDate,
      required this.lastSeenDate,
      required this.isActive,
      this.logoUrl,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['service_name'] = Variable<String>(serviceName);
    if (!nullToAbsent || serviceCategory != null) {
      map['service_category'] = Variable<String>(serviceCategory);
    }
    map['sender_email'] = Variable<String>(senderEmail);
    map['sender_domain'] = Variable<String>(senderDomain);
    map['typical_amount'] = Variable<double>(typicalAmount);
    map['currency'] = Variable<String>(currency);
    map['billing_cycle'] = Variable<String>(billingCycle);
    map['first_seen_date'] = Variable<DateTime>(firstSeenDate);
    map['last_seen_date'] = Variable<DateTime>(lastSeenDate);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      id: Value(id),
      serviceName: Value(serviceName),
      serviceCategory: serviceCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceCategory),
      senderEmail: Value(senderEmail),
      senderDomain: Value(senderDomain),
      typicalAmount: Value(typicalAmount),
      currency: Value(currency),
      billingCycle: Value(billingCycle),
      firstSeenDate: Value(firstSeenDate),
      lastSeenDate: Value(lastSeenDate),
      isActive: Value(isActive),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Subscription.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscription(
      id: serializer.fromJson<int>(json['id']),
      serviceName: serializer.fromJson<String>(json['serviceName']),
      serviceCategory: serializer.fromJson<String?>(json['serviceCategory']),
      senderEmail: serializer.fromJson<String>(json['senderEmail']),
      senderDomain: serializer.fromJson<String>(json['senderDomain']),
      typicalAmount: serializer.fromJson<double>(json['typicalAmount']),
      currency: serializer.fromJson<String>(json['currency']),
      billingCycle: serializer.fromJson<String>(json['billingCycle']),
      firstSeenDate: serializer.fromJson<DateTime>(json['firstSeenDate']),
      lastSeenDate: serializer.fromJson<DateTime>(json['lastSeenDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serviceName': serializer.toJson<String>(serviceName),
      'serviceCategory': serializer.toJson<String?>(serviceCategory),
      'senderEmail': serializer.toJson<String>(senderEmail),
      'senderDomain': serializer.toJson<String>(senderDomain),
      'typicalAmount': serializer.toJson<double>(typicalAmount),
      'currency': serializer.toJson<String>(currency),
      'billingCycle': serializer.toJson<String>(billingCycle),
      'firstSeenDate': serializer.toJson<DateTime>(firstSeenDate),
      'lastSeenDate': serializer.toJson<DateTime>(lastSeenDate),
      'isActive': serializer.toJson<bool>(isActive),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Subscription copyWith(
          {int? id,
          String? serviceName,
          Value<String?> serviceCategory = const Value.absent(),
          String? senderEmail,
          String? senderDomain,
          double? typicalAmount,
          String? currency,
          String? billingCycle,
          DateTime? firstSeenDate,
          DateTime? lastSeenDate,
          bool? isActive,
          Value<String?> logoUrl = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      Subscription(
        id: id ?? this.id,
        serviceName: serviceName ?? this.serviceName,
        serviceCategory: serviceCategory.present
            ? serviceCategory.value
            : this.serviceCategory,
        senderEmail: senderEmail ?? this.senderEmail,
        senderDomain: senderDomain ?? this.senderDomain,
        typicalAmount: typicalAmount ?? this.typicalAmount,
        currency: currency ?? this.currency,
        billingCycle: billingCycle ?? this.billingCycle,
        firstSeenDate: firstSeenDate ?? this.firstSeenDate,
        lastSeenDate: lastSeenDate ?? this.lastSeenDate,
        isActive: isActive ?? this.isActive,
        logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
        notes: notes.present ? notes.value : this.notes,
      );
  Subscription copyWithCompanion(SubscriptionsCompanion data) {
    return Subscription(
      id: data.id.present ? data.id.value : this.id,
      serviceName:
          data.serviceName.present ? data.serviceName.value : this.serviceName,
      serviceCategory: data.serviceCategory.present
          ? data.serviceCategory.value
          : this.serviceCategory,
      senderEmail:
          data.senderEmail.present ? data.senderEmail.value : this.senderEmail,
      senderDomain: data.senderDomain.present
          ? data.senderDomain.value
          : this.senderDomain,
      typicalAmount: data.typicalAmount.present
          ? data.typicalAmount.value
          : this.typicalAmount,
      currency: data.currency.present ? data.currency.value : this.currency,
      billingCycle: data.billingCycle.present
          ? data.billingCycle.value
          : this.billingCycle,
      firstSeenDate: data.firstSeenDate.present
          ? data.firstSeenDate.value
          : this.firstSeenDate,
      lastSeenDate: data.lastSeenDate.present
          ? data.lastSeenDate.value
          : this.lastSeenDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscription(')
          ..write('id: $id, ')
          ..write('serviceName: $serviceName, ')
          ..write('serviceCategory: $serviceCategory, ')
          ..write('senderEmail: $senderEmail, ')
          ..write('senderDomain: $senderDomain, ')
          ..write('typicalAmount: $typicalAmount, ')
          ..write('currency: $currency, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('firstSeenDate: $firstSeenDate, ')
          ..write('lastSeenDate: $lastSeenDate, ')
          ..write('isActive: $isActive, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      serviceName,
      serviceCategory,
      senderEmail,
      senderDomain,
      typicalAmount,
      currency,
      billingCycle,
      firstSeenDate,
      lastSeenDate,
      isActive,
      logoUrl,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscription &&
          other.id == this.id &&
          other.serviceName == this.serviceName &&
          other.serviceCategory == this.serviceCategory &&
          other.senderEmail == this.senderEmail &&
          other.senderDomain == this.senderDomain &&
          other.typicalAmount == this.typicalAmount &&
          other.currency == this.currency &&
          other.billingCycle == this.billingCycle &&
          other.firstSeenDate == this.firstSeenDate &&
          other.lastSeenDate == this.lastSeenDate &&
          other.isActive == this.isActive &&
          other.logoUrl == this.logoUrl &&
          other.notes == this.notes);
}

class SubscriptionsCompanion extends UpdateCompanion<Subscription> {
  final Value<int> id;
  final Value<String> serviceName;
  final Value<String?> serviceCategory;
  final Value<String> senderEmail;
  final Value<String> senderDomain;
  final Value<double> typicalAmount;
  final Value<String> currency;
  final Value<String> billingCycle;
  final Value<DateTime> firstSeenDate;
  final Value<DateTime> lastSeenDate;
  final Value<bool> isActive;
  final Value<String?> logoUrl;
  final Value<String?> notes;
  const SubscriptionsCompanion({
    this.id = const Value.absent(),
    this.serviceName = const Value.absent(),
    this.serviceCategory = const Value.absent(),
    this.senderEmail = const Value.absent(),
    this.senderDomain = const Value.absent(),
    this.typicalAmount = const Value.absent(),
    this.currency = const Value.absent(),
    this.billingCycle = const Value.absent(),
    this.firstSeenDate = const Value.absent(),
    this.lastSeenDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.notes = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    this.id = const Value.absent(),
    required String serviceName,
    this.serviceCategory = const Value.absent(),
    required String senderEmail,
    required String senderDomain,
    required double typicalAmount,
    this.currency = const Value.absent(),
    this.billingCycle = const Value.absent(),
    required DateTime firstSeenDate,
    required DateTime lastSeenDate,
    this.isActive = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.notes = const Value.absent(),
  })  : serviceName = Value(serviceName),
        senderEmail = Value(senderEmail),
        senderDomain = Value(senderDomain),
        typicalAmount = Value(typicalAmount),
        firstSeenDate = Value(firstSeenDate),
        lastSeenDate = Value(lastSeenDate);
  static Insertable<Subscription> custom({
    Expression<int>? id,
    Expression<String>? serviceName,
    Expression<String>? serviceCategory,
    Expression<String>? senderEmail,
    Expression<String>? senderDomain,
    Expression<double>? typicalAmount,
    Expression<String>? currency,
    Expression<String>? billingCycle,
    Expression<DateTime>? firstSeenDate,
    Expression<DateTime>? lastSeenDate,
    Expression<bool>? isActive,
    Expression<String>? logoUrl,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serviceName != null) 'service_name': serviceName,
      if (serviceCategory != null) 'service_category': serviceCategory,
      if (senderEmail != null) 'sender_email': senderEmail,
      if (senderDomain != null) 'sender_domain': senderDomain,
      if (typicalAmount != null) 'typical_amount': typicalAmount,
      if (currency != null) 'currency': currency,
      if (billingCycle != null) 'billing_cycle': billingCycle,
      if (firstSeenDate != null) 'first_seen_date': firstSeenDate,
      if (lastSeenDate != null) 'last_seen_date': lastSeenDate,
      if (isActive != null) 'is_active': isActive,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (notes != null) 'notes': notes,
    });
  }

  SubscriptionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? serviceName,
      Value<String?>? serviceCategory,
      Value<String>? senderEmail,
      Value<String>? senderDomain,
      Value<double>? typicalAmount,
      Value<String>? currency,
      Value<String>? billingCycle,
      Value<DateTime>? firstSeenDate,
      Value<DateTime>? lastSeenDate,
      Value<bool>? isActive,
      Value<String?>? logoUrl,
      Value<String?>? notes}) {
    return SubscriptionsCompanion(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      senderEmail: senderEmail ?? this.senderEmail,
      senderDomain: senderDomain ?? this.senderDomain,
      typicalAmount: typicalAmount ?? this.typicalAmount,
      currency: currency ?? this.currency,
      billingCycle: billingCycle ?? this.billingCycle,
      firstSeenDate: firstSeenDate ?? this.firstSeenDate,
      lastSeenDate: lastSeenDate ?? this.lastSeenDate,
      isActive: isActive ?? this.isActive,
      logoUrl: logoUrl ?? this.logoUrl,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serviceName.present) {
      map['service_name'] = Variable<String>(serviceName.value);
    }
    if (serviceCategory.present) {
      map['service_category'] = Variable<String>(serviceCategory.value);
    }
    if (senderEmail.present) {
      map['sender_email'] = Variable<String>(senderEmail.value);
    }
    if (senderDomain.present) {
      map['sender_domain'] = Variable<String>(senderDomain.value);
    }
    if (typicalAmount.present) {
      map['typical_amount'] = Variable<double>(typicalAmount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (billingCycle.present) {
      map['billing_cycle'] = Variable<String>(billingCycle.value);
    }
    if (firstSeenDate.present) {
      map['first_seen_date'] = Variable<DateTime>(firstSeenDate.value);
    }
    if (lastSeenDate.present) {
      map['last_seen_date'] = Variable<DateTime>(lastSeenDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('id: $id, ')
          ..write('serviceName: $serviceName, ')
          ..write('serviceCategory: $serviceCategory, ')
          ..write('senderEmail: $senderEmail, ')
          ..write('senderDomain: $senderDomain, ')
          ..write('typicalAmount: $typicalAmount, ')
          ..write('currency: $currency, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('firstSeenDate: $firstSeenDate, ')
          ..write('lastSeenDate: $lastSeenDate, ')
          ..write('isActive: $isActive, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _subscriptionIdMeta =
      const VerificationMeta('subscriptionId');
  @override
  late final GeneratedColumn<int> subscriptionId = GeneratedColumn<int>(
      'subscription_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subscriptions (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
      'payment_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _gmailMessageIdMeta =
      const VerificationMeta('gmailMessageId');
  @override
  late final GeneratedColumn<String> gmailMessageId = GeneratedColumn<String>(
      'gmail_message_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailSubjectMeta =
      const VerificationMeta('emailSubject');
  @override
  late final GeneratedColumn<String> emailSubject = GeneratedColumn<String>(
      'email_subject', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _confidenceMeta =
      const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<String> confidence = GeneratedColumn<String>(
      'confidence', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('high'));
  static const VerificationMeta _isVerifiedMeta =
      const VerificationMeta('isVerified');
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
      'is_verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_verified" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        subscriptionId,
        amount,
        currency,
        paymentDate,
        gmailMessageId,
        emailSubject,
        confidence,
        isVerified
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<Payment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
          _subscriptionIdMeta,
          subscriptionId.isAcceptableOrUnknown(
              data['subscription_id']!, _subscriptionIdMeta));
    } else if (isInserting) {
      context.missing(_subscriptionIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('gmail_message_id')) {
      context.handle(
          _gmailMessageIdMeta,
          gmailMessageId.isAcceptableOrUnknown(
              data['gmail_message_id']!, _gmailMessageIdMeta));
    } else if (isInserting) {
      context.missing(_gmailMessageIdMeta);
    }
    if (data.containsKey('email_subject')) {
      context.handle(
          _emailSubjectMeta,
          emailSubject.isAcceptableOrUnknown(
              data['email_subject']!, _emailSubjectMeta));
    }
    if (data.containsKey('confidence')) {
      context.handle(
          _confidenceMeta,
          confidence.isAcceptableOrUnknown(
              data['confidence']!, _confidenceMeta));
    }
    if (data.containsKey('is_verified')) {
      context.handle(
          _isVerifiedMeta,
          isVerified.isAcceptableOrUnknown(
              data['is_verified']!, _isVerifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      subscriptionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subscription_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      paymentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}payment_date'])!,
      gmailMessageId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}gmail_message_id'])!,
      emailSubject: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email_subject']),
      confidence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}confidence'])!,
      isVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_verified'])!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int subscriptionId;
  final double amount;
  final String currency;
  final DateTime paymentDate;
  final String gmailMessageId;
  final String? emailSubject;
  final String confidence;
  final bool isVerified;
  const Payment(
      {required this.id,
      required this.subscriptionId,
      required this.amount,
      required this.currency,
      required this.paymentDate,
      required this.gmailMessageId,
      this.emailSubject,
      required this.confidence,
      required this.isVerified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subscription_id'] = Variable<int>(subscriptionId);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['gmail_message_id'] = Variable<String>(gmailMessageId);
    if (!nullToAbsent || emailSubject != null) {
      map['email_subject'] = Variable<String>(emailSubject);
    }
    map['confidence'] = Variable<String>(confidence);
    map['is_verified'] = Variable<bool>(isVerified);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      subscriptionId: Value(subscriptionId),
      amount: Value(amount),
      currency: Value(currency),
      paymentDate: Value(paymentDate),
      gmailMessageId: Value(gmailMessageId),
      emailSubject: emailSubject == null && nullToAbsent
          ? const Value.absent()
          : Value(emailSubject),
      confidence: Value(confidence),
      isVerified: Value(isVerified),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      subscriptionId: serializer.fromJson<int>(json['subscriptionId']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      gmailMessageId: serializer.fromJson<String>(json['gmailMessageId']),
      emailSubject: serializer.fromJson<String?>(json['emailSubject']),
      confidence: serializer.fromJson<String>(json['confidence']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subscriptionId': serializer.toJson<int>(subscriptionId),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'gmailMessageId': serializer.toJson<String>(gmailMessageId),
      'emailSubject': serializer.toJson<String?>(emailSubject),
      'confidence': serializer.toJson<String>(confidence),
      'isVerified': serializer.toJson<bool>(isVerified),
    };
  }

  Payment copyWith(
          {int? id,
          int? subscriptionId,
          double? amount,
          String? currency,
          DateTime? paymentDate,
          String? gmailMessageId,
          Value<String?> emailSubject = const Value.absent(),
          String? confidence,
          bool? isVerified}) =>
      Payment(
        id: id ?? this.id,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        paymentDate: paymentDate ?? this.paymentDate,
        gmailMessageId: gmailMessageId ?? this.gmailMessageId,
        emailSubject:
            emailSubject.present ? emailSubject.value : this.emailSubject,
        confidence: confidence ?? this.confidence,
        isVerified: isVerified ?? this.isVerified,
      );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      paymentDate:
          data.paymentDate.present ? data.paymentDate.value : this.paymentDate,
      gmailMessageId: data.gmailMessageId.present
          ? data.gmailMessageId.value
          : this.gmailMessageId,
      emailSubject: data.emailSubject.present
          ? data.emailSubject.value
          : this.emailSubject,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
      isVerified:
          data.isVerified.present ? data.isVerified.value : this.isVerified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('gmailMessageId: $gmailMessageId, ')
          ..write('emailSubject: $emailSubject, ')
          ..write('confidence: $confidence, ')
          ..write('isVerified: $isVerified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, subscriptionId, amount, currency,
      paymentDate, gmailMessageId, emailSubject, confidence, isVerified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.subscriptionId == this.subscriptionId &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.paymentDate == this.paymentDate &&
          other.gmailMessageId == this.gmailMessageId &&
          other.emailSubject == this.emailSubject &&
          other.confidence == this.confidence &&
          other.isVerified == this.isVerified);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> subscriptionId;
  final Value<double> amount;
  final Value<String> currency;
  final Value<DateTime> paymentDate;
  final Value<String> gmailMessageId;
  final Value<String?> emailSubject;
  final Value<String> confidence;
  final Value<bool> isVerified;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.gmailMessageId = const Value.absent(),
    this.emailSubject = const Value.absent(),
    this.confidence = const Value.absent(),
    this.isVerified = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int subscriptionId,
    required double amount,
    required String currency,
    required DateTime paymentDate,
    required String gmailMessageId,
    this.emailSubject = const Value.absent(),
    this.confidence = const Value.absent(),
    this.isVerified = const Value.absent(),
  })  : subscriptionId = Value(subscriptionId),
        amount = Value(amount),
        currency = Value(currency),
        paymentDate = Value(paymentDate),
        gmailMessageId = Value(gmailMessageId);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? subscriptionId,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<DateTime>? paymentDate,
    Expression<String>? gmailMessageId,
    Expression<String>? emailSubject,
    Expression<String>? confidence,
    Expression<bool>? isVerified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (gmailMessageId != null) 'gmail_message_id': gmailMessageId,
      if (emailSubject != null) 'email_subject': emailSubject,
      if (confidence != null) 'confidence': confidence,
      if (isVerified != null) 'is_verified': isVerified,
    });
  }

  PaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? subscriptionId,
      Value<double>? amount,
      Value<String>? currency,
      Value<DateTime>? paymentDate,
      Value<String>? gmailMessageId,
      Value<String?>? emailSubject,
      Value<String>? confidence,
      Value<bool>? isVerified}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentDate: paymentDate ?? this.paymentDate,
      gmailMessageId: gmailMessageId ?? this.gmailMessageId,
      emailSubject: emailSubject ?? this.emailSubject,
      confidence: confidence ?? this.confidence,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<int>(subscriptionId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (gmailMessageId.present) {
      map['gmail_message_id'] = Variable<String>(gmailMessageId.value);
    }
    if (emailSubject.present) {
      map['email_subject'] = Variable<String>(emailSubject.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(confidence.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('gmailMessageId: $gmailMessageId, ')
          ..write('emailSubject: $emailSubject, ')
          ..write('confidence: $confidence, ')
          ..write('isVerified: $isVerified')
          ..write(')'))
        .toString();
  }
}

class $ScanMetadataTable extends ScanMetadata
    with TableInfo<$ScanMetadataTable, ScanMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _scanDateMeta =
      const VerificationMeta('scanDate');
  @override
  late final GeneratedColumn<DateTime> scanDate = GeneratedColumn<DateTime>(
      'scan_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _emailsScannedMeta =
      const VerificationMeta('emailsScanned');
  @override
  late final GeneratedColumn<int> emailsScanned = GeneratedColumn<int>(
      'emails_scanned', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subscriptionsFoundMeta =
      const VerificationMeta('subscriptionsFound');
  @override
  late final GeneratedColumn<int> subscriptionsFound = GeneratedColumn<int>(
      'subscriptions_found', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paymentsFoundMeta =
      const VerificationMeta('paymentsFound');
  @override
  late final GeneratedColumn<int> paymentsFound = GeneratedColumn<int>(
      'payments_found', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastMessageIdMeta =
      const VerificationMeta('lastMessageId');
  @override
  late final GeneratedColumn<String> lastMessageId = GeneratedColumn<String>(
      'last_message_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        scanDate,
        emailsScanned,
        subscriptionsFound,
        paymentsFound,
        lastMessageId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_metadata';
  @override
  VerificationContext validateIntegrity(Insertable<ScanMetadataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('scan_date')) {
      context.handle(_scanDateMeta,
          scanDate.isAcceptableOrUnknown(data['scan_date']!, _scanDateMeta));
    } else if (isInserting) {
      context.missing(_scanDateMeta);
    }
    if (data.containsKey('emails_scanned')) {
      context.handle(
          _emailsScannedMeta,
          emailsScanned.isAcceptableOrUnknown(
              data['emails_scanned']!, _emailsScannedMeta));
    } else if (isInserting) {
      context.missing(_emailsScannedMeta);
    }
    if (data.containsKey('subscriptions_found')) {
      context.handle(
          _subscriptionsFoundMeta,
          subscriptionsFound.isAcceptableOrUnknown(
              data['subscriptions_found']!, _subscriptionsFoundMeta));
    } else if (isInserting) {
      context.missing(_subscriptionsFoundMeta);
    }
    if (data.containsKey('payments_found')) {
      context.handle(
          _paymentsFoundMeta,
          paymentsFound.isAcceptableOrUnknown(
              data['payments_found']!, _paymentsFoundMeta));
    } else if (isInserting) {
      context.missing(_paymentsFoundMeta);
    }
    if (data.containsKey('last_message_id')) {
      context.handle(
          _lastMessageIdMeta,
          lastMessageId.isAcceptableOrUnknown(
              data['last_message_id']!, _lastMessageIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanMetadataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      scanDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}scan_date'])!,
      emailsScanned: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}emails_scanned'])!,
      subscriptionsFound: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}subscriptions_found'])!,
      paymentsFound: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payments_found'])!,
      lastMessageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_message_id']),
    );
  }

  @override
  $ScanMetadataTable createAlias(String alias) {
    return $ScanMetadataTable(attachedDatabase, alias);
  }
}

class ScanMetadataData extends DataClass
    implements Insertable<ScanMetadataData> {
  final int id;
  final DateTime scanDate;
  final int emailsScanned;
  final int subscriptionsFound;
  final int paymentsFound;
  final String? lastMessageId;
  const ScanMetadataData(
      {required this.id,
      required this.scanDate,
      required this.emailsScanned,
      required this.subscriptionsFound,
      required this.paymentsFound,
      this.lastMessageId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['scan_date'] = Variable<DateTime>(scanDate);
    map['emails_scanned'] = Variable<int>(emailsScanned);
    map['subscriptions_found'] = Variable<int>(subscriptionsFound);
    map['payments_found'] = Variable<int>(paymentsFound);
    if (!nullToAbsent || lastMessageId != null) {
      map['last_message_id'] = Variable<String>(lastMessageId);
    }
    return map;
  }

  ScanMetadataCompanion toCompanion(bool nullToAbsent) {
    return ScanMetadataCompanion(
      id: Value(id),
      scanDate: Value(scanDate),
      emailsScanned: Value(emailsScanned),
      subscriptionsFound: Value(subscriptionsFound),
      paymentsFound: Value(paymentsFound),
      lastMessageId: lastMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageId),
    );
  }

  factory ScanMetadataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanMetadataData(
      id: serializer.fromJson<int>(json['id']),
      scanDate: serializer.fromJson<DateTime>(json['scanDate']),
      emailsScanned: serializer.fromJson<int>(json['emailsScanned']),
      subscriptionsFound: serializer.fromJson<int>(json['subscriptionsFound']),
      paymentsFound: serializer.fromJson<int>(json['paymentsFound']),
      lastMessageId: serializer.fromJson<String?>(json['lastMessageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scanDate': serializer.toJson<DateTime>(scanDate),
      'emailsScanned': serializer.toJson<int>(emailsScanned),
      'subscriptionsFound': serializer.toJson<int>(subscriptionsFound),
      'paymentsFound': serializer.toJson<int>(paymentsFound),
      'lastMessageId': serializer.toJson<String?>(lastMessageId),
    };
  }

  ScanMetadataData copyWith(
          {int? id,
          DateTime? scanDate,
          int? emailsScanned,
          int? subscriptionsFound,
          int? paymentsFound,
          Value<String?> lastMessageId = const Value.absent()}) =>
      ScanMetadataData(
        id: id ?? this.id,
        scanDate: scanDate ?? this.scanDate,
        emailsScanned: emailsScanned ?? this.emailsScanned,
        subscriptionsFound: subscriptionsFound ?? this.subscriptionsFound,
        paymentsFound: paymentsFound ?? this.paymentsFound,
        lastMessageId:
            lastMessageId.present ? lastMessageId.value : this.lastMessageId,
      );
  ScanMetadataData copyWithCompanion(ScanMetadataCompanion data) {
    return ScanMetadataData(
      id: data.id.present ? data.id.value : this.id,
      scanDate: data.scanDate.present ? data.scanDate.value : this.scanDate,
      emailsScanned: data.emailsScanned.present
          ? data.emailsScanned.value
          : this.emailsScanned,
      subscriptionsFound: data.subscriptionsFound.present
          ? data.subscriptionsFound.value
          : this.subscriptionsFound,
      paymentsFound: data.paymentsFound.present
          ? data.paymentsFound.value
          : this.paymentsFound,
      lastMessageId: data.lastMessageId.present
          ? data.lastMessageId.value
          : this.lastMessageId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanMetadataData(')
          ..write('id: $id, ')
          ..write('scanDate: $scanDate, ')
          ..write('emailsScanned: $emailsScanned, ')
          ..write('subscriptionsFound: $subscriptionsFound, ')
          ..write('paymentsFound: $paymentsFound, ')
          ..write('lastMessageId: $lastMessageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scanDate, emailsScanned,
      subscriptionsFound, paymentsFound, lastMessageId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanMetadataData &&
          other.id == this.id &&
          other.scanDate == this.scanDate &&
          other.emailsScanned == this.emailsScanned &&
          other.subscriptionsFound == this.subscriptionsFound &&
          other.paymentsFound == this.paymentsFound &&
          other.lastMessageId == this.lastMessageId);
}

class ScanMetadataCompanion extends UpdateCompanion<ScanMetadataData> {
  final Value<int> id;
  final Value<DateTime> scanDate;
  final Value<int> emailsScanned;
  final Value<int> subscriptionsFound;
  final Value<int> paymentsFound;
  final Value<String?> lastMessageId;
  const ScanMetadataCompanion({
    this.id = const Value.absent(),
    this.scanDate = const Value.absent(),
    this.emailsScanned = const Value.absent(),
    this.subscriptionsFound = const Value.absent(),
    this.paymentsFound = const Value.absent(),
    this.lastMessageId = const Value.absent(),
  });
  ScanMetadataCompanion.insert({
    this.id = const Value.absent(),
    required DateTime scanDate,
    required int emailsScanned,
    required int subscriptionsFound,
    required int paymentsFound,
    this.lastMessageId = const Value.absent(),
  })  : scanDate = Value(scanDate),
        emailsScanned = Value(emailsScanned),
        subscriptionsFound = Value(subscriptionsFound),
        paymentsFound = Value(paymentsFound);
  static Insertable<ScanMetadataData> custom({
    Expression<int>? id,
    Expression<DateTime>? scanDate,
    Expression<int>? emailsScanned,
    Expression<int>? subscriptionsFound,
    Expression<int>? paymentsFound,
    Expression<String>? lastMessageId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scanDate != null) 'scan_date': scanDate,
      if (emailsScanned != null) 'emails_scanned': emailsScanned,
      if (subscriptionsFound != null) 'subscriptions_found': subscriptionsFound,
      if (paymentsFound != null) 'payments_found': paymentsFound,
      if (lastMessageId != null) 'last_message_id': lastMessageId,
    });
  }

  ScanMetadataCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? scanDate,
      Value<int>? emailsScanned,
      Value<int>? subscriptionsFound,
      Value<int>? paymentsFound,
      Value<String?>? lastMessageId}) {
    return ScanMetadataCompanion(
      id: id ?? this.id,
      scanDate: scanDate ?? this.scanDate,
      emailsScanned: emailsScanned ?? this.emailsScanned,
      subscriptionsFound: subscriptionsFound ?? this.subscriptionsFound,
      paymentsFound: paymentsFound ?? this.paymentsFound,
      lastMessageId: lastMessageId ?? this.lastMessageId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scanDate.present) {
      map['scan_date'] = Variable<DateTime>(scanDate.value);
    }
    if (emailsScanned.present) {
      map['emails_scanned'] = Variable<int>(emailsScanned.value);
    }
    if (subscriptionsFound.present) {
      map['subscriptions_found'] = Variable<int>(subscriptionsFound.value);
    }
    if (paymentsFound.present) {
      map['payments_found'] = Variable<int>(paymentsFound.value);
    }
    if (lastMessageId.present) {
      map['last_message_id'] = Variable<String>(lastMessageId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanMetadataCompanion(')
          ..write('id: $id, ')
          ..write('scanDate: $scanDate, ')
          ..write('emailsScanned: $emailsScanned, ')
          ..write('subscriptionsFound: $subscriptionsFound, ')
          ..write('paymentsFound: $paymentsFound, ')
          ..write('lastMessageId: $lastMessageId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $ScanMetadataTable scanMetadata = $ScanMetadataTable(this);
  late final SubscriptionDao subscriptionDao =
      SubscriptionDao(this as AppDatabase);
  late final PaymentDao paymentDao = PaymentDao(this as AppDatabase);
  late final ScanDao scanDao = ScanDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [subscriptions, payments, scanMetadata];
}

typedef $$SubscriptionsTableCreateCompanionBuilder = SubscriptionsCompanion
    Function({
  Value<int> id,
  required String serviceName,
  Value<String?> serviceCategory,
  required String senderEmail,
  required String senderDomain,
  required double typicalAmount,
  Value<String> currency,
  Value<String> billingCycle,
  required DateTime firstSeenDate,
  required DateTime lastSeenDate,
  Value<bool> isActive,
  Value<String?> logoUrl,
  Value<String?> notes,
});
typedef $$SubscriptionsTableUpdateCompanionBuilder = SubscriptionsCompanion
    Function({
  Value<int> id,
  Value<String> serviceName,
  Value<String?> serviceCategory,
  Value<String> senderEmail,
  Value<String> senderDomain,
  Value<double> typicalAmount,
  Value<String> currency,
  Value<String> billingCycle,
  Value<DateTime> firstSeenDate,
  Value<DateTime> lastSeenDate,
  Value<bool> isActive,
  Value<String?> logoUrl,
  Value<String?> notes,
});

class $$SubscriptionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SubscriptionsTable,
    Subscription,
    $$SubscriptionsTableFilterComposer,
    $$SubscriptionsTableOrderingComposer,
    $$SubscriptionsTableCreateCompanionBuilder,
    $$SubscriptionsTableUpdateCompanionBuilder> {
  $$SubscriptionsTableTableManager(_$AppDatabase db, $SubscriptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SubscriptionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SubscriptionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> serviceName = const Value.absent(),
            Value<String?> serviceCategory = const Value.absent(),
            Value<String> senderEmail = const Value.absent(),
            Value<String> senderDomain = const Value.absent(),
            Value<double> typicalAmount = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String> billingCycle = const Value.absent(),
            Value<DateTime> firstSeenDate = const Value.absent(),
            Value<DateTime> lastSeenDate = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String?> logoUrl = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              SubscriptionsCompanion(
            id: id,
            serviceName: serviceName,
            serviceCategory: serviceCategory,
            senderEmail: senderEmail,
            senderDomain: senderDomain,
            typicalAmount: typicalAmount,
            currency: currency,
            billingCycle: billingCycle,
            firstSeenDate: firstSeenDate,
            lastSeenDate: lastSeenDate,
            isActive: isActive,
            logoUrl: logoUrl,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String serviceName,
            Value<String?> serviceCategory = const Value.absent(),
            required String senderEmail,
            required String senderDomain,
            required double typicalAmount,
            Value<String> currency = const Value.absent(),
            Value<String> billingCycle = const Value.absent(),
            required DateTime firstSeenDate,
            required DateTime lastSeenDate,
            Value<bool> isActive = const Value.absent(),
            Value<String?> logoUrl = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              SubscriptionsCompanion.insert(
            id: id,
            serviceName: serviceName,
            serviceCategory: serviceCategory,
            senderEmail: senderEmail,
            senderDomain: senderDomain,
            typicalAmount: typicalAmount,
            currency: currency,
            billingCycle: billingCycle,
            firstSeenDate: firstSeenDate,
            lastSeenDate: lastSeenDate,
            isActive: isActive,
            logoUrl: logoUrl,
            notes: notes,
          ),
        ));
}

class $$SubscriptionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get serviceName => $state.composableBuilder(
      column: $state.table.serviceName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get serviceCategory => $state.composableBuilder(
      column: $state.table.serviceCategory,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get senderEmail => $state.composableBuilder(
      column: $state.table.senderEmail,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get senderDomain => $state.composableBuilder(
      column: $state.table.senderDomain,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get typicalAmount => $state.composableBuilder(
      column: $state.table.typicalAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get billingCycle => $state.composableBuilder(
      column: $state.table.billingCycle,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get firstSeenDate => $state.composableBuilder(
      column: $state.table.firstSeenDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastSeenDate => $state.composableBuilder(
      column: $state.table.lastSeenDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get logoUrl => $state.composableBuilder(
      column: $state.table.logoUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter paymentsRefs(
      ComposableFilter Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.payments,
        getReferencedColumn: (t) => t.subscriptionId,
        builder: (joinBuilder, parentComposers) =>
            $$PaymentsTableFilterComposer(ComposerState(
                $state.db, $state.db.payments, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$SubscriptionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get serviceName => $state.composableBuilder(
      column: $state.table.serviceName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get serviceCategory => $state.composableBuilder(
      column: $state.table.serviceCategory,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get senderEmail => $state.composableBuilder(
      column: $state.table.senderEmail,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get senderDomain => $state.composableBuilder(
      column: $state.table.senderDomain,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get typicalAmount => $state.composableBuilder(
      column: $state.table.typicalAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get billingCycle => $state.composableBuilder(
      column: $state.table.billingCycle,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get firstSeenDate => $state.composableBuilder(
      column: $state.table.firstSeenDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastSeenDate => $state.composableBuilder(
      column: $state.table.lastSeenDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get logoUrl => $state.composableBuilder(
      column: $state.table.logoUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int subscriptionId,
  required double amount,
  required String currency,
  required DateTime paymentDate,
  required String gmailMessageId,
  Value<String?> emailSubject,
  Value<String> confidence,
  Value<bool> isVerified,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> subscriptionId,
  Value<double> amount,
  Value<String> currency,
  Value<DateTime> paymentDate,
  Value<String> gmailMessageId,
  Value<String?> emailSubject,
  Value<String> confidence,
  Value<bool> isVerified,
});

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PaymentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PaymentsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> subscriptionId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<DateTime> paymentDate = const Value.absent(),
            Value<String> gmailMessageId = const Value.absent(),
            Value<String?> emailSubject = const Value.absent(),
            Value<String> confidence = const Value.absent(),
            Value<bool> isVerified = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            subscriptionId: subscriptionId,
            amount: amount,
            currency: currency,
            paymentDate: paymentDate,
            gmailMessageId: gmailMessageId,
            emailSubject: emailSubject,
            confidence: confidence,
            isVerified: isVerified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int subscriptionId,
            required double amount,
            required String currency,
            required DateTime paymentDate,
            required String gmailMessageId,
            Value<String?> emailSubject = const Value.absent(),
            Value<String> confidence = const Value.absent(),
            Value<bool> isVerified = const Value.absent(),
          }) =>
              PaymentsCompanion.insert(
            id: id,
            subscriptionId: subscriptionId,
            amount: amount,
            currency: currency,
            paymentDate: paymentDate,
            gmailMessageId: gmailMessageId,
            emailSubject: emailSubject,
            confidence: confidence,
            isVerified: isVerified,
          ),
        ));
}

class $$PaymentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get paymentDate => $state.composableBuilder(
      column: $state.table.paymentDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get gmailMessageId => $state.composableBuilder(
      column: $state.table.gmailMessageId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get emailSubject => $state.composableBuilder(
      column: $state.table.emailSubject,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get confidence => $state.composableBuilder(
      column: $state.table.confidence,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isVerified => $state.composableBuilder(
      column: $state.table.isVerified,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SubscriptionsTableFilterComposer get subscriptionId {
    final $$SubscriptionsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subscriptionId,
        referencedTable: $state.db.subscriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SubscriptionsTableFilterComposer(ComposerState($state.db,
                $state.db.subscriptions, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get paymentDate => $state.composableBuilder(
      column: $state.table.paymentDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get gmailMessageId => $state.composableBuilder(
      column: $state.table.gmailMessageId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get emailSubject => $state.composableBuilder(
      column: $state.table.emailSubject,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get confidence => $state.composableBuilder(
      column: $state.table.confidence,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isVerified => $state.composableBuilder(
      column: $state.table.isVerified,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SubscriptionsTableOrderingComposer get subscriptionId {
    final $$SubscriptionsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.subscriptionId,
            referencedTable: $state.db.subscriptions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$SubscriptionsTableOrderingComposer(ComposerState($state.db,
                    $state.db.subscriptions, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ScanMetadataTableCreateCompanionBuilder = ScanMetadataCompanion
    Function({
  Value<int> id,
  required DateTime scanDate,
  required int emailsScanned,
  required int subscriptionsFound,
  required int paymentsFound,
  Value<String?> lastMessageId,
});
typedef $$ScanMetadataTableUpdateCompanionBuilder = ScanMetadataCompanion
    Function({
  Value<int> id,
  Value<DateTime> scanDate,
  Value<int> emailsScanned,
  Value<int> subscriptionsFound,
  Value<int> paymentsFound,
  Value<String?> lastMessageId,
});

class $$ScanMetadataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScanMetadataTable,
    ScanMetadataData,
    $$ScanMetadataTableFilterComposer,
    $$ScanMetadataTableOrderingComposer,
    $$ScanMetadataTableCreateCompanionBuilder,
    $$ScanMetadataTableUpdateCompanionBuilder> {
  $$ScanMetadataTableTableManager(_$AppDatabase db, $ScanMetadataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ScanMetadataTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ScanMetadataTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> scanDate = const Value.absent(),
            Value<int> emailsScanned = const Value.absent(),
            Value<int> subscriptionsFound = const Value.absent(),
            Value<int> paymentsFound = const Value.absent(),
            Value<String?> lastMessageId = const Value.absent(),
          }) =>
              ScanMetadataCompanion(
            id: id,
            scanDate: scanDate,
            emailsScanned: emailsScanned,
            subscriptionsFound: subscriptionsFound,
            paymentsFound: paymentsFound,
            lastMessageId: lastMessageId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime scanDate,
            required int emailsScanned,
            required int subscriptionsFound,
            required int paymentsFound,
            Value<String?> lastMessageId = const Value.absent(),
          }) =>
              ScanMetadataCompanion.insert(
            id: id,
            scanDate: scanDate,
            emailsScanned: emailsScanned,
            subscriptionsFound: subscriptionsFound,
            paymentsFound: paymentsFound,
            lastMessageId: lastMessageId,
          ),
        ));
}

class $$ScanMetadataTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ScanMetadataTable> {
  $$ScanMetadataTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get scanDate => $state.composableBuilder(
      column: $state.table.scanDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get emailsScanned => $state.composableBuilder(
      column: $state.table.emailsScanned,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get subscriptionsFound => $state.composableBuilder(
      column: $state.table.subscriptionsFound,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paymentsFound => $state.composableBuilder(
      column: $state.table.paymentsFound,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lastMessageId => $state.composableBuilder(
      column: $state.table.lastMessageId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ScanMetadataTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ScanMetadataTable> {
  $$ScanMetadataTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get scanDate => $state.composableBuilder(
      column: $state.table.scanDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get emailsScanned => $state.composableBuilder(
      column: $state.table.emailsScanned,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get subscriptionsFound => $state.composableBuilder(
      column: $state.table.subscriptionsFound,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paymentsFound => $state.composableBuilder(
      column: $state.table.paymentsFound,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lastMessageId => $state.composableBuilder(
      column: $state.table.lastMessageId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$ScanMetadataTableTableManager get scanMetadata =>
      $$ScanMetadataTableTableManager(_db, _db.scanMetadata);
}
