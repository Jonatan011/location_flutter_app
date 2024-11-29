// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $LocationsTable extends Locations with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>('name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50), type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude =
      GeneratedColumn<double>('latitude', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude =
      GeneratedColumn<double>('longitude', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _photosMeta = const VerificationMeta('photos');
  @override
  late final GeneratedColumn<String> photos =
      GeneratedColumn<String>('photos', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description =
      GeneratedColumn<String>('description', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>('is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, name, latitude, longitude, photos, description, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(Insertable<Location> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta, latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta, longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('photos')) {
      context.handle(_photosMeta, photos.isAcceptableOrUnknown(data['photos']!, _photosMeta));
    } else if (isInserting) {
      context.missing(_photosMeta);
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(_isFavoriteMeta, isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      latitude: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      photos: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}photos'])!,
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description']),
      isFavorite: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String photos;
  final String? description;
  final bool isFavorite;
  const Location(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.photos,
      this.description,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['photos'] = Variable<String>(photos);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      photos: Value(photos),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
      isFavorite: Value(isFavorite),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      photos: serializer.fromJson<String>(json['photos']),
      description: serializer.fromJson<String?>(json['description']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'photos': serializer.toJson<String>(photos),
      'description': serializer.toJson<String?>(description),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Location copyWith(
          {int? id,
          String? name,
          double? latitude,
          double? longitude,
          String? photos,
          Value<String?> description = const Value.absent(),
          bool? isFavorite}) =>
      Location(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        photos: photos ?? this.photos,
        description: description.present ? description.value : this.description,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      photos: data.photos.present ? data.photos.value : this.photos,
      description: data.description.present ? data.description.value : this.description,
      isFavorite: data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('photos: $photos, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, latitude, longitude, photos, description, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.photos == this.photos &&
          other.description == this.description &&
          other.isFavorite == this.isFavorite);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> photos;
  final Value<String?> description;
  final Value<bool> isFavorite;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.photos = const Value.absent(),
    this.description = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  LocationsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double latitude,
    required double longitude,
    required String photos,
    this.description = const Value.absent(),
    this.isFavorite = const Value.absent(),
  })  : name = Value(name),
        latitude = Value(latitude),
        longitude = Value(longitude),
        photos = Value(photos);
  static Insertable<Location> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? photos,
    Expression<String>? description,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (photos != null) 'photos': photos,
      if (description != null) 'description': description,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  LocationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String>? photos,
      Value<String?>? description,
      Value<bool>? isFavorite}) {
    return LocationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photos: photos ?? this.photos,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (photos.present) {
      map['photos'] = Variable<String>(photos.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('photos: $photos, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $FriendsTable extends Friends with TableInfo<$FriendsTable, Friend> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>('first_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50), type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>('last_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50), type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email =
      GeneratedColumn<String>('email', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber =
      GeneratedColumn<String>('phone_number', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo =
      GeneratedColumn<String>('photo', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, firstName, lastName, email, phoneNumber, photo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friends';
  @override
  VerificationContext validateIntegrity(Insertable<Friend> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta, firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta, lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(_emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(_phoneNumberMeta, phoneNumber.isAcceptableOrUnknown(data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(_photoMeta, photo.isAcceptableOrUnknown(data['photo']!, _photoMeta));
    } else if (isInserting) {
      context.missing(_photoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Friend map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Friend(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      email: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      phoneNumber: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      photo: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}photo'])!,
    );
  }

  @override
  $FriendsTable createAlias(String alias) {
    return $FriendsTable(attachedDatabase, alias);
  }
}

class Friend extends DataClass implements Insertable<Friend> {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String photo;
  const Friend(
      {required this.id, required this.firstName, required this.lastName, required this.email, required this.phoneNumber, required this.photo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['photo'] = Variable<String>(photo);
    return map;
  }

  FriendsCompanion toCompanion(bool nullToAbsent) {
    return FriendsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      phoneNumber: Value(phoneNumber),
      photo: Value(photo),
    );
  }

  factory Friend.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Friend(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      photo: serializer.fromJson<String>(json['photo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'photo': serializer.toJson<String>(photo),
    };
  }

  Friend copyWith({int? id, String? firstName, String? lastName, String? email, String? phoneNumber, String? photo}) => Friend(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photo: photo ?? this.photo,
      );
  Friend copyWithCompanion(FriendsCompanion data) {
    return Friend(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phoneNumber: data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      photo: data.photo.present ? data.photo.value : this.photo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Friend(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, email, phoneNumber, photo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Friend &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.photo == this.photo);
}

class FriendsCompanion extends UpdateCompanion<Friend> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String> phoneNumber;
  final Value<String> photo;
  const FriendsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.photo = const Value.absent(),
  });
  FriendsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String photo,
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        email = Value(email),
        phoneNumber = Value(phoneNumber),
        photo = Value(photo);
  static Insertable<Friend> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phoneNumber,
    Expression<String>? photo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (photo != null) 'photo': photo,
    });
  }

  FriendsCompanion copyWith(
      {Value<int>? id, Value<String>? firstName, Value<String>? lastName, Value<String>? email, Value<String>? phoneNumber, Value<String>? photo}) {
    return FriendsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photo: photo ?? this.photo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }
}

class $FriendLocationRelationsTable extends FriendLocationRelations with TableInfo<$FriendLocationRelationsTable, FriendLocationRelation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendLocationRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _friendIdMeta = const VerificationMeta('friendId');
  @override
  late final GeneratedColumn<int> friendId = GeneratedColumn<int>('friend_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'REFERENCES friends(id) ON DELETE CASCADE NOT NULL');
  static const VerificationMeta _locationIdMeta = const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<int> locationId = GeneratedColumn<int>('location_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'REFERENCES locations(id) ON DELETE CASCADE NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, friendId, locationId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_location_relations';
  @override
  VerificationContext validateIntegrity(Insertable<FriendLocationRelation> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('friend_id')) {
      context.handle(_friendIdMeta, friendId.isAcceptableOrUnknown(data['friend_id']!, _friendIdMeta));
    } else if (isInserting) {
      context.missing(_friendIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(_locationIdMeta, locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta));
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FriendLocationRelation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendLocationRelation(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      friendId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}friend_id'])!,
      locationId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}location_id'])!,
    );
  }

  @override
  $FriendLocationRelationsTable createAlias(String alias) {
    return $FriendLocationRelationsTable(attachedDatabase, alias);
  }
}

class FriendLocationRelation extends DataClass implements Insertable<FriendLocationRelation> {
  final int id;
  final int friendId;
  final int locationId;
  const FriendLocationRelation({required this.id, required this.friendId, required this.locationId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['friend_id'] = Variable<int>(friendId);
    map['location_id'] = Variable<int>(locationId);
    return map;
  }

  FriendLocationRelationsCompanion toCompanion(bool nullToAbsent) {
    return FriendLocationRelationsCompanion(
      id: Value(id),
      friendId: Value(friendId),
      locationId: Value(locationId),
    );
  }

  factory FriendLocationRelation.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendLocationRelation(
      id: serializer.fromJson<int>(json['id']),
      friendId: serializer.fromJson<int>(json['friendId']),
      locationId: serializer.fromJson<int>(json['locationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'friendId': serializer.toJson<int>(friendId),
      'locationId': serializer.toJson<int>(locationId),
    };
  }

  FriendLocationRelation copyWith({int? id, int? friendId, int? locationId}) => FriendLocationRelation(
        id: id ?? this.id,
        friendId: friendId ?? this.friendId,
        locationId: locationId ?? this.locationId,
      );
  FriendLocationRelation copyWithCompanion(FriendLocationRelationsCompanion data) {
    return FriendLocationRelation(
      id: data.id.present ? data.id.value : this.id,
      friendId: data.friendId.present ? data.friendId.value : this.friendId,
      locationId: data.locationId.present ? data.locationId.value : this.locationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendLocationRelation(')
          ..write('id: $id, ')
          ..write('friendId: $friendId, ')
          ..write('locationId: $locationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, friendId, locationId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendLocationRelation && other.id == this.id && other.friendId == this.friendId && other.locationId == this.locationId);
}

class FriendLocationRelationsCompanion extends UpdateCompanion<FriendLocationRelation> {
  final Value<int> id;
  final Value<int> friendId;
  final Value<int> locationId;
  const FriendLocationRelationsCompanion({
    this.id = const Value.absent(),
    this.friendId = const Value.absent(),
    this.locationId = const Value.absent(),
  });
  FriendLocationRelationsCompanion.insert({
    this.id = const Value.absent(),
    required int friendId,
    required int locationId,
  })  : friendId = Value(friendId),
        locationId = Value(locationId);
  static Insertable<FriendLocationRelation> custom({
    Expression<int>? id,
    Expression<int>? friendId,
    Expression<int>? locationId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (friendId != null) 'friend_id': friendId,
      if (locationId != null) 'location_id': locationId,
    });
  }

  FriendLocationRelationsCompanion copyWith({Value<int>? id, Value<int>? friendId, Value<int>? locationId}) {
    return FriendLocationRelationsCompanion(
      id: id ?? this.id,
      friendId: friendId ?? this.friendId,
      locationId: locationId ?? this.locationId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (friendId.present) {
      map['friend_id'] = Variable<int>(friendId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<int>(locationId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendLocationRelationsCompanion(')
          ..write('id: $id, ')
          ..write('friendId: $friendId, ')
          ..write('locationId: $locationId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $FriendsTable friends = $FriendsTable(this);
  late final $FriendLocationRelationsTable friendLocationRelations = $FriendLocationRelationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [locations, friends, friendLocationRelations];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('friends', limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('friend_location_relations', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('locations', limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('friend_location_relations', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$LocationsTableCreateCompanionBuilder = LocationsCompanion Function({
  Value<int> id,
  required String name,
  required double latitude,
  required double longitude,
  required String photos,
  Value<String?> description,
  Value<bool> isFavorite,
});
typedef $$LocationsTableUpdateCompanionBuilder = LocationsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<double> latitude,
  Value<double> longitude,
  Value<String> photos,
  Value<String?> description,
  Value<bool> isFavorite,
});

final class $$LocationsTableReferences extends BaseReferences<_$AppDatabase, $LocationsTable, Location> {
  $$LocationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FriendLocationRelationsTable, List<FriendLocationRelation>> _friendLocationRelationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.friendLocationRelations,
          aliasName: $_aliasNameGenerator(db.locations.id, db.friendLocationRelations.locationId));

  $$FriendLocationRelationsTableProcessedTableManager get friendLocationRelationsRefs {
    final manager = $$FriendLocationRelationsTableTableManager($_db, $_db.friendLocationRelations).filter((f) => f.locationId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_friendLocationRelationsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LocationsTableFilterComposer extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photos => $composableBuilder(column: $table.photos, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  Expression<bool> friendLocationRelationsRefs(Expression<bool> Function($$FriendLocationRelationsTableFilterComposer f) f) {
    final $$FriendLocationRelationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.friendLocationRelations,
        getReferencedColumn: (t) => t.locationId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FriendLocationRelationsTableFilterComposer(
              $db: $db,
              $table: $db.friendLocationRelations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocationsTableOrderingComposer extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photos => $composableBuilder(column: $table.photos, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(column: $table.isFavorite, builder: (column) => ColumnOrderings(column));
}

class $$LocationsTableAnnotationComposer extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get latitude => $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude => $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get photos => $composableBuilder(column: $table.photos, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(column: $table.isFavorite, builder: (column) => column);

  Expression<T> friendLocationRelationsRefs<T extends Object>(Expression<T> Function($$FriendLocationRelationsTableAnnotationComposer a) f) {
    final $$FriendLocationRelationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.friendLocationRelations,
        getReferencedColumn: (t) => t.locationId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$FriendLocationRelationsTableAnnotationComposer(
              $db: $db,
              $table: $db.friendLocationRelations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocationsTable,
    Location,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (Location, $$LocationsTableReferences),
    Location,
    PrefetchHooks Function({bool friendLocationRelationsRefs})> {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String> photos = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
          }) =>
              LocationsCompanion(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
            photos: photos,
            description: description,
            isFavorite: isFavorite,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required double latitude,
            required double longitude,
            required String photos,
            Value<String?> description = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
          }) =>
              LocationsCompanion.insert(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
            photos: photos,
            description: description,
            isFavorite: isFavorite,
          ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$LocationsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({friendLocationRelationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (friendLocationRelationsRefs) db.friendLocationRelations],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (friendLocationRelationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$LocationsTableReferences._friendLocationRelationsRefsTable(db),
                        managerFromTypedResult: (p0) => $$LocationsTableReferences(db, table, p0).friendLocationRelationsRefs,
                        referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.locationId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocationsTable,
    Location,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (Location, $$LocationsTableReferences),
    Location,
    PrefetchHooks Function({bool friendLocationRelationsRefs})>;
typedef $$FriendsTableCreateCompanionBuilder = FriendsCompanion Function({
  Value<int> id,
  required String firstName,
  required String lastName,
  required String email,
  required String phoneNumber,
  required String photo,
});
typedef $$FriendsTableUpdateCompanionBuilder = FriendsCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> email,
  Value<String> phoneNumber,
  Value<String> photo,
});

final class $$FriendsTableReferences extends BaseReferences<_$AppDatabase, $FriendsTable, Friend> {
  $$FriendsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FriendLocationRelationsTable, List<FriendLocationRelation>> _friendLocationRelationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.friendLocationRelations, aliasName: $_aliasNameGenerator(db.friends.id, db.friendLocationRelations.friendId));

  $$FriendLocationRelationsTableProcessedTableManager get friendLocationRelationsRefs {
    final manager = $$FriendLocationRelationsTableTableManager($_db, $_db.friendLocationRelations).filter((f) => f.friendId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_friendLocationRelationsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FriendsTableFilterComposer extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photo => $composableBuilder(column: $table.photo, builder: (column) => ColumnFilters(column));

  Expression<bool> friendLocationRelationsRefs(Expression<bool> Function($$FriendLocationRelationsTableFilterComposer f) f) {
    final $$FriendLocationRelationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.friendLocationRelations,
        getReferencedColumn: (t) => t.friendId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FriendLocationRelationsTableFilterComposer(
              $db: $db,
              $table: $db.friendLocationRelations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FriendsTableOrderingComposer extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photo => $composableBuilder(column: $table.photo, builder: (column) => ColumnOrderings(column));
}

class $$FriendsTableAnnotationComposer extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName => $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName => $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email => $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get photo => $composableBuilder(column: $table.photo, builder: (column) => column);

  Expression<T> friendLocationRelationsRefs<T extends Object>(Expression<T> Function($$FriendLocationRelationsTableAnnotationComposer a) f) {
    final $$FriendLocationRelationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.friendLocationRelations,
        getReferencedColumn: (t) => t.friendId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$FriendLocationRelationsTableAnnotationComposer(
              $db: $db,
              $table: $db.friendLocationRelations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FriendsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendsTable,
    Friend,
    $$FriendsTableFilterComposer,
    $$FriendsTableOrderingComposer,
    $$FriendsTableAnnotationComposer,
    $$FriendsTableCreateCompanionBuilder,
    $$FriendsTableUpdateCompanionBuilder,
    (Friend, $$FriendsTableReferences),
    Friend,
    PrefetchHooks Function({bool friendLocationRelationsRefs})> {
  $$FriendsTableTableManager(_$AppDatabase db, $FriendsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$FriendsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$FriendsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$FriendsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> phoneNumber = const Value.absent(),
            Value<String> photo = const Value.absent(),
          }) =>
              FriendsCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            photo: photo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String firstName,
            required String lastName,
            required String email,
            required String phoneNumber,
            required String photo,
          }) =>
              FriendsCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            photo: photo,
          ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$FriendsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({friendLocationRelationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (friendLocationRelationsRefs) db.friendLocationRelations],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (friendLocationRelationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$FriendsTableReferences._friendLocationRelationsRefsTable(db),
                        managerFromTypedResult: (p0) => $$FriendsTableReferences(db, table, p0).friendLocationRelationsRefs,
                        referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.friendId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FriendsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendsTable,
    Friend,
    $$FriendsTableFilterComposer,
    $$FriendsTableOrderingComposer,
    $$FriendsTableAnnotationComposer,
    $$FriendsTableCreateCompanionBuilder,
    $$FriendsTableUpdateCompanionBuilder,
    (Friend, $$FriendsTableReferences),
    Friend,
    PrefetchHooks Function({bool friendLocationRelationsRefs})>;
typedef $$FriendLocationRelationsTableCreateCompanionBuilder = FriendLocationRelationsCompanion Function({
  Value<int> id,
  required int friendId,
  required int locationId,
});
typedef $$FriendLocationRelationsTableUpdateCompanionBuilder = FriendLocationRelationsCompanion Function({
  Value<int> id,
  Value<int> friendId,
  Value<int> locationId,
});

final class $$FriendLocationRelationsTableReferences extends BaseReferences<_$AppDatabase, $FriendLocationRelationsTable, FriendLocationRelation> {
  $$FriendLocationRelationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FriendsTable _friendIdTable(_$AppDatabase db) =>
      db.friends.createAlias($_aliasNameGenerator(db.friendLocationRelations.friendId, db.friends.id));

  $$FriendsTableProcessedTableManager? get friendId {
    final manager = $$FriendsTableTableManager($_db, $_db.friends).filter((f) => f.id($_item.friendId));
    final item = $_typedResult.readTableOrNull(_friendIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LocationsTable _locationIdTable(_$AppDatabase db) =>
      db.locations.createAlias($_aliasNameGenerator(db.friendLocationRelations.locationId, db.locations.id));

  $$LocationsTableProcessedTableManager? get locationId {
    final manager = $$LocationsTableTableManager($_db, $_db.locations).filter((f) => f.id($_item.locationId));
    final item = $_typedResult.readTableOrNull(_locationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FriendLocationRelationsTableFilterComposer extends Composer<_$AppDatabase, $FriendLocationRelationsTable> {
  $$FriendLocationRelationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  $$FriendsTableFilterComposer get friendId {
    final $$FriendsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.friendId,
        referencedTable: $db.friends,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FriendsTableFilterComposer(
              $db: $db,
              $table: $db.friends,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationsTableFilterComposer get locationId {
    final $$LocationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$LocationsTableFilterComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FriendLocationRelationsTableOrderingComposer extends Composer<_$AppDatabase, $FriendLocationRelationsTable> {
  $$FriendLocationRelationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  $$FriendsTableOrderingComposer get friendId {
    final $$FriendsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.friendId,
        referencedTable: $db.friends,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FriendsTableOrderingComposer(
              $db: $db,
              $table: $db.friends,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationsTableOrderingComposer get locationId {
    final $$LocationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$LocationsTableOrderingComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FriendLocationRelationsTableAnnotationComposer extends Composer<_$AppDatabase, $FriendLocationRelationsTable> {
  $$FriendLocationRelationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  $$FriendsTableAnnotationComposer get friendId {
    final $$FriendsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.friendId,
        referencedTable: $db.friends,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FriendsTableAnnotationComposer(
              $db: $db,
              $table: $db.friends,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationsTableAnnotationComposer get locationId {
    final $$LocationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$LocationsTableAnnotationComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FriendLocationRelationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendLocationRelationsTable,
    FriendLocationRelation,
    $$FriendLocationRelationsTableFilterComposer,
    $$FriendLocationRelationsTableOrderingComposer,
    $$FriendLocationRelationsTableAnnotationComposer,
    $$FriendLocationRelationsTableCreateCompanionBuilder,
    $$FriendLocationRelationsTableUpdateCompanionBuilder,
    (FriendLocationRelation, $$FriendLocationRelationsTableReferences),
    FriendLocationRelation,
    PrefetchHooks Function({bool friendId, bool locationId})> {
  $$FriendLocationRelationsTableTableManager(_$AppDatabase db, $FriendLocationRelationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$FriendLocationRelationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$FriendLocationRelationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$FriendLocationRelationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> friendId = const Value.absent(),
            Value<int> locationId = const Value.absent(),
          }) =>
              FriendLocationRelationsCompanion(
            id: id,
            friendId: friendId,
            locationId: locationId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int friendId,
            required int locationId,
          }) =>
              FriendLocationRelationsCompanion.insert(
            id: id,
            friendId: friendId,
            locationId: locationId,
          ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$FriendLocationRelationsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({friendId = false, locationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic>>(state) {
                if (friendId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.friendId,
                    referencedTable: $$FriendLocationRelationsTableReferences._friendIdTable(db),
                    referencedColumn: $$FriendLocationRelationsTableReferences._friendIdTable(db).id,
                  ) as T;
                }
                if (locationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.locationId,
                    referencedTable: $$FriendLocationRelationsTableReferences._locationIdTable(db),
                    referencedColumn: $$FriendLocationRelationsTableReferences._locationIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FriendLocationRelationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendLocationRelationsTable,
    FriendLocationRelation,
    $$FriendLocationRelationsTableFilterComposer,
    $$FriendLocationRelationsTableOrderingComposer,
    $$FriendLocationRelationsTableAnnotationComposer,
    $$FriendLocationRelationsTableCreateCompanionBuilder,
    $$FriendLocationRelationsTableUpdateCompanionBuilder,
    (FriendLocationRelation, $$FriendLocationRelationsTableReferences),
    FriendLocationRelation,
    PrefetchHooks Function({bool friendId, bool locationId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocationsTableTableManager get locations => $$LocationsTableTableManager(_db, _db.locations);
  $$FriendsTableTableManager get friends => $$FriendsTableTableManager(_db, _db.friends);
  $$FriendLocationRelationsTableTableManager get friendLocationRelations =>
      $$FriendLocationRelationsTableTableManager(_db, _db.friendLocationRelations);
}
