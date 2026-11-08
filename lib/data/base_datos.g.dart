// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_datos.dart';

// ignore_for_file: type=lint
class $MecanicosTable extends Mecanicos
    with TableInfo<$MecanicosTable, MecanicoFila> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MecanicosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _especialidadMeta = const VerificationMeta(
    'especialidad',
  );
  @override
  late final GeneratedColumn<String> especialidad = GeneratedColumn<String>(
    'especialidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, especialidad];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mecanicos';
  @override
  VerificationContext validateIntegrity(
    Insertable<MecanicoFila> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('especialidad')) {
      context.handle(
        _especialidadMeta,
        especialidad.isAcceptableOrUnknown(
          data['especialidad']!,
          _especialidadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_especialidadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MecanicoFila map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MecanicoFila(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      especialidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}especialidad'],
      )!,
    );
  }

  @override
  $MecanicosTable createAlias(String alias) {
    return $MecanicosTable(attachedDatabase, alias);
  }
}

class MecanicoFila extends DataClass implements Insertable<MecanicoFila> {
  final String id;
  final String nombre;
  final String especialidad;
  const MecanicoFila({
    required this.id,
    required this.nombre,
    required this.especialidad,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['especialidad'] = Variable<String>(especialidad);
    return map;
  }

  MecanicosCompanion toCompanion(bool nullToAbsent) {
    return MecanicosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      especialidad: Value(especialidad),
    );
  }

  factory MecanicoFila.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MecanicoFila(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      especialidad: serializer.fromJson<String>(json['especialidad']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'especialidad': serializer.toJson<String>(especialidad),
    };
  }

  MecanicoFila copyWith({String? id, String? nombre, String? especialidad}) =>
      MecanicoFila(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        especialidad: especialidad ?? this.especialidad,
      );
  MecanicoFila copyWithCompanion(MecanicosCompanion data) {
    return MecanicoFila(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      especialidad: data.especialidad.present
          ? data.especialidad.value
          : this.especialidad,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MecanicoFila(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('especialidad: $especialidad')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, especialidad);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MecanicoFila &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.especialidad == this.especialidad);
}

class MecanicosCompanion extends UpdateCompanion<MecanicoFila> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> especialidad;
  final Value<int> rowid;
  const MecanicosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.especialidad = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MecanicosCompanion.insert({
    required String id,
    required String nombre,
    required String especialidad,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       especialidad = Value(especialidad);
  static Insertable<MecanicoFila> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? especialidad,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (especialidad != null) 'especialidad': especialidad,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MecanicosCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<String>? especialidad,
    Value<int>? rowid,
  }) {
    return MecanicosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      especialidad: especialidad ?? this.especialidad,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (especialidad.present) {
      map['especialidad'] = Variable<String>(especialidad.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MecanicosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('especialidad: $especialidad, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientesTable extends Clientes
    with TableInfo<$ClientesTable, ClienteFila> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    telefono,
    direccion,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClienteFila> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClienteFila map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClienteFila(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      ),
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class ClienteFila extends DataClass implements Insertable<ClienteFila> {
  final String id;
  final String nombre;
  final String telefono;
  final String? direccion;
  final DateTime creadoEn;
  const ClienteFila({
    required this.id,
    required this.nombre,
    required this.telefono,
    this.direccion,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['telefono'] = Variable<String>(telefono);
    if (!nullToAbsent || direccion != null) {
      map['direccion'] = Variable<String>(direccion);
    }
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      telefono: Value(telefono),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      creadoEn: Value(creadoEn),
    );
  }

  factory ClienteFila.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClienteFila(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      telefono: serializer.fromJson<String>(json['telefono']),
      direccion: serializer.fromJson<String?>(json['direccion']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'telefono': serializer.toJson<String>(telefono),
      'direccion': serializer.toJson<String?>(direccion),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  ClienteFila copyWith({
    String? id,
    String? nombre,
    String? telefono,
    Value<String?> direccion = const Value.absent(),
    DateTime? creadoEn,
  }) => ClienteFila(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    telefono: telefono ?? this.telefono,
    direccion: direccion.present ? direccion.value : this.direccion,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  ClienteFila copyWithCompanion(ClientesCompanion data) {
    return ClienteFila(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClienteFila(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('direccion: $direccion, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, telefono, direccion, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClienteFila &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.telefono == this.telefono &&
          other.direccion == this.direccion &&
          other.creadoEn == this.creadoEn);
}

class ClientesCompanion extends UpdateCompanion<ClienteFila> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> telefono;
  final Value<String?> direccion;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const ClientesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.telefono = const Value.absent(),
    this.direccion = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientesCompanion.insert({
    required String id,
    required String nombre,
    required String telefono,
    this.direccion = const Value.absent(),
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       telefono = Value(telefono),
       creadoEn = Value(creadoEn);
  static Insertable<ClienteFila> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? telefono,
    Expression<String>? direccion,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (telefono != null) 'telefono': telefono,
      if (direccion != null) 'direccion': direccion,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientesCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<String>? telefono,
    Value<String?>? direccion,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return ClientesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      direccion: direccion ?? this.direccion,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('direccion: $direccion, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiculosTable extends Vehiculos
    with TableInfo<$VehiculosTable, VehiculoFila> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiculosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idClienteMeta = const VerificationMeta(
    'idCliente',
  );
  @override
  late final GeneratedColumn<String> idCliente = GeneratedColumn<String>(
    'id_cliente',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES clientes(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _matriculaMeta = const VerificationMeta(
    'matricula',
  );
  @override
  late final GeneratedColumn<String> matricula = GeneratedColumn<String>(
    'matricula',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
    'marca',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
    'modelo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
    'anio',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kilometrajeMeta = const VerificationMeta(
    'kilometraje',
  );
  @override
  late final GeneratedColumn<int> kilometraje = GeneratedColumn<int>(
    'kilometraje',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idCliente,
    matricula,
    marca,
    modelo,
    anio,
    kilometraje,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehiculos';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehiculoFila> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('id_cliente')) {
      context.handle(
        _idClienteMeta,
        idCliente.isAcceptableOrUnknown(data['id_cliente']!, _idClienteMeta),
      );
    } else if (isInserting) {
      context.missing(_idClienteMeta);
    }
    if (data.containsKey('matricula')) {
      context.handle(
        _matriculaMeta,
        matricula.isAcceptableOrUnknown(data['matricula']!, _matriculaMeta),
      );
    } else if (isInserting) {
      context.missing(_matriculaMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
        _marcaMeta,
        marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta),
      );
    } else if (isInserting) {
      context.missing(_marcaMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(
        _modeloMeta,
        modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta),
      );
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('anio')) {
      context.handle(
        _anioMeta,
        anio.isAcceptableOrUnknown(data['anio']!, _anioMeta),
      );
    } else if (isInserting) {
      context.missing(_anioMeta);
    }
    if (data.containsKey('kilometraje')) {
      context.handle(
        _kilometrajeMeta,
        kilometraje.isAcceptableOrUnknown(
          data['kilometraje']!,
          _kilometrajeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kilometrajeMeta);
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualizadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehiculoFila map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehiculoFila(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      idCliente: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_cliente'],
      )!,
      matricula: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matricula'],
      )!,
      marca: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marca'],
      )!,
      modelo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modelo'],
      )!,
      anio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anio'],
      )!,
      kilometraje: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kilometraje'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $VehiculosTable createAlias(String alias) {
    return $VehiculosTable(attachedDatabase, alias);
  }
}

class VehiculoFila extends DataClass implements Insertable<VehiculoFila> {
  final String id;
  final String idCliente;
  final String matricula;
  final String marca;
  final String modelo;
  final int anio;
  final int kilometraje;
  final DateTime actualizadoEn;
  const VehiculoFila({
    required this.id,
    required this.idCliente,
    required this.matricula,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.kilometraje,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['id_cliente'] = Variable<String>(idCliente);
    map['matricula'] = Variable<String>(matricula);
    map['marca'] = Variable<String>(marca);
    map['modelo'] = Variable<String>(modelo);
    map['anio'] = Variable<int>(anio);
    map['kilometraje'] = Variable<int>(kilometraje);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  VehiculosCompanion toCompanion(bool nullToAbsent) {
    return VehiculosCompanion(
      id: Value(id),
      idCliente: Value(idCliente),
      matricula: Value(matricula),
      marca: Value(marca),
      modelo: Value(modelo),
      anio: Value(anio),
      kilometraje: Value(kilometraje),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory VehiculoFila.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehiculoFila(
      id: serializer.fromJson<String>(json['id']),
      idCliente: serializer.fromJson<String>(json['idCliente']),
      matricula: serializer.fromJson<String>(json['matricula']),
      marca: serializer.fromJson<String>(json['marca']),
      modelo: serializer.fromJson<String>(json['modelo']),
      anio: serializer.fromJson<int>(json['anio']),
      kilometraje: serializer.fromJson<int>(json['kilometraje']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'idCliente': serializer.toJson<String>(idCliente),
      'matricula': serializer.toJson<String>(matricula),
      'marca': serializer.toJson<String>(marca),
      'modelo': serializer.toJson<String>(modelo),
      'anio': serializer.toJson<int>(anio),
      'kilometraje': serializer.toJson<int>(kilometraje),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  VehiculoFila copyWith({
    String? id,
    String? idCliente,
    String? matricula,
    String? marca,
    String? modelo,
    int? anio,
    int? kilometraje,
    DateTime? actualizadoEn,
  }) => VehiculoFila(
    id: id ?? this.id,
    idCliente: idCliente ?? this.idCliente,
    matricula: matricula ?? this.matricula,
    marca: marca ?? this.marca,
    modelo: modelo ?? this.modelo,
    anio: anio ?? this.anio,
    kilometraje: kilometraje ?? this.kilometraje,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  VehiculoFila copyWithCompanion(VehiculosCompanion data) {
    return VehiculoFila(
      id: data.id.present ? data.id.value : this.id,
      idCliente: data.idCliente.present ? data.idCliente.value : this.idCliente,
      matricula: data.matricula.present ? data.matricula.value : this.matricula,
      marca: data.marca.present ? data.marca.value : this.marca,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      anio: data.anio.present ? data.anio.value : this.anio,
      kilometraje: data.kilometraje.present
          ? data.kilometraje.value
          : this.kilometraje,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehiculoFila(')
          ..write('id: $id, ')
          ..write('idCliente: $idCliente, ')
          ..write('matricula: $matricula, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('anio: $anio, ')
          ..write('kilometraje: $kilometraje, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idCliente,
    matricula,
    marca,
    modelo,
    anio,
    kilometraje,
    actualizadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehiculoFila &&
          other.id == this.id &&
          other.idCliente == this.idCliente &&
          other.matricula == this.matricula &&
          other.marca == this.marca &&
          other.modelo == this.modelo &&
          other.anio == this.anio &&
          other.kilometraje == this.kilometraje &&
          other.actualizadoEn == this.actualizadoEn);
}

class VehiculosCompanion extends UpdateCompanion<VehiculoFila> {
  final Value<String> id;
  final Value<String> idCliente;
  final Value<String> matricula;
  final Value<String> marca;
  final Value<String> modelo;
  final Value<int> anio;
  final Value<int> kilometraje;
  final Value<DateTime> actualizadoEn;
  final Value<int> rowid;
  const VehiculosCompanion({
    this.id = const Value.absent(),
    this.idCliente = const Value.absent(),
    this.matricula = const Value.absent(),
    this.marca = const Value.absent(),
    this.modelo = const Value.absent(),
    this.anio = const Value.absent(),
    this.kilometraje = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiculosCompanion.insert({
    required String id,
    required String idCliente,
    required String matricula,
    required String marca,
    required String modelo,
    required int anio,
    required int kilometraje,
    required DateTime actualizadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       idCliente = Value(idCliente),
       matricula = Value(matricula),
       marca = Value(marca),
       modelo = Value(modelo),
       anio = Value(anio),
       kilometraje = Value(kilometraje),
       actualizadoEn = Value(actualizadoEn);
  static Insertable<VehiculoFila> custom({
    Expression<String>? id,
    Expression<String>? idCliente,
    Expression<String>? matricula,
    Expression<String>? marca,
    Expression<String>? modelo,
    Expression<int>? anio,
    Expression<int>? kilometraje,
    Expression<DateTime>? actualizadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idCliente != null) 'id_cliente': idCliente,
      if (matricula != null) 'matricula': matricula,
      if (marca != null) 'marca': marca,
      if (modelo != null) 'modelo': modelo,
      if (anio != null) 'anio': anio,
      if (kilometraje != null) 'kilometraje': kilometraje,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiculosCompanion copyWith({
    Value<String>? id,
    Value<String>? idCliente,
    Value<String>? matricula,
    Value<String>? marca,
    Value<String>? modelo,
    Value<int>? anio,
    Value<int>? kilometraje,
    Value<DateTime>? actualizadoEn,
    Value<int>? rowid,
  }) {
    return VehiculosCompanion(
      id: id ?? this.id,
      idCliente: idCliente ?? this.idCliente,
      matricula: matricula ?? this.matricula,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      anio: anio ?? this.anio,
      kilometraje: kilometraje ?? this.kilometraje,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (idCliente.present) {
      map['id_cliente'] = Variable<String>(idCliente.value);
    }
    if (matricula.present) {
      map['matricula'] = Variable<String>(matricula.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (kilometraje.present) {
      map['kilometraje'] = Variable<int>(kilometraje.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiculosCompanion(')
          ..write('id: $id, ')
          ..write('idCliente: $idCliente, ')
          ..write('matricula: $matricula, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('anio: $anio, ')
          ..write('kilometraje: $kilometraje, ')
          ..write('actualizadoEn: $actualizadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepuestosTable extends Repuestos
    with TableInfo<$RepuestosTable, RepuestoFila> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
    'precio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _existenciasMeta = const VerificationMeta(
    'existencias',
  );
  @override
  late final GeneratedColumn<int> existencias = GeneratedColumn<int>(
    'existencias',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockMinimoMeta = const VerificationMeta(
    'stockMinimo',
  );
  @override
  late final GeneratedColumn<int> stockMinimo = GeneratedColumn<int>(
    'stock_minimo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    codigo,
    nombre,
    precio,
    existencias,
    stockMinimo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepuestoFila> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(
        _precioMeta,
        precio.isAcceptableOrUnknown(data['precio']!, _precioMeta),
      );
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('existencias')) {
      context.handle(
        _existenciasMeta,
        existencias.isAcceptableOrUnknown(
          data['existencias']!,
          _existenciasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_existenciasMeta);
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
        _stockMinimoMeta,
        stockMinimo.isAcceptableOrUnknown(
          data['stock_minimo']!,
          _stockMinimoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockMinimoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepuestoFila map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepuestoFila(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      precio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio'],
      )!,
      existencias: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}existencias'],
      )!,
      stockMinimo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_minimo'],
      )!,
    );
  }

  @override
  $RepuestosTable createAlias(String alias) {
    return $RepuestosTable(attachedDatabase, alias);
  }
}

class RepuestoFila extends DataClass implements Insertable<RepuestoFila> {
  final String id;
  final String codigo;
  final String nombre;
  final double precio;
  final int existencias;
  final int stockMinimo;
  const RepuestoFila({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.precio,
    required this.existencias,
    required this.stockMinimo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['codigo'] = Variable<String>(codigo);
    map['nombre'] = Variable<String>(nombre);
    map['precio'] = Variable<double>(precio);
    map['existencias'] = Variable<int>(existencias);
    map['stock_minimo'] = Variable<int>(stockMinimo);
    return map;
  }

  RepuestosCompanion toCompanion(bool nullToAbsent) {
    return RepuestosCompanion(
      id: Value(id),
      codigo: Value(codigo),
      nombre: Value(nombre),
      precio: Value(precio),
      existencias: Value(existencias),
      stockMinimo: Value(stockMinimo),
    );
  }

  factory RepuestoFila.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepuestoFila(
      id: serializer.fromJson<String>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      precio: serializer.fromJson<double>(json['precio']),
      existencias: serializer.fromJson<int>(json['existencias']),
      stockMinimo: serializer.fromJson<int>(json['stockMinimo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'codigo': serializer.toJson<String>(codigo),
      'nombre': serializer.toJson<String>(nombre),
      'precio': serializer.toJson<double>(precio),
      'existencias': serializer.toJson<int>(existencias),
      'stockMinimo': serializer.toJson<int>(stockMinimo),
    };
  }

  RepuestoFila copyWith({
    String? id,
    String? codigo,
    String? nombre,
    double? precio,
    int? existencias,
    int? stockMinimo,
  }) => RepuestoFila(
    id: id ?? this.id,
    codigo: codigo ?? this.codigo,
    nombre: nombre ?? this.nombre,
    precio: precio ?? this.precio,
    existencias: existencias ?? this.existencias,
    stockMinimo: stockMinimo ?? this.stockMinimo,
  );
  RepuestoFila copyWithCompanion(RepuestosCompanion data) {
    return RepuestoFila(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      precio: data.precio.present ? data.precio.value : this.precio,
      existencias: data.existencias.present
          ? data.existencias.value
          : this.existencias,
      stockMinimo: data.stockMinimo.present
          ? data.stockMinimo.value
          : this.stockMinimo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepuestoFila(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('precio: $precio, ')
          ..write('existencias: $existencias, ')
          ..write('stockMinimo: $stockMinimo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, codigo, nombre, precio, existencias, stockMinimo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepuestoFila &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.nombre == this.nombre &&
          other.precio == this.precio &&
          other.existencias == this.existencias &&
          other.stockMinimo == this.stockMinimo);
}

class RepuestosCompanion extends UpdateCompanion<RepuestoFila> {
  final Value<String> id;
  final Value<String> codigo;
  final Value<String> nombre;
  final Value<double> precio;
  final Value<int> existencias;
  final Value<int> stockMinimo;
  final Value<int> rowid;
  const RepuestosCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.precio = const Value.absent(),
    this.existencias = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepuestosCompanion.insert({
    required String id,
    required String codigo,
    required String nombre,
    required double precio,
    required int existencias,
    required int stockMinimo,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       codigo = Value(codigo),
       nombre = Value(nombre),
       precio = Value(precio),
       existencias = Value(existencias),
       stockMinimo = Value(stockMinimo);
  static Insertable<RepuestoFila> custom({
    Expression<String>? id,
    Expression<String>? codigo,
    Expression<String>? nombre,
    Expression<double>? precio,
    Expression<int>? existencias,
    Expression<int>? stockMinimo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (nombre != null) 'nombre': nombre,
      if (precio != null) 'precio': precio,
      if (existencias != null) 'existencias': existencias,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepuestosCompanion copyWith({
    Value<String>? id,
    Value<String>? codigo,
    Value<String>? nombre,
    Value<double>? precio,
    Value<int>? existencias,
    Value<int>? stockMinimo,
    Value<int>? rowid,
  }) {
    return RepuestosCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      existencias: existencias ?? this.existencias,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (existencias.present) {
      map['existencias'] = Variable<int>(existencias.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<int>(stockMinimo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('precio: $precio, ')
          ..write('existencias: $existencias, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdenesTable extends Ordenes with TableInfo<$OrdenesTable, OrdenFila> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<int> numero = GeneratedColumn<int>(
    'numero',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _idClienteMeta = const VerificationMeta(
    'idCliente',
  );
  @override
  late final GeneratedColumn<String> idCliente = GeneratedColumn<String>(
    'id_cliente',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES clientes(id) ON DELETE RESTRICT',
  );
  static const VerificationMeta _idVehiculoMeta = const VerificationMeta(
    'idVehiculo',
  );
  @override
  late final GeneratedColumn<String> idVehiculo = GeneratedColumn<String>(
    'id_vehiculo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES vehiculos(id) ON DELETE RESTRICT',
  );
  static const VerificationMeta _idMecanicoMeta = const VerificationMeta(
    'idMecanico',
  );
  @override
  late final GeneratedColumn<String> idMecanico = GeneratedColumn<String>(
    'id_mecanico',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES mecanicos(id) ON DELETE RESTRICT',
  );
  static const VerificationMeta _fechaIngresoMeta = const VerificationMeta(
    'fechaIngreso',
  );
  @override
  late final GeneratedColumn<DateTime> fechaIngreso = GeneratedColumn<DateTime>(
    'fecha_ingreso',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _problemaMeta = const VerificationMeta(
    'problema',
  );
  @override
  late final GeneratedColumn<String> problema = GeneratedColumn<String>(
    'problema',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kilometrajeIngresoMeta =
      const VerificationMeta('kilometrajeIngreso');
  @override
  late final GeneratedColumn<int> kilometrajeIngreso = GeneratedColumn<int>(
    'kilometraje_ingreso',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaEntregaMeta = const VerificationMeta(
    'fechaEntrega',
  );
  @override
  late final GeneratedColumn<DateTime> fechaEntrega = GeneratedColumn<DateTime>(
    'fecha_entrega',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockDevueltoMeta = const VerificationMeta(
    'stockDevuelto',
  );
  @override
  late final GeneratedColumn<bool> stockDevuelto = GeneratedColumn<bool>(
    'stock_devuelto',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("stock_devuelto" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    numero,
    idCliente,
    idVehiculo,
    idMecanico,
    fechaIngreso,
    problema,
    estado,
    kilometrajeIngreso,
    fechaEntrega,
    stockDevuelto,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordenes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrdenFila> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(
        _numeroMeta,
        numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('id_cliente')) {
      context.handle(
        _idClienteMeta,
        idCliente.isAcceptableOrUnknown(data['id_cliente']!, _idClienteMeta),
      );
    } else if (isInserting) {
      context.missing(_idClienteMeta);
    }
    if (data.containsKey('id_vehiculo')) {
      context.handle(
        _idVehiculoMeta,
        idVehiculo.isAcceptableOrUnknown(data['id_vehiculo']!, _idVehiculoMeta),
      );
    } else if (isInserting) {
      context.missing(_idVehiculoMeta);
    }
    if (data.containsKey('id_mecanico')) {
      context.handle(
        _idMecanicoMeta,
        idMecanico.isAcceptableOrUnknown(data['id_mecanico']!, _idMecanicoMeta),
      );
    } else if (isInserting) {
      context.missing(_idMecanicoMeta);
    }
    if (data.containsKey('fecha_ingreso')) {
      context.handle(
        _fechaIngresoMeta,
        fechaIngreso.isAcceptableOrUnknown(
          data['fecha_ingreso']!,
          _fechaIngresoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaIngresoMeta);
    }
    if (data.containsKey('problema')) {
      context.handle(
        _problemaMeta,
        problema.isAcceptableOrUnknown(data['problema']!, _problemaMeta),
      );
    } else if (isInserting) {
      context.missing(_problemaMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('kilometraje_ingreso')) {
      context.handle(
        _kilometrajeIngresoMeta,
        kilometrajeIngreso.isAcceptableOrUnknown(
          data['kilometraje_ingreso']!,
          _kilometrajeIngresoMeta,
        ),
      );
    }
    if (data.containsKey('fecha_entrega')) {
      context.handle(
        _fechaEntregaMeta,
        fechaEntrega.isAcceptableOrUnknown(
          data['fecha_entrega']!,
          _fechaEntregaMeta,
        ),
      );
    }
    if (data.containsKey('stock_devuelto')) {
      context.handle(
        _stockDevueltoMeta,
        stockDevuelto.isAcceptableOrUnknown(
          data['stock_devuelto']!,
          _stockDevueltoMeta,
        ),
      );
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualizadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdenFila map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdenFila(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      numero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero'],
      )!,
      idCliente: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_cliente'],
      )!,
      idVehiculo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_vehiculo'],
      )!,
      idMecanico: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_mecanico'],
      )!,
      fechaIngreso: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_ingreso'],
      )!,
      problema: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}problema'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      kilometrajeIngreso: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kilometraje_ingreso'],
      ),
      fechaEntrega: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_entrega'],
      ),
      stockDevuelto: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}stock_devuelto'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $OrdenesTable createAlias(String alias) {
    return $OrdenesTable(attachedDatabase, alias);
  }
}

class OrdenFila extends DataClass implements Insertable<OrdenFila> {
  final String id;
  final int numero;
  final String idCliente;
  final String idVehiculo;
  final String idMecanico;
  final DateTime fechaIngreso;
  final String problema;
  final String estado;
  final int? kilometrajeIngreso;
  final DateTime? fechaEntrega;
  final bool stockDevuelto;
  final DateTime actualizadoEn;
  const OrdenFila({
    required this.id,
    required this.numero,
    required this.idCliente,
    required this.idVehiculo,
    required this.idMecanico,
    required this.fechaIngreso,
    required this.problema,
    required this.estado,
    this.kilometrajeIngreso,
    this.fechaEntrega,
    required this.stockDevuelto,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['numero'] = Variable<int>(numero);
    map['id_cliente'] = Variable<String>(idCliente);
    map['id_vehiculo'] = Variable<String>(idVehiculo);
    map['id_mecanico'] = Variable<String>(idMecanico);
    map['fecha_ingreso'] = Variable<DateTime>(fechaIngreso);
    map['problema'] = Variable<String>(problema);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || kilometrajeIngreso != null) {
      map['kilometraje_ingreso'] = Variable<int>(kilometrajeIngreso);
    }
    if (!nullToAbsent || fechaEntrega != null) {
      map['fecha_entrega'] = Variable<DateTime>(fechaEntrega);
    }
    map['stock_devuelto'] = Variable<bool>(stockDevuelto);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  OrdenesCompanion toCompanion(bool nullToAbsent) {
    return OrdenesCompanion(
      id: Value(id),
      numero: Value(numero),
      idCliente: Value(idCliente),
      idVehiculo: Value(idVehiculo),
      idMecanico: Value(idMecanico),
      fechaIngreso: Value(fechaIngreso),
      problema: Value(problema),
      estado: Value(estado),
      kilometrajeIngreso: kilometrajeIngreso == null && nullToAbsent
          ? const Value.absent()
          : Value(kilometrajeIngreso),
      fechaEntrega: fechaEntrega == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaEntrega),
      stockDevuelto: Value(stockDevuelto),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory OrdenFila.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdenFila(
      id: serializer.fromJson<String>(json['id']),
      numero: serializer.fromJson<int>(json['numero']),
      idCliente: serializer.fromJson<String>(json['idCliente']),
      idVehiculo: serializer.fromJson<String>(json['idVehiculo']),
      idMecanico: serializer.fromJson<String>(json['idMecanico']),
      fechaIngreso: serializer.fromJson<DateTime>(json['fechaIngreso']),
      problema: serializer.fromJson<String>(json['problema']),
      estado: serializer.fromJson<String>(json['estado']),
      kilometrajeIngreso: serializer.fromJson<int?>(json['kilometrajeIngreso']),
      fechaEntrega: serializer.fromJson<DateTime?>(json['fechaEntrega']),
      stockDevuelto: serializer.fromJson<bool>(json['stockDevuelto']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'numero': serializer.toJson<int>(numero),
      'idCliente': serializer.toJson<String>(idCliente),
      'idVehiculo': serializer.toJson<String>(idVehiculo),
      'idMecanico': serializer.toJson<String>(idMecanico),
      'fechaIngreso': serializer.toJson<DateTime>(fechaIngreso),
      'problema': serializer.toJson<String>(problema),
      'estado': serializer.toJson<String>(estado),
      'kilometrajeIngreso': serializer.toJson<int?>(kilometrajeIngreso),
      'fechaEntrega': serializer.toJson<DateTime?>(fechaEntrega),
      'stockDevuelto': serializer.toJson<bool>(stockDevuelto),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  OrdenFila copyWith({
    String? id,
    int? numero,
    String? idCliente,
    String? idVehiculo,
    String? idMecanico,
    DateTime? fechaIngreso,
    String? problema,
    String? estado,
    Value<int?> kilometrajeIngreso = const Value.absent(),
    Value<DateTime?> fechaEntrega = const Value.absent(),
    bool? stockDevuelto,
    DateTime? actualizadoEn,
  }) => OrdenFila(
    id: id ?? this.id,
    numero: numero ?? this.numero,
    idCliente: idCliente ?? this.idCliente,
    idVehiculo: idVehiculo ?? this.idVehiculo,
    idMecanico: idMecanico ?? this.idMecanico,
    fechaIngreso: fechaIngreso ?? this.fechaIngreso,
    problema: problema ?? this.problema,
    estado: estado ?? this.estado,
    kilometrajeIngreso: kilometrajeIngreso.present
        ? kilometrajeIngreso.value
        : this.kilometrajeIngreso,
    fechaEntrega: fechaEntrega.present ? fechaEntrega.value : this.fechaEntrega,
    stockDevuelto: stockDevuelto ?? this.stockDevuelto,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  OrdenFila copyWithCompanion(OrdenesCompanion data) {
    return OrdenFila(
      id: data.id.present ? data.id.value : this.id,
      numero: data.numero.present ? data.numero.value : this.numero,
      idCliente: data.idCliente.present ? data.idCliente.value : this.idCliente,
      idVehiculo: data.idVehiculo.present
          ? data.idVehiculo.value
          : this.idVehiculo,
      idMecanico: data.idMecanico.present
          ? data.idMecanico.value
          : this.idMecanico,
      fechaIngreso: data.fechaIngreso.present
          ? data.fechaIngreso.value
          : this.fechaIngreso,
      problema: data.problema.present ? data.problema.value : this.problema,
      estado: data.estado.present ? data.estado.value : this.estado,
      kilometrajeIngreso: data.kilometrajeIngreso.present
          ? data.kilometrajeIngreso.value
          : this.kilometrajeIngreso,
      fechaEntrega: data.fechaEntrega.present
          ? data.fechaEntrega.value
          : this.fechaEntrega,
      stockDevuelto: data.stockDevuelto.present
          ? data.stockDevuelto.value
          : this.stockDevuelto,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdenFila(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('idCliente: $idCliente, ')
          ..write('idVehiculo: $idVehiculo, ')
          ..write('idMecanico: $idMecanico, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('problema: $problema, ')
          ..write('estado: $estado, ')
          ..write('kilometrajeIngreso: $kilometrajeIngreso, ')
          ..write('fechaEntrega: $fechaEntrega, ')
          ..write('stockDevuelto: $stockDevuelto, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    numero,
    idCliente,
    idVehiculo,
    idMecanico,
    fechaIngreso,
    problema,
    estado,
    kilometrajeIngreso,
    fechaEntrega,
    stockDevuelto,
    actualizadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdenFila &&
          other.id == this.id &&
          other.numero == this.numero &&
          other.idCliente == this.idCliente &&
          other.idVehiculo == this.idVehiculo &&
          other.idMecanico == this.idMecanico &&
          other.fechaIngreso == this.fechaIngreso &&
          other.problema == this.problema &&
          other.estado == this.estado &&
          other.kilometrajeIngreso == this.kilometrajeIngreso &&
          other.fechaEntrega == this.fechaEntrega &&
          other.stockDevuelto == this.stockDevuelto &&
          other.actualizadoEn == this.actualizadoEn);
}

class OrdenesCompanion extends UpdateCompanion<OrdenFila> {
  final Value<String> id;
  final Value<int> numero;
  final Value<String> idCliente;
  final Value<String> idVehiculo;
  final Value<String> idMecanico;
  final Value<DateTime> fechaIngreso;
  final Value<String> problema;
  final Value<String> estado;
  final Value<int?> kilometrajeIngreso;
  final Value<DateTime?> fechaEntrega;
  final Value<bool> stockDevuelto;
  final Value<DateTime> actualizadoEn;
  final Value<int> rowid;
  const OrdenesCompanion({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
    this.idCliente = const Value.absent(),
    this.idVehiculo = const Value.absent(),
    this.idMecanico = const Value.absent(),
    this.fechaIngreso = const Value.absent(),
    this.problema = const Value.absent(),
    this.estado = const Value.absent(),
    this.kilometrajeIngreso = const Value.absent(),
    this.fechaEntrega = const Value.absent(),
    this.stockDevuelto = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdenesCompanion.insert({
    required String id,
    required int numero,
    required String idCliente,
    required String idVehiculo,
    required String idMecanico,
    required DateTime fechaIngreso,
    required String problema,
    required String estado,
    this.kilometrajeIngreso = const Value.absent(),
    this.fechaEntrega = const Value.absent(),
    this.stockDevuelto = const Value.absent(),
    required DateTime actualizadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       numero = Value(numero),
       idCliente = Value(idCliente),
       idVehiculo = Value(idVehiculo),
       idMecanico = Value(idMecanico),
       fechaIngreso = Value(fechaIngreso),
       problema = Value(problema),
       estado = Value(estado),
       actualizadoEn = Value(actualizadoEn);
  static Insertable<OrdenFila> custom({
    Expression<String>? id,
    Expression<int>? numero,
    Expression<String>? idCliente,
    Expression<String>? idVehiculo,
    Expression<String>? idMecanico,
    Expression<DateTime>? fechaIngreso,
    Expression<String>? problema,
    Expression<String>? estado,
    Expression<int>? kilometrajeIngreso,
    Expression<DateTime>? fechaEntrega,
    Expression<bool>? stockDevuelto,
    Expression<DateTime>? actualizadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (numero != null) 'numero': numero,
      if (idCliente != null) 'id_cliente': idCliente,
      if (idVehiculo != null) 'id_vehiculo': idVehiculo,
      if (idMecanico != null) 'id_mecanico': idMecanico,
      if (fechaIngreso != null) 'fecha_ingreso': fechaIngreso,
      if (problema != null) 'problema': problema,
      if (estado != null) 'estado': estado,
      if (kilometrajeIngreso != null) 'kilometraje_ingreso': kilometrajeIngreso,
      if (fechaEntrega != null) 'fecha_entrega': fechaEntrega,
      if (stockDevuelto != null) 'stock_devuelto': stockDevuelto,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdenesCompanion copyWith({
    Value<String>? id,
    Value<int>? numero,
    Value<String>? idCliente,
    Value<String>? idVehiculo,
    Value<String>? idMecanico,
    Value<DateTime>? fechaIngreso,
    Value<String>? problema,
    Value<String>? estado,
    Value<int?>? kilometrajeIngreso,
    Value<DateTime?>? fechaEntrega,
    Value<bool>? stockDevuelto,
    Value<DateTime>? actualizadoEn,
    Value<int>? rowid,
  }) {
    return OrdenesCompanion(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      idCliente: idCliente ?? this.idCliente,
      idVehiculo: idVehiculo ?? this.idVehiculo,
      idMecanico: idMecanico ?? this.idMecanico,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      problema: problema ?? this.problema,
      estado: estado ?? this.estado,
      kilometrajeIngreso: kilometrajeIngreso ?? this.kilometrajeIngreso,
      fechaEntrega: fechaEntrega ?? this.fechaEntrega,
      stockDevuelto: stockDevuelto ?? this.stockDevuelto,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (numero.present) {
      map['numero'] = Variable<int>(numero.value);
    }
    if (idCliente.present) {
      map['id_cliente'] = Variable<String>(idCliente.value);
    }
    if (idVehiculo.present) {
      map['id_vehiculo'] = Variable<String>(idVehiculo.value);
    }
    if (idMecanico.present) {
      map['id_mecanico'] = Variable<String>(idMecanico.value);
    }
    if (fechaIngreso.present) {
      map['fecha_ingreso'] = Variable<DateTime>(fechaIngreso.value);
    }
    if (problema.present) {
      map['problema'] = Variable<String>(problema.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (kilometrajeIngreso.present) {
      map['kilometraje_ingreso'] = Variable<int>(kilometrajeIngreso.value);
    }
    if (fechaEntrega.present) {
      map['fecha_entrega'] = Variable<DateTime>(fechaEntrega.value);
    }
    if (stockDevuelto.present) {
      map['stock_devuelto'] = Variable<bool>(stockDevuelto.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesCompanion(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('idCliente: $idCliente, ')
          ..write('idVehiculo: $idVehiculo, ')
          ..write('idMecanico: $idMecanico, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('problema: $problema, ')
          ..write('estado: $estado, ')
          ..write('kilometrajeIngreso: $kilometrajeIngreso, ')
          ..write('fechaEntrega: $fechaEntrega, ')
          ..write('stockDevuelto: $stockDevuelto, ')
          ..write('actualizadoEn: $actualizadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ManoObraTable extends ManoObra
    with TableInfo<$ManoObraTable, ManoObraFila> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ManoObraTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idOrdenMeta = const VerificationMeta(
    'idOrden',
  );
  @override
  late final GeneratedColumn<String> idOrden = GeneratedColumn<String>(
    'id_orden',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES ordenes(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
    'precio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posicionMeta = const VerificationMeta(
    'posicion',
  );
  @override
  late final GeneratedColumn<int> posicion = GeneratedColumn<int>(
    'posicion',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idOrden,
    descripcion,
    precio,
    posicion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mano_obra';
  @override
  VerificationContext validateIntegrity(
    Insertable<ManoObraFila> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('id_orden')) {
      context.handle(
        _idOrdenMeta,
        idOrden.isAcceptableOrUnknown(data['id_orden']!, _idOrdenMeta),
      );
    } else if (isInserting) {
      context.missing(_idOrdenMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(
        _precioMeta,
        precio.isAcceptableOrUnknown(data['precio']!, _precioMeta),
      );
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('posicion')) {
      context.handle(
        _posicionMeta,
        posicion.isAcceptableOrUnknown(data['posicion']!, _posicionMeta),
      );
    } else if (isInserting) {
      context.missing(_posicionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ManoObraFila map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ManoObraFila(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      idOrden: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_orden'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      precio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio'],
      )!,
      posicion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}posicion'],
      )!,
    );
  }

  @override
  $ManoObraTable createAlias(String alias) {
    return $ManoObraTable(attachedDatabase, alias);
  }
}

class ManoObraFila extends DataClass implements Insertable<ManoObraFila> {
  final String id;
  final String idOrden;
  final String descripcion;
  final double precio;
  final int posicion;
  const ManoObraFila({
    required this.id,
    required this.idOrden,
    required this.descripcion,
    required this.precio,
    required this.posicion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['id_orden'] = Variable<String>(idOrden);
    map['descripcion'] = Variable<String>(descripcion);
    map['precio'] = Variable<double>(precio);
    map['posicion'] = Variable<int>(posicion);
    return map;
  }

  ManoObraCompanion toCompanion(bool nullToAbsent) {
    return ManoObraCompanion(
      id: Value(id),
      idOrden: Value(idOrden),
      descripcion: Value(descripcion),
      precio: Value(precio),
      posicion: Value(posicion),
    );
  }

  factory ManoObraFila.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ManoObraFila(
      id: serializer.fromJson<String>(json['id']),
      idOrden: serializer.fromJson<String>(json['idOrden']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      precio: serializer.fromJson<double>(json['precio']),
      posicion: serializer.fromJson<int>(json['posicion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'idOrden': serializer.toJson<String>(idOrden),
      'descripcion': serializer.toJson<String>(descripcion),
      'precio': serializer.toJson<double>(precio),
      'posicion': serializer.toJson<int>(posicion),
    };
  }

  ManoObraFila copyWith({
    String? id,
    String? idOrden,
    String? descripcion,
    double? precio,
    int? posicion,
  }) => ManoObraFila(
    id: id ?? this.id,
    idOrden: idOrden ?? this.idOrden,
    descripcion: descripcion ?? this.descripcion,
    precio: precio ?? this.precio,
    posicion: posicion ?? this.posicion,
  );
  ManoObraFila copyWithCompanion(ManoObraCompanion data) {
    return ManoObraFila(
      id: data.id.present ? data.id.value : this.id,
      idOrden: data.idOrden.present ? data.idOrden.value : this.idOrden,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      precio: data.precio.present ? data.precio.value : this.precio,
      posicion: data.posicion.present ? data.posicion.value : this.posicion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ManoObraFila(')
          ..write('id: $id, ')
          ..write('idOrden: $idOrden, ')
          ..write('descripcion: $descripcion, ')
          ..write('precio: $precio, ')
          ..write('posicion: $posicion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idOrden, descripcion, precio, posicion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ManoObraFila &&
          other.id == this.id &&
          other.idOrden == this.idOrden &&
          other.descripcion == this.descripcion &&
          other.precio == this.precio &&
          other.posicion == this.posicion);
}

class ManoObraCompanion extends UpdateCompanion<ManoObraFila> {
  final Value<String> id;
  final Value<String> idOrden;
  final Value<String> descripcion;
  final Value<double> precio;
  final Value<int> posicion;
  final Value<int> rowid;
  const ManoObraCompanion({
    this.id = const Value.absent(),
    this.idOrden = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.precio = const Value.absent(),
    this.posicion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ManoObraCompanion.insert({
    required String id,
    required String idOrden,
    required String descripcion,
    required double precio,
    required int posicion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       idOrden = Value(idOrden),
       descripcion = Value(descripcion),
       precio = Value(precio),
       posicion = Value(posicion);
  static Insertable<ManoObraFila> custom({
    Expression<String>? id,
    Expression<String>? idOrden,
    Expression<String>? descripcion,
    Expression<double>? precio,
    Expression<int>? posicion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idOrden != null) 'id_orden': idOrden,
      if (descripcion != null) 'descripcion': descripcion,
      if (precio != null) 'precio': precio,
      if (posicion != null) 'posicion': posicion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ManoObraCompanion copyWith({
    Value<String>? id,
    Value<String>? idOrden,
    Value<String>? descripcion,
    Value<double>? precio,
    Value<int>? posicion,
    Value<int>? rowid,
  }) {
    return ManoObraCompanion(
      id: id ?? this.id,
      idOrden: idOrden ?? this.idOrden,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      posicion: posicion ?? this.posicion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (idOrden.present) {
      map['id_orden'] = Variable<String>(idOrden.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (posicion.present) {
      map['posicion'] = Variable<int>(posicion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ManoObraCompanion(')
          ..write('id: $id, ')
          ..write('idOrden: $idOrden, ')
          ..write('descripcion: $descripcion, ')
          ..write('precio: $precio, ')
          ..write('posicion: $posicion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdenRepuestosTable extends OrdenRepuestos
    with TableInfo<$OrdenRepuestosTable, OrdenRepuestoFila> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenRepuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idOrdenMeta = const VerificationMeta(
    'idOrden',
  );
  @override
  late final GeneratedColumn<String> idOrden = GeneratedColumn<String>(
    'id_orden',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES ordenes(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _idRepuestoMeta = const VerificationMeta(
    'idRepuesto',
  );
  @override
  late final GeneratedColumn<String> idRepuesto = GeneratedColumn<String>(
    'id_repuesto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES repuestos(id) ON DELETE RESTRICT',
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioUnitarioMeta = const VerificationMeta(
    'precioUnitario',
  );
  @override
  late final GeneratedColumn<double> precioUnitario = GeneratedColumn<double>(
    'precio_unitario',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idOrden,
    idRepuesto,
    codigo,
    nombre,
    cantidad,
    precioUnitario,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orden_repuestos';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrdenRepuestoFila> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_orden')) {
      context.handle(
        _idOrdenMeta,
        idOrden.isAcceptableOrUnknown(data['id_orden']!, _idOrdenMeta),
      );
    } else if (isInserting) {
      context.missing(_idOrdenMeta);
    }
    if (data.containsKey('id_repuesto')) {
      context.handle(
        _idRepuestoMeta,
        idRepuesto.isAcceptableOrUnknown(data['id_repuesto']!, _idRepuestoMeta),
      );
    } else if (isInserting) {
      context.missing(_idRepuestoMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
        _precioUnitarioMeta,
        precioUnitario.isAcceptableOrUnknown(
          data['precio_unitario']!,
          _precioUnitarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdenRepuestoFila map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdenRepuestoFila(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idOrden: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_orden'],
      )!,
      idRepuesto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_repuesto'],
      )!,
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cantidad'],
      )!,
      precioUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_unitario'],
      )!,
    );
  }

  @override
  $OrdenRepuestosTable createAlias(String alias) {
    return $OrdenRepuestosTable(attachedDatabase, alias);
  }
}

class OrdenRepuestoFila extends DataClass
    implements Insertable<OrdenRepuestoFila> {
  final int id;
  final String idOrden;
  final String idRepuesto;
  final String codigo;
  final String nombre;
  final int cantidad;
  final double precioUnitario;
  const OrdenRepuestoFila({
    required this.id,
    required this.idOrden,
    required this.idRepuesto,
    required this.codigo,
    required this.nombre,
    required this.cantidad,
    required this.precioUnitario,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_orden'] = Variable<String>(idOrden);
    map['id_repuesto'] = Variable<String>(idRepuesto);
    map['codigo'] = Variable<String>(codigo);
    map['nombre'] = Variable<String>(nombre);
    map['cantidad'] = Variable<int>(cantidad);
    map['precio_unitario'] = Variable<double>(precioUnitario);
    return map;
  }

  OrdenRepuestosCompanion toCompanion(bool nullToAbsent) {
    return OrdenRepuestosCompanion(
      id: Value(id),
      idOrden: Value(idOrden),
      idRepuesto: Value(idRepuesto),
      codigo: Value(codigo),
      nombre: Value(nombre),
      cantidad: Value(cantidad),
      precioUnitario: Value(precioUnitario),
    );
  }

  factory OrdenRepuestoFila.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdenRepuestoFila(
      id: serializer.fromJson<int>(json['id']),
      idOrden: serializer.fromJson<String>(json['idOrden']),
      idRepuesto: serializer.fromJson<String>(json['idRepuesto']),
      codigo: serializer.fromJson<String>(json['codigo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      precioUnitario: serializer.fromJson<double>(json['precioUnitario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idOrden': serializer.toJson<String>(idOrden),
      'idRepuesto': serializer.toJson<String>(idRepuesto),
      'codigo': serializer.toJson<String>(codigo),
      'nombre': serializer.toJson<String>(nombre),
      'cantidad': serializer.toJson<int>(cantidad),
      'precioUnitario': serializer.toJson<double>(precioUnitario),
    };
  }

  OrdenRepuestoFila copyWith({
    int? id,
    String? idOrden,
    String? idRepuesto,
    String? codigo,
    String? nombre,
    int? cantidad,
    double? precioUnitario,
  }) => OrdenRepuestoFila(
    id: id ?? this.id,
    idOrden: idOrden ?? this.idOrden,
    idRepuesto: idRepuesto ?? this.idRepuesto,
    codigo: codigo ?? this.codigo,
    nombre: nombre ?? this.nombre,
    cantidad: cantidad ?? this.cantidad,
    precioUnitario: precioUnitario ?? this.precioUnitario,
  );
  OrdenRepuestoFila copyWithCompanion(OrdenRepuestosCompanion data) {
    return OrdenRepuestoFila(
      id: data.id.present ? data.id.value : this.id,
      idOrden: data.idOrden.present ? data.idOrden.value : this.idOrden,
      idRepuesto: data.idRepuesto.present
          ? data.idRepuesto.value
          : this.idRepuesto,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdenRepuestoFila(')
          ..write('id: $id, ')
          ..write('idOrden: $idOrden, ')
          ..write('idRepuesto: $idRepuesto, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idOrden,
    idRepuesto,
    codigo,
    nombre,
    cantidad,
    precioUnitario,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdenRepuestoFila &&
          other.id == this.id &&
          other.idOrden == this.idOrden &&
          other.idRepuesto == this.idRepuesto &&
          other.codigo == this.codigo &&
          other.nombre == this.nombre &&
          other.cantidad == this.cantidad &&
          other.precioUnitario == this.precioUnitario);
}

class OrdenRepuestosCompanion extends UpdateCompanion<OrdenRepuestoFila> {
  final Value<int> id;
  final Value<String> idOrden;
  final Value<String> idRepuesto;
  final Value<String> codigo;
  final Value<String> nombre;
  final Value<int> cantidad;
  final Value<double> precioUnitario;
  const OrdenRepuestosCompanion({
    this.id = const Value.absent(),
    this.idOrden = const Value.absent(),
    this.idRepuesto = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioUnitario = const Value.absent(),
  });
  OrdenRepuestosCompanion.insert({
    this.id = const Value.absent(),
    required String idOrden,
    required String idRepuesto,
    required String codigo,
    required String nombre,
    required int cantidad,
    required double precioUnitario,
  }) : idOrden = Value(idOrden),
       idRepuesto = Value(idRepuesto),
       codigo = Value(codigo),
       nombre = Value(nombre),
       cantidad = Value(cantidad),
       precioUnitario = Value(precioUnitario);
  static Insertable<OrdenRepuestoFila> custom({
    Expression<int>? id,
    Expression<String>? idOrden,
    Expression<String>? idRepuesto,
    Expression<String>? codigo,
    Expression<String>? nombre,
    Expression<int>? cantidad,
    Expression<double>? precioUnitario,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idOrden != null) 'id_orden': idOrden,
      if (idRepuesto != null) 'id_repuesto': idRepuesto,
      if (codigo != null) 'codigo': codigo,
      if (nombre != null) 'nombre': nombre,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
    });
  }

  OrdenRepuestosCompanion copyWith({
    Value<int>? id,
    Value<String>? idOrden,
    Value<String>? idRepuesto,
    Value<String>? codigo,
    Value<String>? nombre,
    Value<int>? cantidad,
    Value<double>? precioUnitario,
  }) {
    return OrdenRepuestosCompanion(
      id: id ?? this.id,
      idOrden: idOrden ?? this.idOrden,
      idRepuesto: idRepuesto ?? this.idRepuesto,
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idOrden.present) {
      map['id_orden'] = Variable<String>(idOrden.value);
    }
    if (idRepuesto.present) {
      map['id_repuesto'] = Variable<String>(idRepuesto.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<double>(precioUnitario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenRepuestosCompanion(')
          ..write('id: $id, ')
          ..write('idOrden: $idOrden, ')
          ..write('idRepuesto: $idRepuesto, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }
}

class $PagosTable extends Pagos with TableInfo<$PagosTable, PagoFila> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PagosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idOrdenMeta = const VerificationMeta(
    'idOrden',
  );
  @override
  late final GeneratedColumn<String> idOrden = GeneratedColumn<String>(
    'id_orden',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES ordenes(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metodoMeta = const VerificationMeta('metodo');
  @override
  late final GeneratedColumn<String> metodo = GeneratedColumn<String>(
    'metodo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posicionMeta = const VerificationMeta(
    'posicion',
  );
  @override
  late final GeneratedColumn<int> posicion = GeneratedColumn<int>(
    'posicion',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idOrden,
    monto,
    fecha,
    metodo,
    posicion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pagos';
  @override
  VerificationContext validateIntegrity(
    Insertable<PagoFila> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('id_orden')) {
      context.handle(
        _idOrdenMeta,
        idOrden.isAcceptableOrUnknown(data['id_orden']!, _idOrdenMeta),
      );
    } else if (isInserting) {
      context.missing(_idOrdenMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('metodo')) {
      context.handle(
        _metodoMeta,
        metodo.isAcceptableOrUnknown(data['metodo']!, _metodoMeta),
      );
    } else if (isInserting) {
      context.missing(_metodoMeta);
    }
    if (data.containsKey('posicion')) {
      context.handle(
        _posicionMeta,
        posicion.isAcceptableOrUnknown(data['posicion']!, _posicionMeta),
      );
    } else if (isInserting) {
      context.missing(_posicionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PagoFila map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PagoFila(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      idOrden: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_orden'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      metodo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metodo'],
      )!,
      posicion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}posicion'],
      )!,
    );
  }

  @override
  $PagosTable createAlias(String alias) {
    return $PagosTable(attachedDatabase, alias);
  }
}

class PagoFila extends DataClass implements Insertable<PagoFila> {
  final String id;
  final String idOrden;
  final double monto;
  final DateTime fecha;
  final String metodo;
  final int posicion;
  const PagoFila({
    required this.id,
    required this.idOrden,
    required this.monto,
    required this.fecha,
    required this.metodo,
    required this.posicion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['id_orden'] = Variable<String>(idOrden);
    map['monto'] = Variable<double>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    map['metodo'] = Variable<String>(metodo);
    map['posicion'] = Variable<int>(posicion);
    return map;
  }

  PagosCompanion toCompanion(bool nullToAbsent) {
    return PagosCompanion(
      id: Value(id),
      idOrden: Value(idOrden),
      monto: Value(monto),
      fecha: Value(fecha),
      metodo: Value(metodo),
      posicion: Value(posicion),
    );
  }

  factory PagoFila.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PagoFila(
      id: serializer.fromJson<String>(json['id']),
      idOrden: serializer.fromJson<String>(json['idOrden']),
      monto: serializer.fromJson<double>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      metodo: serializer.fromJson<String>(json['metodo']),
      posicion: serializer.fromJson<int>(json['posicion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'idOrden': serializer.toJson<String>(idOrden),
      'monto': serializer.toJson<double>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'metodo': serializer.toJson<String>(metodo),
      'posicion': serializer.toJson<int>(posicion),
    };
  }

  PagoFila copyWith({
    String? id,
    String? idOrden,
    double? monto,
    DateTime? fecha,
    String? metodo,
    int? posicion,
  }) => PagoFila(
    id: id ?? this.id,
    idOrden: idOrden ?? this.idOrden,
    monto: monto ?? this.monto,
    fecha: fecha ?? this.fecha,
    metodo: metodo ?? this.metodo,
    posicion: posicion ?? this.posicion,
  );
  PagoFila copyWithCompanion(PagosCompanion data) {
    return PagoFila(
      id: data.id.present ? data.id.value : this.id,
      idOrden: data.idOrden.present ? data.idOrden.value : this.idOrden,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      metodo: data.metodo.present ? data.metodo.value : this.metodo,
      posicion: data.posicion.present ? data.posicion.value : this.posicion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PagoFila(')
          ..write('id: $id, ')
          ..write('idOrden: $idOrden, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('metodo: $metodo, ')
          ..write('posicion: $posicion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idOrden, monto, fecha, metodo, posicion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PagoFila &&
          other.id == this.id &&
          other.idOrden == this.idOrden &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.metodo == this.metodo &&
          other.posicion == this.posicion);
}

class PagosCompanion extends UpdateCompanion<PagoFila> {
  final Value<String> id;
  final Value<String> idOrden;
  final Value<double> monto;
  final Value<DateTime> fecha;
  final Value<String> metodo;
  final Value<int> posicion;
  final Value<int> rowid;
  const PagosCompanion({
    this.id = const Value.absent(),
    this.idOrden = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.metodo = const Value.absent(),
    this.posicion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PagosCompanion.insert({
    required String id,
    required String idOrden,
    required double monto,
    required DateTime fecha,
    required String metodo,
    required int posicion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       idOrden = Value(idOrden),
       monto = Value(monto),
       fecha = Value(fecha),
       metodo = Value(metodo),
       posicion = Value(posicion);
  static Insertable<PagoFila> custom({
    Expression<String>? id,
    Expression<String>? idOrden,
    Expression<double>? monto,
    Expression<DateTime>? fecha,
    Expression<String>? metodo,
    Expression<int>? posicion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idOrden != null) 'id_orden': idOrden,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (metodo != null) 'metodo': metodo,
      if (posicion != null) 'posicion': posicion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PagosCompanion copyWith({
    Value<String>? id,
    Value<String>? idOrden,
    Value<double>? monto,
    Value<DateTime>? fecha,
    Value<String>? metodo,
    Value<int>? posicion,
    Value<int>? rowid,
  }) {
    return PagosCompanion(
      id: id ?? this.id,
      idOrden: idOrden ?? this.idOrden,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      metodo: metodo ?? this.metodo,
      posicion: posicion ?? this.posicion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (idOrden.present) {
      map['id_orden'] = Variable<String>(idOrden.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (metodo.present) {
      map['metodo'] = Variable<String>(metodo.value);
    }
    if (posicion.present) {
      map['posicion'] = Variable<int>(posicion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PagosCompanion(')
          ..write('id: $id, ')
          ..write('idOrden: $idOrden, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('metodo: $metodo, ')
          ..write('posicion: $posicion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$BaseDatosTaller extends GeneratedDatabase {
  _$BaseDatosTaller(QueryExecutor e) : super(e);
  $BaseDatosTallerManager get managers => $BaseDatosTallerManager(this);
  late final $MecanicosTable mecanicos = $MecanicosTable(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $VehiculosTable vehiculos = $VehiculosTable(this);
  late final $RepuestosTable repuestos = $RepuestosTable(this);
  late final $OrdenesTable ordenes = $OrdenesTable(this);
  late final $ManoObraTable manoObra = $ManoObraTable(this);
  late final $OrdenRepuestosTable ordenRepuestos = $OrdenRepuestosTable(this);
  late final $PagosTable pagos = $PagosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    mecanicos,
    clientes,
    vehiculos,
    repuestos,
    ordenes,
    manoObra,
    ordenRepuestos,
    pagos,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clientes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vehiculos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ordenes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('mano_obra', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ordenes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('orden_repuestos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ordenes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pagos', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MecanicosTableCreateCompanionBuilder = MecanicosCompanion Function({
  required String id,
  required String nombre,
  required String especialidad,
  Value<int> rowid,
});
typedef $$MecanicosTableUpdateCompanionBuilder = MecanicosCompanion Function({
  Value<String> id,
  Value<String> nombre,
  Value<String> especialidad,
  Value<int> rowid,
});

final class $$MecanicosTableReferences
    extends BaseReferences<_$BaseDatosTaller, $MecanicosTable, MecanicoFila> {
  $$MecanicosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdenesTable, List<OrdenFila>> _ordenesRefsTable(
    _$BaseDatosTaller db,
  ) => MultiTypedResultKey.fromTable(
    db.ordenes,
    aliasName: $_aliasNameGenerator(db.mecanicos.id, db.ordenes.idMecanico),
  );

  $$OrdenesTableProcessedTableManager get ordenesRefs {
    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.idMecanico.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MecanicosTableFilterComposer
    extends Composer<_$BaseDatosTaller, $MecanicosTable> {
  $$MecanicosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get especialidad => $composableBuilder(
    column: $table.especialidad,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ordenesRefs(
    Expression<bool> Function($$OrdenesTableFilterComposer f) f,
  ) {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.idMecanico,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MecanicosTableOrderingComposer
    extends Composer<_$BaseDatosTaller, $MecanicosTable> {
  $$MecanicosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get especialidad => $composableBuilder(
    column: $table.especialidad,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MecanicosTableAnnotationComposer
    extends Composer<_$BaseDatosTaller, $MecanicosTable> {
  $$MecanicosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get especialidad => $composableBuilder(
    column: $table.especialidad,
    builder: (column) => column,
  );

  Expression<T> ordenesRefs<T extends Object>(
    Expression<T> Function($$OrdenesTableAnnotationComposer a) f,
  ) {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.idMecanico,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MecanicosTableTableManager
    extends
        RootTableManager<
          _$BaseDatosTaller,
          $MecanicosTable,
          MecanicoFila,
          $$MecanicosTableFilterComposer,
          $$MecanicosTableOrderingComposer,
          $$MecanicosTableAnnotationComposer,
          $$MecanicosTableCreateCompanionBuilder,
          $$MecanicosTableUpdateCompanionBuilder,
          (MecanicoFila, $$MecanicosTableReferences),
          MecanicoFila,
          PrefetchHooks Function({bool ordenesRefs})
        > {
  $$MecanicosTableTableManager(_$BaseDatosTaller db, $MecanicosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MecanicosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MecanicosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MecanicosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> especialidad = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MecanicosCompanion(
                id: id,
                nombre: nombre,
                especialidad: especialidad,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                required String especialidad,
                Value<int> rowid = const Value.absent(),
              }) => MecanicosCompanion.insert(
                id: id,
                nombre: nombre,
                especialidad: especialidad,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MecanicosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordenesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordenesRefs) db.ordenes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordenesRefs)
                    await $_getPrefetchedData<
                      MecanicoFila,
                      $MecanicosTable,
                      OrdenFila
                    >(
                      currentTable: table,
                      referencedTable: $$MecanicosTableReferences
                          ._ordenesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MecanicosTableReferences(db, table, p0).ordenesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.idMecanico == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MecanicosTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatosTaller,
      $MecanicosTable,
      MecanicoFila,
      $$MecanicosTableFilterComposer,
      $$MecanicosTableOrderingComposer,
      $$MecanicosTableAnnotationComposer,
      $$MecanicosTableCreateCompanionBuilder,
      $$MecanicosTableUpdateCompanionBuilder,
      (MecanicoFila, $$MecanicosTableReferences),
      MecanicoFila,
      PrefetchHooks Function({bool ordenesRefs})
    >;
typedef $$ClientesTableCreateCompanionBuilder = ClientesCompanion Function({
  required String id,
  required String nombre,
  required String telefono,
  Value<String?> direccion,
  required DateTime creadoEn,
  Value<int> rowid,
});
typedef $$ClientesTableUpdateCompanionBuilder = ClientesCompanion Function({
  Value<String> id,
  Value<String> nombre,
  Value<String> telefono,
  Value<String?> direccion,
  Value<DateTime> creadoEn,
  Value<int> rowid,
});

final class $$ClientesTableReferences
    extends BaseReferences<_$BaseDatosTaller, $ClientesTable, ClienteFila> {
  $$ClientesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VehiculosTable, List<VehiculoFila>>
  _vehiculosRefsTable(_$BaseDatosTaller db) => MultiTypedResultKey.fromTable(
    db.vehiculos,
    aliasName: $_aliasNameGenerator(db.clientes.id, db.vehiculos.idCliente),
  );

  $$VehiculosTableProcessedTableManager get vehiculosRefs {
    final manager = $$VehiculosTableTableManager(
      $_db,
      $_db.vehiculos,
    ).filter((f) => f.idCliente.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vehiculosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrdenesTable, List<OrdenFila>> _ordenesRefsTable(
    _$BaseDatosTaller db,
  ) => MultiTypedResultKey.fromTable(
    db.ordenes,
    aliasName: $_aliasNameGenerator(db.clientes.id, db.ordenes.idCliente),
  );

  $$OrdenesTableProcessedTableManager get ordenesRefs {
    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.idCliente.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientesTableFilterComposer
    extends Composer<_$BaseDatosTaller, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vehiculosRefs(
    Expression<bool> Function($$VehiculosTableFilterComposer f) f,
  ) {
    final $$VehiculosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.idCliente,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableFilterComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ordenesRefs(
    Expression<bool> Function($$OrdenesTableFilterComposer f) f,
  ) {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.idCliente,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientesTableOrderingComposer
    extends Composer<_$BaseDatosTaller, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$BaseDatosTaller, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  Expression<T> vehiculosRefs<T extends Object>(
    Expression<T> Function($$VehiculosTableAnnotationComposer a) f,
  ) {
    final $$VehiculosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.idCliente,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableAnnotationComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ordenesRefs<T extends Object>(
    Expression<T> Function($$OrdenesTableAnnotationComposer a) f,
  ) {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.idCliente,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientesTableTableManager
    extends
        RootTableManager<
          _$BaseDatosTaller,
          $ClientesTable,
          ClienteFila,
          $$ClientesTableFilterComposer,
          $$ClientesTableOrderingComposer,
          $$ClientesTableAnnotationComposer,
          $$ClientesTableCreateCompanionBuilder,
          $$ClientesTableUpdateCompanionBuilder,
          (ClienteFila, $$ClientesTableReferences),
          ClienteFila,
          PrefetchHooks Function({bool vehiculosRefs, bool ordenesRefs})
        > {
  $$ClientesTableTableManager(_$BaseDatosTaller db, $ClientesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientesCompanion(
                id: id,
                nombre: nombre,
                telefono: telefono,
                direccion: direccion,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                required String telefono,
                Value<String?> direccion = const Value.absent(),
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => ClientesCompanion.insert(
                id: id,
                nombre: nombre,
                telefono: telefono,
                direccion: direccion,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vehiculosRefs = false, ordenesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vehiculosRefs) db.vehiculos,
                    if (ordenesRefs) db.ordenes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vehiculosRefs)
                        await $_getPrefetchedData<
                          ClienteFila,
                          $ClientesTable,
                          VehiculoFila
                        >(
                          currentTable: table,
                          referencedTable: $$ClientesTableReferences
                              ._vehiculosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientesTableReferences(
                                db,
                                table,
                                p0,
                              ).vehiculosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.idCliente == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ordenesRefs)
                        await $_getPrefetchedData<
                          ClienteFila,
                          $ClientesTable,
                          OrdenFila
                        >(
                          currentTable: table,
                          referencedTable: $$ClientesTableReferences
                              ._ordenesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientesTableReferences(
                                db,
                                table,
                                p0,
                              ).ordenesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.idCliente == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ClientesTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatosTaller,
      $ClientesTable,
      ClienteFila,
      $$ClientesTableFilterComposer,
      $$ClientesTableOrderingComposer,
      $$ClientesTableAnnotationComposer,
      $$ClientesTableCreateCompanionBuilder,
      $$ClientesTableUpdateCompanionBuilder,
      (ClienteFila, $$ClientesTableReferences),
      ClienteFila,
      PrefetchHooks Function({bool vehiculosRefs, bool ordenesRefs})
    >;
typedef $$VehiculosTableCreateCompanionBuilder = VehiculosCompanion Function({
  required String id,
  required String idCliente,
  required String matricula,
  required String marca,
  required String modelo,
  required int anio,
  required int kilometraje,
  required DateTime actualizadoEn,
  Value<int> rowid,
});
typedef $$VehiculosTableUpdateCompanionBuilder = VehiculosCompanion Function({
  Value<String> id,
  Value<String> idCliente,
  Value<String> matricula,
  Value<String> marca,
  Value<String> modelo,
  Value<int> anio,
  Value<int> kilometraje,
  Value<DateTime> actualizadoEn,
  Value<int> rowid,
});

final class $$VehiculosTableReferences
    extends BaseReferences<_$BaseDatosTaller, $VehiculosTable, VehiculoFila> {
  $$VehiculosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientesTable _idClienteTable(_$BaseDatosTaller db) =>
      db.clientes.createAlias(
        $_aliasNameGenerator(db.vehiculos.idCliente, db.clientes.id),
      );

  $$ClientesTableProcessedTableManager get idCliente {
    final $_column = $_itemColumn<String>('id_cliente')!;

    final manager = $$ClientesTableTableManager(
      $_db,
      $_db.clientes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idClienteTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$OrdenesTable, List<OrdenFila>> _ordenesRefsTable(
    _$BaseDatosTaller db,
  ) => MultiTypedResultKey.fromTable(
    db.ordenes,
    aliasName: $_aliasNameGenerator(db.vehiculos.id, db.ordenes.idVehiculo),
  );

  $$OrdenesTableProcessedTableManager get ordenesRefs {
    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.idVehiculo.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiculosTableFilterComposer
    extends Composer<_$BaseDatosTaller, $VehiculosTable> {
  $$VehiculosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matricula => $composableBuilder(
    column: $table.matricula,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marca => $composableBuilder(
    column: $table.marca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kilometraje => $composableBuilder(
    column: $table.kilometraje,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientesTableFilterComposer get idCliente {
    final $$ClientesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCliente,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableFilterComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ordenesRefs(
    Expression<bool> Function($$OrdenesTableFilterComposer f) f,
  ) {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.idVehiculo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiculosTableOrderingComposer
    extends Composer<_$BaseDatosTaller, $VehiculosTable> {
  $$VehiculosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matricula => $composableBuilder(
    column: $table.matricula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marca => $composableBuilder(
    column: $table.marca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kilometraje => $composableBuilder(
    column: $table.kilometraje,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientesTableOrderingComposer get idCliente {
    final $$ClientesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCliente,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableOrderingComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiculosTableAnnotationComposer
    extends Composer<_$BaseDatosTaller, $VehiculosTable> {
  $$VehiculosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get matricula =>
      $composableBuilder(column: $table.matricula, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<int> get kilometraje => $composableBuilder(
    column: $table.kilometraje,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );

  $$ClientesTableAnnotationComposer get idCliente {
    final $$ClientesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCliente,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableAnnotationComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ordenesRefs<T extends Object>(
    Expression<T> Function($$OrdenesTableAnnotationComposer a) f,
  ) {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.idVehiculo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiculosTableTableManager
    extends
        RootTableManager<
          _$BaseDatosTaller,
          $VehiculosTable,
          VehiculoFila,
          $$VehiculosTableFilterComposer,
          $$VehiculosTableOrderingComposer,
          $$VehiculosTableAnnotationComposer,
          $$VehiculosTableCreateCompanionBuilder,
          $$VehiculosTableUpdateCompanionBuilder,
          (VehiculoFila, $$VehiculosTableReferences),
          VehiculoFila,
          PrefetchHooks Function({bool idCliente, bool ordenesRefs})
        > {
  $$VehiculosTableTableManager(_$BaseDatosTaller db, $VehiculosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiculosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiculosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiculosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> idCliente = const Value.absent(),
                Value<String> matricula = const Value.absent(),
                Value<String> marca = const Value.absent(),
                Value<String> modelo = const Value.absent(),
                Value<int> anio = const Value.absent(),
                Value<int> kilometraje = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiculosCompanion(
                id: id,
                idCliente: idCliente,
                matricula: matricula,
                marca: marca,
                modelo: modelo,
                anio: anio,
                kilometraje: kilometraje,
                actualizadoEn: actualizadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String idCliente,
                required String matricula,
                required String marca,
                required String modelo,
                required int anio,
                required int kilometraje,
                required DateTime actualizadoEn,
                Value<int> rowid = const Value.absent(),
              }) => VehiculosCompanion.insert(
                id: id,
                idCliente: idCliente,
                matricula: matricula,
                marca: marca,
                modelo: modelo,
                anio: anio,
                kilometraje: kilometraje,
                actualizadoEn: actualizadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VehiculosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({idCliente = false, ordenesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordenesRefs) db.ordenes],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (idCliente) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.idCliente,
                        referencedTable: $$VehiculosTableReferences
                            ._idClienteTable(db),
                        referencedColumn: $$VehiculosTableReferences
                            ._idClienteTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordenesRefs)
                    await $_getPrefetchedData<
                      VehiculoFila,
                      $VehiculosTable,
                      OrdenFila
                    >(
                      currentTable: table,
                      referencedTable: $$VehiculosTableReferences
                          ._ordenesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VehiculosTableReferences(db, table, p0).ordenesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.idVehiculo == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VehiculosTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatosTaller,
      $VehiculosTable,
      VehiculoFila,
      $$VehiculosTableFilterComposer,
      $$VehiculosTableOrderingComposer,
      $$VehiculosTableAnnotationComposer,
      $$VehiculosTableCreateCompanionBuilder,
      $$VehiculosTableUpdateCompanionBuilder,
      (VehiculoFila, $$VehiculosTableReferences),
      VehiculoFila,
      PrefetchHooks Function({bool idCliente, bool ordenesRefs})
    >;
typedef $$RepuestosTableCreateCompanionBuilder = RepuestosCompanion Function({
  required String id,
  required String codigo,
  required String nombre,
  required double precio,
  required int existencias,
  required int stockMinimo,
  Value<int> rowid,
});
typedef $$RepuestosTableUpdateCompanionBuilder = RepuestosCompanion Function({
  Value<String> id,
  Value<String> codigo,
  Value<String> nombre,
  Value<double> precio,
  Value<int> existencias,
  Value<int> stockMinimo,
  Value<int> rowid,
});

final class $$RepuestosTableReferences
    extends BaseReferences<_$BaseDatosTaller, $RepuestosTable, RepuestoFila> {
  $$RepuestosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdenRepuestosTable, List<OrdenRepuestoFila>>
  _ordenRepuestosRefsTable(_$BaseDatosTaller db) =>
      MultiTypedResultKey.fromTable(
        db.ordenRepuestos,
        aliasName: $_aliasNameGenerator(
          db.repuestos.id,
          db.ordenRepuestos.idRepuesto,
        ),
      );

  $$OrdenRepuestosTableProcessedTableManager get ordenRepuestosRefs {
    final manager = $$OrdenRepuestosTableTableManager(
      $_db,
      $_db.ordenRepuestos,
    ).filter((f) => f.idRepuesto.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenRepuestosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RepuestosTableFilterComposer
    extends Composer<_$BaseDatosTaller, $RepuestosTable> {
  $$RepuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get existencias => $composableBuilder(
    column: $table.existencias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ordenRepuestosRefs(
    Expression<bool> Function($$OrdenRepuestosTableFilterComposer f) f,
  ) {
    final $$OrdenRepuestosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenRepuestos,
      getReferencedColumn: (t) => t.idRepuesto,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenRepuestosTableFilterComposer(
            $db: $db,
            $table: $db.ordenRepuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepuestosTableOrderingComposer
    extends Composer<_$BaseDatosTaller, $RepuestosTable> {
  $$RepuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get existencias => $composableBuilder(
    column: $table.existencias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RepuestosTableAnnotationComposer
    extends Composer<_$BaseDatosTaller, $RepuestosTable> {
  $$RepuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<int> get existencias => $composableBuilder(
    column: $table.existencias,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => column,
  );

  Expression<T> ordenRepuestosRefs<T extends Object>(
    Expression<T> Function($$OrdenRepuestosTableAnnotationComposer a) f,
  ) {
    final $$OrdenRepuestosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenRepuestos,
      getReferencedColumn: (t) => t.idRepuesto,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenRepuestosTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenRepuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepuestosTableTableManager
    extends
        RootTableManager<
          _$BaseDatosTaller,
          $RepuestosTable,
          RepuestoFila,
          $$RepuestosTableFilterComposer,
          $$RepuestosTableOrderingComposer,
          $$RepuestosTableAnnotationComposer,
          $$RepuestosTableCreateCompanionBuilder,
          $$RepuestosTableUpdateCompanionBuilder,
          (RepuestoFila, $$RepuestosTableReferences),
          RepuestoFila,
          PrefetchHooks Function({bool ordenRepuestosRefs})
        > {
  $$RepuestosTableTableManager(_$BaseDatosTaller db, $RepuestosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> codigo = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<double> precio = const Value.absent(),
                Value<int> existencias = const Value.absent(),
                Value<int> stockMinimo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepuestosCompanion(
                id: id,
                codigo: codigo,
                nombre: nombre,
                precio: precio,
                existencias: existencias,
                stockMinimo: stockMinimo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String codigo,
                required String nombre,
                required double precio,
                required int existencias,
                required int stockMinimo,
                Value<int> rowid = const Value.absent(),
              }) => RepuestosCompanion.insert(
                id: id,
                codigo: codigo,
                nombre: nombre,
                precio: precio,
                existencias: existencias,
                stockMinimo: stockMinimo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RepuestosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordenRepuestosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ordenRepuestosRefs) db.ordenRepuestos,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordenRepuestosRefs)
                    await $_getPrefetchedData<
                      RepuestoFila,
                      $RepuestosTable,
                      OrdenRepuestoFila
                    >(
                      currentTable: table,
                      referencedTable: $$RepuestosTableReferences
                          ._ordenRepuestosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RepuestosTableReferences(
                            db,
                            table,
                            p0,
                          ).ordenRepuestosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.idRepuesto == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RepuestosTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatosTaller,
      $RepuestosTable,
      RepuestoFila,
      $$RepuestosTableFilterComposer,
      $$RepuestosTableOrderingComposer,
      $$RepuestosTableAnnotationComposer,
      $$RepuestosTableCreateCompanionBuilder,
      $$RepuestosTableUpdateCompanionBuilder,
      (RepuestoFila, $$RepuestosTableReferences),
      RepuestoFila,
      PrefetchHooks Function({bool ordenRepuestosRefs})
    >;
typedef $$OrdenesTableCreateCompanionBuilder = OrdenesCompanion Function({
  required String id,
  required int numero,
  required String idCliente,
  required String idVehiculo,
  required String idMecanico,
  required DateTime fechaIngreso,
  required String problema,
  required String estado,
  Value<int?> kilometrajeIngreso,
  Value<DateTime?> fechaEntrega,
  Value<bool> stockDevuelto,
  required DateTime actualizadoEn,
  Value<int> rowid,
});
typedef $$OrdenesTableUpdateCompanionBuilder = OrdenesCompanion Function({
  Value<String> id,
  Value<int> numero,
  Value<String> idCliente,
  Value<String> idVehiculo,
  Value<String> idMecanico,
  Value<DateTime> fechaIngreso,
  Value<String> problema,
  Value<String> estado,
  Value<int?> kilometrajeIngreso,
  Value<DateTime?> fechaEntrega,
  Value<bool> stockDevuelto,
  Value<DateTime> actualizadoEn,
  Value<int> rowid,
});

final class $$OrdenesTableReferences
    extends BaseReferences<_$BaseDatosTaller, $OrdenesTable, OrdenFila> {
  $$OrdenesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientesTable _idClienteTable(_$BaseDatosTaller db) => db.clientes
      .createAlias($_aliasNameGenerator(db.ordenes.idCliente, db.clientes.id));

  $$ClientesTableProcessedTableManager get idCliente {
    final $_column = $_itemColumn<String>('id_cliente')!;

    final manager = $$ClientesTableTableManager(
      $_db,
      $_db.clientes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idClienteTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VehiculosTable _idVehiculoTable(_$BaseDatosTaller db) =>
      db.vehiculos.createAlias(
        $_aliasNameGenerator(db.ordenes.idVehiculo, db.vehiculos.id),
      );

  $$VehiculosTableProcessedTableManager get idVehiculo {
    final $_column = $_itemColumn<String>('id_vehiculo')!;

    final manager = $$VehiculosTableTableManager(
      $_db,
      $_db.vehiculos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idVehiculoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MecanicosTable _idMecanicoTable(_$BaseDatosTaller db) =>
      db.mecanicos.createAlias(
        $_aliasNameGenerator(db.ordenes.idMecanico, db.mecanicos.id),
      );

  $$MecanicosTableProcessedTableManager get idMecanico {
    final $_column = $_itemColumn<String>('id_mecanico')!;

    final manager = $$MecanicosTableTableManager(
      $_db,
      $_db.mecanicos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idMecanicoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ManoObraTable, List<ManoObraFila>>
  _manoObraRefsTable(_$BaseDatosTaller db) => MultiTypedResultKey.fromTable(
    db.manoObra,
    aliasName: $_aliasNameGenerator(db.ordenes.id, db.manoObra.idOrden),
  );

  $$ManoObraTableProcessedTableManager get manoObraRefs {
    final manager = $$ManoObraTableTableManager(
      $_db,
      $_db.manoObra,
    ).filter((f) => f.idOrden.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_manoObraRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrdenRepuestosTable, List<OrdenRepuestoFila>>
  _ordenRepuestosRefsTable(_$BaseDatosTaller db) =>
      MultiTypedResultKey.fromTable(
        db.ordenRepuestos,
        aliasName: $_aliasNameGenerator(
          db.ordenes.id,
          db.ordenRepuestos.idOrden,
        ),
      );

  $$OrdenRepuestosTableProcessedTableManager get ordenRepuestosRefs {
    final manager = $$OrdenRepuestosTableTableManager(
      $_db,
      $_db.ordenRepuestos,
    ).filter((f) => f.idOrden.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenRepuestosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PagosTable, List<PagoFila>> _pagosRefsTable(
    _$BaseDatosTaller db,
  ) => MultiTypedResultKey.fromTable(
    db.pagos,
    aliasName: $_aliasNameGenerator(db.ordenes.id, db.pagos.idOrden),
  );

  $$PagosTableProcessedTableManager get pagosRefs {
    final manager = $$PagosTableTableManager(
      $_db,
      $_db.pagos,
    ).filter((f) => f.idOrden.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pagosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdenesTableFilterComposer
    extends Composer<_$BaseDatosTaller, $OrdenesTable> {
  $$OrdenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaIngreso => $composableBuilder(
    column: $table.fechaIngreso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get problema => $composableBuilder(
    column: $table.problema,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kilometrajeIngreso => $composableBuilder(
    column: $table.kilometrajeIngreso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaEntrega => $composableBuilder(
    column: $table.fechaEntrega,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get stockDevuelto => $composableBuilder(
    column: $table.stockDevuelto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientesTableFilterComposer get idCliente {
    final $$ClientesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCliente,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableFilterComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableFilterComposer get idVehiculo {
    final $$VehiculosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idVehiculo,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableFilterComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MecanicosTableFilterComposer get idMecanico {
    final $$MecanicosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idMecanico,
      referencedTable: $db.mecanicos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MecanicosTableFilterComposer(
            $db: $db,
            $table: $db.mecanicos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> manoObraRefs(
    Expression<bool> Function($$ManoObraTableFilterComposer f) f,
  ) {
    final $$ManoObraTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.manoObra,
      getReferencedColumn: (t) => t.idOrden,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ManoObraTableFilterComposer(
            $db: $db,
            $table: $db.manoObra,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ordenRepuestosRefs(
    Expression<bool> Function($$OrdenRepuestosTableFilterComposer f) f,
  ) {
    final $$OrdenRepuestosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenRepuestos,
      getReferencedColumn: (t) => t.idOrden,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenRepuestosTableFilterComposer(
            $db: $db,
            $table: $db.ordenRepuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pagosRefs(
    Expression<bool> Function($$PagosTableFilterComposer f) f,
  ) {
    final $$PagosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pagos,
      getReferencedColumn: (t) => t.idOrden,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PagosTableFilterComposer(
            $db: $db,
            $table: $db.pagos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdenesTableOrderingComposer
    extends Composer<_$BaseDatosTaller, $OrdenesTable> {
  $$OrdenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaIngreso => $composableBuilder(
    column: $table.fechaIngreso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get problema => $composableBuilder(
    column: $table.problema,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kilometrajeIngreso => $composableBuilder(
    column: $table.kilometrajeIngreso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaEntrega => $composableBuilder(
    column: $table.fechaEntrega,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get stockDevuelto => $composableBuilder(
    column: $table.stockDevuelto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientesTableOrderingComposer get idCliente {
    final $$ClientesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCliente,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableOrderingComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableOrderingComposer get idVehiculo {
    final $$VehiculosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idVehiculo,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableOrderingComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MecanicosTableOrderingComposer get idMecanico {
    final $$MecanicosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idMecanico,
      referencedTable: $db.mecanicos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MecanicosTableOrderingComposer(
            $db: $db,
            $table: $db.mecanicos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdenesTableAnnotationComposer
    extends Composer<_$BaseDatosTaller, $OrdenesTable> {
  $$OrdenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaIngreso => $composableBuilder(
    column: $table.fechaIngreso,
    builder: (column) => column,
  );

  GeneratedColumn<String> get problema =>
      $composableBuilder(column: $table.problema, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<int> get kilometrajeIngreso => $composableBuilder(
    column: $table.kilometrajeIngreso,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaEntrega => $composableBuilder(
    column: $table.fechaEntrega,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get stockDevuelto => $composableBuilder(
    column: $table.stockDevuelto,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );

  $$ClientesTableAnnotationComposer get idCliente {
    final $$ClientesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCliente,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableAnnotationComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableAnnotationComposer get idVehiculo {
    final $$VehiculosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idVehiculo,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableAnnotationComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MecanicosTableAnnotationComposer get idMecanico {
    final $$MecanicosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idMecanico,
      referencedTable: $db.mecanicos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MecanicosTableAnnotationComposer(
            $db: $db,
            $table: $db.mecanicos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> manoObraRefs<T extends Object>(
    Expression<T> Function($$ManoObraTableAnnotationComposer a) f,
  ) {
    final $$ManoObraTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.manoObra,
      getReferencedColumn: (t) => t.idOrden,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ManoObraTableAnnotationComposer(
            $db: $db,
            $table: $db.manoObra,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ordenRepuestosRefs<T extends Object>(
    Expression<T> Function($$OrdenRepuestosTableAnnotationComposer a) f,
  ) {
    final $$OrdenRepuestosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenRepuestos,
      getReferencedColumn: (t) => t.idOrden,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenRepuestosTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenRepuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pagosRefs<T extends Object>(
    Expression<T> Function($$PagosTableAnnotationComposer a) f,
  ) {
    final $$PagosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pagos,
      getReferencedColumn: (t) => t.idOrden,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PagosTableAnnotationComposer(
            $db: $db,
            $table: $db.pagos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdenesTableTableManager
    extends
        RootTableManager<
          _$BaseDatosTaller,
          $OrdenesTable,
          OrdenFila,
          $$OrdenesTableFilterComposer,
          $$OrdenesTableOrderingComposer,
          $$OrdenesTableAnnotationComposer,
          $$OrdenesTableCreateCompanionBuilder,
          $$OrdenesTableUpdateCompanionBuilder,
          (OrdenFila, $$OrdenesTableReferences),
          OrdenFila,
          PrefetchHooks Function({
            bool idCliente,
            bool idVehiculo,
            bool idMecanico,
            bool manoObraRefs,
            bool ordenRepuestosRefs,
            bool pagosRefs,
          })
        > {
  $$OrdenesTableTableManager(_$BaseDatosTaller db, $OrdenesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> numero = const Value.absent(),
                Value<String> idCliente = const Value.absent(),
                Value<String> idVehiculo = const Value.absent(),
                Value<String> idMecanico = const Value.absent(),
                Value<DateTime> fechaIngreso = const Value.absent(),
                Value<String> problema = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<int?> kilometrajeIngreso = const Value.absent(),
                Value<DateTime?> fechaEntrega = const Value.absent(),
                Value<bool> stockDevuelto = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrdenesCompanion(
                id: id,
                numero: numero,
                idCliente: idCliente,
                idVehiculo: idVehiculo,
                idMecanico: idMecanico,
                fechaIngreso: fechaIngreso,
                problema: problema,
                estado: estado,
                kilometrajeIngreso: kilometrajeIngreso,
                fechaEntrega: fechaEntrega,
                stockDevuelto: stockDevuelto,
                actualizadoEn: actualizadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int numero,
                required String idCliente,
                required String idVehiculo,
                required String idMecanico,
                required DateTime fechaIngreso,
                required String problema,
                required String estado,
                Value<int?> kilometrajeIngreso = const Value.absent(),
                Value<DateTime?> fechaEntrega = const Value.absent(),
                Value<bool> stockDevuelto = const Value.absent(),
                required DateTime actualizadoEn,
                Value<int> rowid = const Value.absent(),
              }) => OrdenesCompanion.insert(
                id: id,
                numero: numero,
                idCliente: idCliente,
                idVehiculo: idVehiculo,
                idMecanico: idMecanico,
                fechaIngreso: fechaIngreso,
                problema: problema,
                estado: estado,
                kilometrajeIngreso: kilometrajeIngreso,
                fechaEntrega: fechaEntrega,
                stockDevuelto: stockDevuelto,
                actualizadoEn: actualizadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrdenesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                idCliente = false,
                idVehiculo = false,
                idMecanico = false,
                manoObraRefs = false,
                ordenRepuestosRefs = false,
                pagosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (manoObraRefs) db.manoObra,
                    if (ordenRepuestosRefs) db.ordenRepuestos,
                    if (pagosRefs) db.pagos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (idCliente) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.idCliente,
                            referencedTable: $$OrdenesTableReferences
                                ._idClienteTable(db),
                            referencedColumn: $$OrdenesTableReferences
                                ._idClienteTable(db)
                                .id,
                          ) as T;
                        }
                        if (idVehiculo) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.idVehiculo,
                            referencedTable: $$OrdenesTableReferences
                                ._idVehiculoTable(db),
                            referencedColumn: $$OrdenesTableReferences
                                ._idVehiculoTable(db)
                                .id,
                          ) as T;
                        }
                        if (idMecanico) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.idMecanico,
                            referencedTable: $$OrdenesTableReferences
                                ._idMecanicoTable(db),
                            referencedColumn: $$OrdenesTableReferences
                                ._idMecanicoTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (manoObraRefs)
                        await $_getPrefetchedData<
                          OrdenFila,
                          $OrdenesTable,
                          ManoObraFila
                        >(
                          currentTable: table,
                          referencedTable: $$OrdenesTableReferences
                              ._manoObraRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdenesTableReferences(
                                db,
                                table,
                                p0,
                              ).manoObraRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.idOrden == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ordenRepuestosRefs)
                        await $_getPrefetchedData<
                          OrdenFila,
                          $OrdenesTable,
                          OrdenRepuestoFila
                        >(
                          currentTable: table,
                          referencedTable: $$OrdenesTableReferences
                              ._ordenRepuestosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdenesTableReferences(
                                db,
                                table,
                                p0,
                              ).ordenRepuestosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.idOrden == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pagosRefs)
                        await $_getPrefetchedData<
                          OrdenFila,
                          $OrdenesTable,
                          PagoFila
                        >(
                          currentTable: table,
                          referencedTable: $$OrdenesTableReferences
                              ._pagosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdenesTableReferences(db, table, p0).pagosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.idOrden == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OrdenesTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatosTaller,
      $OrdenesTable,
      OrdenFila,
      $$OrdenesTableFilterComposer,
      $$OrdenesTableOrderingComposer,
      $$OrdenesTableAnnotationComposer,
      $$OrdenesTableCreateCompanionBuilder,
      $$OrdenesTableUpdateCompanionBuilder,
      (OrdenFila, $$OrdenesTableReferences),
      OrdenFila,
      PrefetchHooks Function({
        bool idCliente,
        bool idVehiculo,
        bool idMecanico,
        bool manoObraRefs,
        bool ordenRepuestosRefs,
        bool pagosRefs,
      })
    >;
typedef $$ManoObraTableCreateCompanionBuilder = ManoObraCompanion Function({
  required String id,
  required String idOrden,
  required String descripcion,
  required double precio,
  required int posicion,
  Value<int> rowid,
});
typedef $$ManoObraTableUpdateCompanionBuilder = ManoObraCompanion Function({
  Value<String> id,
  Value<String> idOrden,
  Value<String> descripcion,
  Value<double> precio,
  Value<int> posicion,
  Value<int> rowid,
});

final class $$ManoObraTableReferences
    extends BaseReferences<_$BaseDatosTaller, $ManoObraTable, ManoObraFila> {
  $$ManoObraTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdenesTable _idOrdenTable(_$BaseDatosTaller db) => db.ordenes
      .createAlias($_aliasNameGenerator(db.manoObra.idOrden, db.ordenes.id));

  $$OrdenesTableProcessedTableManager get idOrden {
    final $_column = $_itemColumn<String>('id_orden')!;

    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idOrdenTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ManoObraTableFilterComposer
    extends Composer<_$BaseDatosTaller, $ManoObraTable> {
  $$ManoObraTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get posicion => $composableBuilder(
    column: $table.posicion,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdenesTableFilterComposer get idOrden {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ManoObraTableOrderingComposer
    extends Composer<_$BaseDatosTaller, $ManoObraTable> {
  $$ManoObraTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get posicion => $composableBuilder(
    column: $table.posicion,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdenesTableOrderingComposer get idOrden {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableOrderingComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ManoObraTableAnnotationComposer
    extends Composer<_$BaseDatosTaller, $ManoObraTable> {
  $$ManoObraTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<int> get posicion =>
      $composableBuilder(column: $table.posicion, builder: (column) => column);

  $$OrdenesTableAnnotationComposer get idOrden {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ManoObraTableTableManager
    extends
        RootTableManager<
          _$BaseDatosTaller,
          $ManoObraTable,
          ManoObraFila,
          $$ManoObraTableFilterComposer,
          $$ManoObraTableOrderingComposer,
          $$ManoObraTableAnnotationComposer,
          $$ManoObraTableCreateCompanionBuilder,
          $$ManoObraTableUpdateCompanionBuilder,
          (ManoObraFila, $$ManoObraTableReferences),
          ManoObraFila,
          PrefetchHooks Function({bool idOrden})
        > {
  $$ManoObraTableTableManager(_$BaseDatosTaller db, $ManoObraTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ManoObraTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ManoObraTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ManoObraTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> idOrden = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<double> precio = const Value.absent(),
                Value<int> posicion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ManoObraCompanion(
                id: id,
                idOrden: idOrden,
                descripcion: descripcion,
                precio: precio,
                posicion: posicion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String idOrden,
                required String descripcion,
                required double precio,
                required int posicion,
                Value<int> rowid = const Value.absent(),
              }) => ManoObraCompanion.insert(
                id: id,
                idOrden: idOrden,
                descripcion: descripcion,
                precio: precio,
                posicion: posicion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ManoObraTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({idOrden = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (idOrden) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.idOrden,
                        referencedTable: $$ManoObraTableReferences
                            ._idOrdenTable(db),
                        referencedColumn: $$ManoObraTableReferences
                            ._idOrdenTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ManoObraTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatosTaller,
      $ManoObraTable,
      ManoObraFila,
      $$ManoObraTableFilterComposer,
      $$ManoObraTableOrderingComposer,
      $$ManoObraTableAnnotationComposer,
      $$ManoObraTableCreateCompanionBuilder,
      $$ManoObraTableUpdateCompanionBuilder,
      (ManoObraFila, $$ManoObraTableReferences),
      ManoObraFila,
      PrefetchHooks Function({bool idOrden})
    >;
typedef $$OrdenRepuestosTableCreateCompanionBuilder =
    OrdenRepuestosCompanion Function({
      Value<int> id,
      required String idOrden,
      required String idRepuesto,
      required String codigo,
      required String nombre,
      required int cantidad,
      required double precioUnitario,
    });
typedef $$OrdenRepuestosTableUpdateCompanionBuilder =
    OrdenRepuestosCompanion Function({
      Value<int> id,
      Value<String> idOrden,
      Value<String> idRepuesto,
      Value<String> codigo,
      Value<String> nombre,
      Value<int> cantidad,
      Value<double> precioUnitario,
    });

final class $$OrdenRepuestosTableReferences
    extends
        BaseReferences<
          _$BaseDatosTaller,
          $OrdenRepuestosTable,
          OrdenRepuestoFila
        > {
  $$OrdenRepuestosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $OrdenesTable _idOrdenTable(_$BaseDatosTaller db) =>
      db.ordenes.createAlias(
        $_aliasNameGenerator(db.ordenRepuestos.idOrden, db.ordenes.id),
      );

  $$OrdenesTableProcessedTableManager get idOrden {
    final $_column = $_itemColumn<String>('id_orden')!;

    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idOrdenTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RepuestosTable _idRepuestoTable(_$BaseDatosTaller db) =>
      db.repuestos.createAlias(
        $_aliasNameGenerator(db.ordenRepuestos.idRepuesto, db.repuestos.id),
      );

  $$RepuestosTableProcessedTableManager get idRepuesto {
    final $_column = $_itemColumn<String>('id_repuesto')!;

    final manager = $$RepuestosTableTableManager(
      $_db,
      $_db.repuestos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idRepuestoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OrdenRepuestosTableFilterComposer
    extends Composer<_$BaseDatosTaller, $OrdenRepuestosTable> {
  $$OrdenRepuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdenesTableFilterComposer get idOrden {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepuestosTableFilterComposer get idRepuesto {
    final $$RepuestosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRepuesto,
      referencedTable: $db.repuestos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosTableFilterComposer(
            $db: $db,
            $table: $db.repuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdenRepuestosTableOrderingComposer
    extends Composer<_$BaseDatosTaller, $OrdenRepuestosTable> {
  $$OrdenRepuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdenesTableOrderingComposer get idOrden {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableOrderingComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepuestosTableOrderingComposer get idRepuesto {
    final $$RepuestosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRepuesto,
      referencedTable: $db.repuestos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosTableOrderingComposer(
            $db: $db,
            $table: $db.repuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdenRepuestosTableAnnotationComposer
    extends Composer<_$BaseDatosTaller, $OrdenRepuestosTable> {
  $$OrdenRepuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => column,
  );

  $$OrdenesTableAnnotationComposer get idOrden {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepuestosTableAnnotationComposer get idRepuesto {
    final $$RepuestosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRepuesto,
      referencedTable: $db.repuestos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosTableAnnotationComposer(
            $db: $db,
            $table: $db.repuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdenRepuestosTableTableManager
    extends
        RootTableManager<
          _$BaseDatosTaller,
          $OrdenRepuestosTable,
          OrdenRepuestoFila,
          $$OrdenRepuestosTableFilterComposer,
          $$OrdenRepuestosTableOrderingComposer,
          $$OrdenRepuestosTableAnnotationComposer,
          $$OrdenRepuestosTableCreateCompanionBuilder,
          $$OrdenRepuestosTableUpdateCompanionBuilder,
          (OrdenRepuestoFila, $$OrdenRepuestosTableReferences),
          OrdenRepuestoFila,
          PrefetchHooks Function({bool idOrden, bool idRepuesto})
        > {
  $$OrdenRepuestosTableTableManager(
    _$BaseDatosTaller db,
    $OrdenRepuestosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenRepuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenRepuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenRepuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> idOrden = const Value.absent(),
                Value<String> idRepuesto = const Value.absent(),
                Value<String> codigo = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> cantidad = const Value.absent(),
                Value<double> precioUnitario = const Value.absent(),
              }) => OrdenRepuestosCompanion(
                id: id,
                idOrden: idOrden,
                idRepuesto: idRepuesto,
                codigo: codigo,
                nombre: nombre,
                cantidad: cantidad,
                precioUnitario: precioUnitario,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String idOrden,
                required String idRepuesto,
                required String codigo,
                required String nombre,
                required int cantidad,
                required double precioUnitario,
              }) => OrdenRepuestosCompanion.insert(
                id: id,
                idOrden: idOrden,
                idRepuesto: idRepuesto,
                codigo: codigo,
                nombre: nombre,
                cantidad: cantidad,
                precioUnitario: precioUnitario,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrdenRepuestosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({idOrden = false, idRepuesto = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (idOrden) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.idOrden,
                        referencedTable: $$OrdenRepuestosTableReferences
                            ._idOrdenTable(db),
                        referencedColumn: $$OrdenRepuestosTableReferences
                            ._idOrdenTable(db)
                            .id,
                      ) as T;
                    }
                    if (idRepuesto) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.idRepuesto,
                        referencedTable: $$OrdenRepuestosTableReferences
                            ._idRepuestoTable(db),
                        referencedColumn: $$OrdenRepuestosTableReferences
                            ._idRepuestoTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrdenRepuestosTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatosTaller,
      $OrdenRepuestosTable,
      OrdenRepuestoFila,
      $$OrdenRepuestosTableFilterComposer,
      $$OrdenRepuestosTableOrderingComposer,
      $$OrdenRepuestosTableAnnotationComposer,
      $$OrdenRepuestosTableCreateCompanionBuilder,
      $$OrdenRepuestosTableUpdateCompanionBuilder,
      (OrdenRepuestoFila, $$OrdenRepuestosTableReferences),
      OrdenRepuestoFila,
      PrefetchHooks Function({bool idOrden, bool idRepuesto})
    >;
typedef $$PagosTableCreateCompanionBuilder = PagosCompanion Function({
  required String id,
  required String idOrden,
  required double monto,
  required DateTime fecha,
  required String metodo,
  required int posicion,
  Value<int> rowid,
});
typedef $$PagosTableUpdateCompanionBuilder = PagosCompanion Function({
  Value<String> id,
  Value<String> idOrden,
  Value<double> monto,
  Value<DateTime> fecha,
  Value<String> metodo,
  Value<int> posicion,
  Value<int> rowid,
});

final class $$PagosTableReferences
    extends BaseReferences<_$BaseDatosTaller, $PagosTable, PagoFila> {
  $$PagosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdenesTable _idOrdenTable(_$BaseDatosTaller db) => db.ordenes
      .createAlias($_aliasNameGenerator(db.pagos.idOrden, db.ordenes.id));

  $$OrdenesTableProcessedTableManager get idOrden {
    final $_column = $_itemColumn<String>('id_orden')!;

    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idOrdenTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PagosTableFilterComposer
    extends Composer<_$BaseDatosTaller, $PagosTable> {
  $$PagosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metodo => $composableBuilder(
    column: $table.metodo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get posicion => $composableBuilder(
    column: $table.posicion,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdenesTableFilterComposer get idOrden {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PagosTableOrderingComposer
    extends Composer<_$BaseDatosTaller, $PagosTable> {
  $$PagosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodo => $composableBuilder(
    column: $table.metodo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get posicion => $composableBuilder(
    column: $table.posicion,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdenesTableOrderingComposer get idOrden {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableOrderingComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PagosTableAnnotationComposer
    extends Composer<_$BaseDatosTaller, $PagosTable> {
  $$PagosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get metodo =>
      $composableBuilder(column: $table.metodo, builder: (column) => column);

  GeneratedColumn<int> get posicion =>
      $composableBuilder(column: $table.posicion, builder: (column) => column);

  $$OrdenesTableAnnotationComposer get idOrden {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PagosTableTableManager
    extends
        RootTableManager<
          _$BaseDatosTaller,
          $PagosTable,
          PagoFila,
          $$PagosTableFilterComposer,
          $$PagosTableOrderingComposer,
          $$PagosTableAnnotationComposer,
          $$PagosTableCreateCompanionBuilder,
          $$PagosTableUpdateCompanionBuilder,
          (PagoFila, $$PagosTableReferences),
          PagoFila,
          PrefetchHooks Function({bool idOrden})
        > {
  $$PagosTableTableManager(_$BaseDatosTaller db, $PagosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PagosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PagosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PagosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> idOrden = const Value.absent(),
                Value<double> monto = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String> metodo = const Value.absent(),
                Value<int> posicion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PagosCompanion(
                id: id,
                idOrden: idOrden,
                monto: monto,
                fecha: fecha,
                metodo: metodo,
                posicion: posicion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String idOrden,
                required double monto,
                required DateTime fecha,
                required String metodo,
                required int posicion,
                Value<int> rowid = const Value.absent(),
              }) => PagosCompanion.insert(
                id: id,
                idOrden: idOrden,
                monto: monto,
                fecha: fecha,
                metodo: metodo,
                posicion: posicion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PagosTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({idOrden = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (idOrden) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.idOrden,
                        referencedTable: $$PagosTableReferences._idOrdenTable(
                          db,
                        ),
                        referencedColumn: $$PagosTableReferences
                            ._idOrdenTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PagosTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatosTaller,
      $PagosTable,
      PagoFila,
      $$PagosTableFilterComposer,
      $$PagosTableOrderingComposer,
      $$PagosTableAnnotationComposer,
      $$PagosTableCreateCompanionBuilder,
      $$PagosTableUpdateCompanionBuilder,
      (PagoFila, $$PagosTableReferences),
      PagoFila,
      PrefetchHooks Function({bool idOrden})
    >;

class $BaseDatosTallerManager {
  final _$BaseDatosTaller _db;
  $BaseDatosTallerManager(this._db);
  $$MecanicosTableTableManager get mecanicos =>
      $$MecanicosTableTableManager(_db, _db.mecanicos);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$VehiculosTableTableManager get vehiculos =>
      $$VehiculosTableTableManager(_db, _db.vehiculos);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db, _db.repuestos);
  $$OrdenesTableTableManager get ordenes =>
      $$OrdenesTableTableManager(_db, _db.ordenes);
  $$ManoObraTableTableManager get manoObra =>
      $$ManoObraTableTableManager(_db, _db.manoObra);
  $$OrdenRepuestosTableTableManager get ordenRepuestos =>
      $$OrdenRepuestosTableTableManager(_db, _db.ordenRepuestos);
  $$PagosTableTableManager get pagos =>
      $$PagosTableTableManager(_db, _db.pagos);
}
