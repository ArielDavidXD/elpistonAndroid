import 'package:drift/drift.dart';

import '../models/cliente.dart';
import '../models/mecanico.dart';
import '../models/orden_servicio.dart';
import '../models/repuesto.dart';
import '../models/vehiculo.dart';
import 'base_datos.dart';
import 'datos_taller.dart';
import 'repositorio_taller.dart';

/// Persistencia real con Drift/SQLite.
///
/// Cada cambio de AppState se guarda como una transacción que reemplaza el
/// contenido de las tablas. Esto mantiene una única fuente de verdad en memoria
/// y garantiza que la base quede siempre consistente.
class RepositorioDrift implements RepositorioTaller {
  RepositorioDrift({BaseDatosTaller? baseDatos})
    : _baseDatos = baseDatos ?? BaseDatosTaller();

  final BaseDatosTaller _baseDatos;

  @override
  Future<DatosTaller?> cargar() async {
    final mecanicos = await _baseDatos.select(_baseDatos.mecanicos).get();
    final clientes = await _baseDatos.select(_baseDatos.clientes).get();
    final vehiculos = await _baseDatos.select(_baseDatos.vehiculos).get();
    final repuestos = await _baseDatos.select(_baseDatos.repuestos).get();
    final ordenes = await _baseDatos.select(_baseDatos.ordenes).get();
    final manoObra = await (_baseDatos.select(
      _baseDatos.manoObra,
    )..orderBy([(fila) => OrderingTerm(expression: fila.posicion)])).get();
    final ordenRepuestos = await (_baseDatos.select(
      _baseDatos.ordenRepuestos,
    )..orderBy([(fila) => OrderingTerm(expression: fila.id)])).get();
    final pagos = await (_baseDatos.select(
      _baseDatos.pagos,
    )..orderBy([(fila) => OrderingTerm(expression: fila.posicion)])).get();

    if (mecanicos.isEmpty &&
        clientes.isEmpty &&
        vehiculos.isEmpty &&
        repuestos.isEmpty &&
        ordenes.isEmpty) {
      return null;
    }

    final manoPorOrden = <String, List<TrabajoManoObra>>{};
    for (final fila in manoObra) {
      (manoPorOrden[fila.idOrden] ??= []).add(
        TrabajoManoObra(
          id: fila.id,
          descripcion: fila.descripcion,
          precio: fila.precio,
        ),
      );
    }

    final repuestosPorOrden = <String, List<RepuestoUsado>>{};
    for (final fila in ordenRepuestos) {
      (repuestosPorOrden[fila.idOrden] ??= []).add(
        RepuestoUsado(
          idRepuesto: fila.idRepuesto,
          codigo: fila.codigo,
          nombre: fila.nombre,
          cantidad: fila.cantidad,
          precioUnitario: fila.precioUnitario,
        ),
      );
    }

    final pagosPorOrden = <String, List<Pago>>{};
    for (final fila in pagos) {
      (pagosPorOrden[fila.idOrden] ??= []).add(
        Pago(
          id: fila.id,
          monto: fila.monto,
          fecha: fila.fecha,
          metodo: fila.metodo,
        ),
      );
    }

    return DatosTaller(
      mecanicos: mecanicos
          .map(
            (fila) => Mecanico(
              id: fila.id,
              nombre: fila.nombre,
              especialidad: fila.especialidad,
            ),
          )
          .toList(),
      clientes: clientes
          .map(
            (fila) => Cliente(
              id: fila.id,
              nombre: fila.nombre,
              telefono: fila.telefono,
              direccion: fila.direccion,
              creadoEn: fila.creadoEn,
            ),
          )
          .toList(),
      vehiculos: vehiculos
          .map(
            (fila) => Vehiculo(
              id: fila.id,
              idCliente: fila.idCliente,
              matricula: fila.matricula,
              marca: fila.marca,
              modelo: fila.modelo,
              anio: fila.anio,
              kilometraje: fila.kilometraje,
              actualizadoEn: fila.actualizadoEn,
            ),
          )
          .toList(),
      repuestos: repuestos
          .map(
            (fila) => Repuesto(
              id: fila.id,
              codigo: fila.codigo,
              nombre: fila.nombre,
              precio: fila.precio,
              existencias: fila.existencias,
              stockMinimo: fila.stockMinimo,
            ),
          )
          .toList(),
      ordenes: ordenes
          .map(
            (fila) => OrdenServicio(
              id: fila.id,
              numero: fila.numero,
              idCliente: fila.idCliente,
              idVehiculo: fila.idVehiculo,
              idMecanico: fila.idMecanico,
              fechaIngreso: fila.fechaIngreso,
              problema: fila.problema,
              estado: EstadoOrden.values.firstWhere(
                (estado) => estado.name == fila.estado,
                orElse: () => EstadoOrden.recibida,
              ),
              kilometrajeIngreso: fila.kilometrajeIngreso,
              manoObra: manoPorOrden[fila.id] ?? [],
              repuestos: repuestosPorOrden[fila.id] ?? [],
              pagos: pagosPorOrden[fila.id] ?? [],
              fechaEntrega: fila.fechaEntrega,
              stockDevuelto: fila.stockDevuelto,
              actualizadoEn: fila.actualizadoEn,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> guardar(DatosTaller datos) async {
    await _baseDatos.transaction(() async {
      await _baseDatos.delete(_baseDatos.pagos).go();
      await _baseDatos.delete(_baseDatos.ordenRepuestos).go();
      await _baseDatos.delete(_baseDatos.manoObra).go();
      await _baseDatos.delete(_baseDatos.ordenes).go();
      await _baseDatos.delete(_baseDatos.vehiculos).go();
      await _baseDatos.delete(_baseDatos.clientes).go();
      await _baseDatos.delete(_baseDatos.mecanicos).go();
      await _baseDatos.delete(_baseDatos.repuestos).go();

      await _baseDatos.batch((batch) {
        batch.insertAll(
          _baseDatos.mecanicos,
          datos.mecanicos
              .map(
                (item) => MecanicosCompanion.insert(
                  id: item.id,
                  nombre: item.nombre,
                  especialidad: item.especialidad,
                ),
              )
              .toList(),
        );
        batch.insertAll(
          _baseDatos.clientes,
          datos.clientes
              .map(
                (item) => ClientesCompanion.insert(
                  id: item.id,
                  nombre: item.nombre,
                  telefono: item.telefono,
                  direccion: Value(item.direccion),
                  creadoEn: item.creadoEn,
                ),
              )
              .toList(),
        );
        batch.insertAll(
          _baseDatos.vehiculos,
          datos.vehiculos
              .map(
                (item) => VehiculosCompanion.insert(
                  id: item.id,
                  idCliente: item.idCliente,
                  matricula: item.matricula,
                  marca: item.marca,
                  modelo: item.modelo,
                  anio: item.anio,
                  kilometraje: item.kilometraje,
                  actualizadoEn: item.actualizadoEn,
                ),
              )
              .toList(),
        );
        batch.insertAll(
          _baseDatos.repuestos,
          datos.repuestos
              .map(
                (item) => RepuestosCompanion.insert(
                  id: item.id,
                  codigo: item.codigo,
                  nombre: item.nombre,
                  precio: item.precio,
                  existencias: item.existencias,
                  stockMinimo: item.stockMinimo,
                ),
              )
              .toList(),
        );
        batch.insertAll(
          _baseDatos.ordenes,
          datos.ordenes
              .map(
                (item) => OrdenesCompanion.insert(
                  id: item.id,
                  numero: item.numero,
                  idCliente: item.idCliente,
                  idVehiculo: item.idVehiculo,
                  idMecanico: item.idMecanico,
                  fechaIngreso: item.fechaIngreso,
                  problema: item.problema,
                  estado: item.estado.name,
                  kilometrajeIngreso: Value(item.kilometrajeIngreso),
                  fechaEntrega: Value(item.fechaEntrega),
                  stockDevuelto: Value(item.stockDevuelto),
                  actualizadoEn: item.actualizadoEn,
                ),
              )
              .toList(),
        );

        final manoObra = <ManoObraCompanion>[];
        final repuestosUsados = <OrdenRepuestosCompanion>[];
        final pagos = <PagosCompanion>[];
        for (final orden in datos.ordenes) {
          for (var indice = 0; indice < orden.manoObra.length; indice++) {
            final trabajo = orden.manoObra[indice];
            manoObra.add(
              ManoObraCompanion.insert(
                id: trabajo.id,
                idOrden: orden.id,
                descripcion: trabajo.descripcion,
                precio: trabajo.precio,
                posicion: indice,
              ),
            );
          }
          for (final usado in orden.repuestos) {
            repuestosUsados.add(
              OrdenRepuestosCompanion.insert(
                idOrden: orden.id,
                idRepuesto: usado.idRepuesto,
                codigo: usado.codigo,
                nombre: usado.nombre,
                cantidad: usado.cantidad,
                precioUnitario: usado.precioUnitario,
              ),
            );
          }
          for (var indice = 0; indice < orden.pagos.length; indice++) {
            final pago = orden.pagos[indice];
            pagos.add(
              PagosCompanion.insert(
                id: pago.id,
                idOrden: orden.id,
                monto: pago.monto,
                fecha: pago.fecha,
                metodo: pago.metodo,
                posicion: indice,
              ),
            );
          }
        }

        batch.insertAll(_baseDatos.manoObra, manoObra);
        batch.insertAll(_baseDatos.ordenRepuestos, repuestosUsados);
        batch.insertAll(_baseDatos.pagos, pagos);
      });
    });
  }

  @override
  Future<void> cerrar() => _baseDatos.close();
}
