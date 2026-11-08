import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'base_datos.g.dart';

@DataClassName('MecanicoFila')
class Mecanicos extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text()();
  TextColumn get especialidad => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ClienteFila')
class Clientes extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text()();
  TextColumn get telefono => text()();
  TextColumn get direccion => text().nullable()();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('VehiculoFila')
class Vehiculos extends Table {
  TextColumn get id => text()();
  TextColumn get idCliente => text().customConstraint(
    'NOT NULL REFERENCES clientes(id) ON DELETE CASCADE',
  )();
  TextColumn get matricula => text().unique()();
  TextColumn get marca => text()();
  TextColumn get modelo => text()();
  IntColumn get anio => integer()();
  IntColumn get kilometraje => integer()();
  DateTimeColumn get actualizadoEn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RepuestoFila')
class Repuestos extends Table {
  TextColumn get id => text()();
  TextColumn get codigo => text().unique()();
  TextColumn get nombre => text()();
  RealColumn get precio => real()();
  IntColumn get existencias => integer()();
  IntColumn get stockMinimo => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('OrdenFila')
class Ordenes extends Table {
  TextColumn get id => text()();
  IntColumn get numero => integer().unique()();
  TextColumn get idCliente => text().customConstraint(
    'NOT NULL REFERENCES clientes(id) ON DELETE RESTRICT',
  )();
  TextColumn get idVehiculo => text().customConstraint(
    'NOT NULL REFERENCES vehiculos(id) ON DELETE RESTRICT',
  )();
  TextColumn get idMecanico => text().customConstraint(
    'NOT NULL REFERENCES mecanicos(id) ON DELETE RESTRICT',
  )();
  DateTimeColumn get fechaIngreso => dateTime()();
  TextColumn get problema => text()();
  TextColumn get estado => text()();
  IntColumn get kilometrajeIngreso => integer().nullable()();
  DateTimeColumn get fechaEntrega => dateTime().nullable()();
  BoolColumn get stockDevuelto =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get actualizadoEn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ManoObraFila')
class ManoObra extends Table {
  TextColumn get id => text()();
  TextColumn get idOrden => text().customConstraint(
    'NOT NULL REFERENCES ordenes(id) ON DELETE CASCADE',
  )();
  TextColumn get descripcion => text()();
  RealColumn get precio => real()();
  IntColumn get posicion => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('OrdenRepuestoFila')
class OrdenRepuestos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get idOrden => text().customConstraint(
    'NOT NULL REFERENCES ordenes(id) ON DELETE CASCADE',
  )();
  TextColumn get idRepuesto => text().customConstraint(
    'NOT NULL REFERENCES repuestos(id) ON DELETE RESTRICT',
  )();
  TextColumn get codigo => text()();
  TextColumn get nombre => text()();
  IntColumn get cantidad => integer()();
  RealColumn get precioUnitario => real()();
}

@DataClassName('PagoFila')
class Pagos extends Table {
  TextColumn get id => text()();
  TextColumn get idOrden => text().customConstraint(
    'NOT NULL REFERENCES ordenes(id) ON DELETE CASCADE',
  )();
  RealColumn get monto => real()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get metodo => text()();
  IntColumn get posicion => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Mecanicos,
    Clientes,
    Vehiculos,
    Repuestos,
    Ordenes,
    ManoObra,
    OrdenRepuestos,
    Pagos,
  ],
)
class BaseDatosTaller extends _$BaseDatosTaller {
  BaseDatosTaller() : super(driftDatabase(name: 'el_piston'));

  BaseDatosTaller.conEjecutor(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async => migrator.createAll(),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
