import '../models/cliente.dart';
import '../models/mecanico.dart';
import '../models/orden_servicio.dart';
import '../models/repuesto.dart';
import '../models/vehiculo.dart';

class DatosDemo {
  const DatosDemo({
    required this.clientes,
    required this.vehiculos,
    required this.mecanicos,
    required this.repuestos,
    required this.ordenes,
  });

  final List<Cliente> clientes;
  final List<Vehiculo> vehiculos;
  final List<Mecanico> mecanicos;
  final List<Repuesto> repuestos;
  final List<OrdenServicio> ordenes;
}

DateTime _fecha(int dias, int hora, int minuto) {
  final ahora = DateTime.now();
  return DateTime(ahora.year, ahora.month, ahora.day + dias, hora, minuto);
}

DatosDemo crearDatosDemo() {
  final mecanicos = [
    Mecanico(
      id: 'm1',
      nombre: 'Marcos Ferreyra',
      especialidad: 'Motor y frenos',
    ),
    Mecanico(
      id: 'm2',
      nombre: 'Lucas Benítez',
      especialidad: 'Suspensión y electricidad',
    ),
  ];

  final clientes = [
    Cliente(
      id: 'c1',
      nombre: 'María Fernández',
      telefono: '35123456',
      direccion: 'Av. Colón 1240',
      creadoEn: DateTime(2025, 3, 12),
    ),
    Cliente(
      id: 'c2',
      nombre: 'Jorge Medina',
      telefono: '35156789',
      direccion: null,
      creadoEn: DateTime(2025, 5, 8),
    ),
    Cliente(
      id: 'c3',
      nombre: 'Carla Suárez',
      telefono: '35187654',
      direccion: 'Los Álamos 88',
      creadoEn: DateTime(2025, 8, 21),
    ),
    Cliente(
      id: 'c4',
      nombre: 'Diego Acosta',
      telefono: '35134567',
      direccion: null,
      creadoEn: DateTime(2026, 1, 15),
    ),
    Cliente(
      id: 'c5',
      nombre: 'Lucía Romano',
      telefono: '35176543',
      direccion: 'San Martín 450',
      creadoEn: DateTime(2026, 4, 3),
    ),
    Cliente(
      id: 'c6',
      nombre: 'Pablo Quiroga',
      telefono: '35165432',
      direccion: 'Ruta 9 km 12',
      creadoEn: DateTime(2026, 7, 19),
    ),
  ];

  final vehiculos = [
    Vehiculo(
      id: 'v1',
      idCliente: 'c1',
      matricula: 'AB123CD',
      marca: 'Toyota',
      modelo: 'Corolla',
      anio: 2018,
      kilometraje: 84500,
      actualizadoEn: _fecha(-40, 9, 0),
    ),
    Vehiculo(
      id: 'v2',
      idCliente: 'c1',
      matricula: 'AC456EF',
      marca: 'Volkswagen',
      modelo: 'Gol',
      anio: 2012,
      kilometraje: 152300,
      actualizadoEn: _fecha(-3, 10, 0),
    ),
    Vehiculo(
      id: 'v3',
      idCliente: 'c2',
      matricula: 'AD789GH',
      marca: 'Ford',
      modelo: 'Ranger',
      anio: 2020,
      kilometraje: 62300,
      actualizadoEn: _fecha(-2, 11, 0),
    ),
    Vehiculo(
      id: 'v4',
      idCliente: 'c3',
      matricula: 'AE012IJ',
      marca: 'Renault',
      modelo: 'Sandero',
      anio: 2016,
      kilometraje: 98700,
      actualizadoEn: _fecha(-1, 12, 0),
    ),
    Vehiculo(
      id: 'v5',
      idCliente: 'c4',
      matricula: 'AF345KL',
      marca: 'Fiat',
      modelo: 'Cronos',
      anio: 2021,
      kilometraje: 34100,
      actualizadoEn: _fecha(0, 8, 30),
    ),
    Vehiculo(
      id: 'v6',
      idCliente: 'c5',
      matricula: 'AG678MN',
      marca: 'Chevrolet',
      modelo: 'Onix',
      anio: 2019,
      kilometraje: 71500,
      actualizadoEn: _fecha(0, 9, 0),
    ),
    Vehiculo(
      id: 'v7',
      idCliente: 'c6',
      matricula: 'AH901OP',
      marca: 'Peugeot',
      modelo: '208',
      anio: 2017,
      kilometraje: 112000,
      actualizadoEn: _fecha(-6, 15, 0),
    ),
    Vehiculo(
      id: 'v8',
      idCliente: 'c3',
      matricula: 'AI234QR',
      marca: 'Honda',
      modelo: 'CB 190',
      anio: 2022,
      kilometraje: 12800,
      actualizadoEn: _fecha(-3, 14, 0),
    ),
  ];

  final repuestos = [
    Repuesto(
      id: 'r1',
      codigo: 'ACE-5W30',
      nombre: 'Aceite sintético 5W-30',
      precio: 12500,
      existencias: 12,
      stockMinimo: 4,
    ),
    Repuesto(
      id: 'r2',
      codigo: 'FIL-ACE',
      nombre: 'Filtro de aceite',
      precio: 4800,
      existencias: 8,
      stockMinimo: 3,
    ),
    Repuesto(
      id: 'r3',
      codigo: 'FIL-AIR',
      nombre: 'Filtro de aire',
      precio: 6200,
      existencias: 2,
      stockMinimo: 3,
    ),
    Repuesto(
      id: 'r4',
      codigo: 'BUJ-NGK',
      nombre: 'Bujía NGK (unidad)',
      precio: 3500,
      existencias: 16,
      stockMinimo: 6,
    ),
    Repuesto(
      id: 'r5',
      codigo: 'FRE-PAD',
      nombre: 'Pastillas de freno delanteras',
      precio: 28500,
      existencias: 3,
      stockMinimo: 2,
    ),
    Repuesto(
      id: 'r6',
      codigo: 'FRE-DIS',
      nombre: 'Disco de freno',
      precio: 42000,
      existencias: 2,
      stockMinimo: 2,
    ),
    Repuesto(
      id: 'r7',
      codigo: 'SUS-AMO',
      nombre: 'Amortiguador delantero',
      precio: 56000,
      existencias: 4,
      stockMinimo: 2,
    ),
    Repuesto(
      id: 'r8',
      codigo: 'ELE-BAT',
      nombre: 'Batería 12V 65Ah',
      precio: 89000,
      existencias: 2,
      stockMinimo: 1,
    ),
    Repuesto(
      id: 'r9',
      codigo: 'MOT-COR',
      nombre: 'Correa de distribución',
      precio: 24000,
      existencias: 1,
      stockMinimo: 2,
    ),
    Repuesto(
      id: 'r10',
      codigo: 'REF-LIQ',
      nombre: 'Líquido refrigerante 5L',
      precio: 9800,
      existencias: 6,
      stockMinimo: 2,
    ),
    Repuesto(
      id: 'r11',
      codigo: 'CAJ-ATF',
      nombre: 'Aceite de caja 1L',
      precio: 15600,
      existencias: 3,
      stockMinimo: 2,
    ),
    Repuesto(
      id: 'r12',
      codigo: 'FIL-COM',
      nombre: 'Filtro de combustible',
      precio: 7200,
      existencias: 5,
      stockMinimo: 2,
    ),
  ];

  Repuesto porId(String id) => repuestos.firstWhere((item) => item.id == id);

  RepuestoUsado usado(String id, int cantidad) {
    final repuesto = porId(id);
    return RepuestoUsado(
      idRepuesto: repuesto.id,
      codigo: repuesto.codigo,
      nombre: repuesto.nombre,
      cantidad: cantidad,
      precioUnitario: repuesto.precio,
    );
  }

  Pago pago(String id, double monto, DateTime fecha, String metodo) =>
      Pago(id: id, monto: monto, fecha: fecha, metodo: metodo);

  final ordenes = [
    OrdenServicio(
      id: 'o1',
      numero: 1,
      idCliente: 'c1',
      idVehiculo: 'v1',
      idMecanico: 'm1',
      fechaIngreso: _fecha(-40, 9, 0),
      problema: 'Ruido y vibración al frenar. Revisar el tren delantero.',
      estado: EstadoOrden.entregada,
      kilometrajeIngreso: 84100,
      manoObra: [
        TrabajoManoObra(
          id: 't1',
          descripcion: 'Cambio de pastillas de freno',
          precio: 18000,
        ),
        TrabajoManoObra(
          id: 't2',
          descripcion: 'Rectificado de discos',
          precio: 22000,
        ),
      ],
      repuestos: [usado('r5', 1)],
      pagos: [pago('p1', 68500, _fecha(-38, 11, 0), 'Transferencia')],
      fechaEntrega: _fecha(-38, 11, 0),
      stockDevuelto: false,
      actualizadoEn: _fecha(-38, 11, 0),
    ),
    OrdenServicio(
      id: 'o2',
      numero: 2,
      idCliente: 'c2',
      idVehiculo: 'v3',
      idMecanico: 'm2',
      fechaIngreso: _fecha(-2, 10, 0),
      problema: 'La suspensión golpea fuerte en las lomas y hace ruido.',
      estado: EstadoOrden.entregada,
      kilometrajeIngreso: 62300,
      manoObra: [
        TrabajoManoObra(
          id: 't3',
          descripcion: 'Cambio de amortiguadores delanteros',
          precio: 30000,
        ),
      ],
      repuestos: [usado('r7', 2)],
      pagos: [pago('p2', 100000, _fecha(-1, 17, 30), 'Efectivo')],
      fechaEntrega: _fecha(-1, 17, 30),
      stockDevuelto: false,
      actualizadoEn: _fecha(-1, 17, 30),
    ),
    OrdenServicio(
      id: 'o3',
      numero: 3,
      idCliente: 'c3',
      idVehiculo: 'v4',
      idMecanico: 'm1',
      fechaIngreso: _fecha(-1, 12, 0),
      problema: 'Service completo de 100.000 km. Revisar filtros y aceite.',
      estado: EstadoOrden.lista,
      kilometrajeIngreso: 98700,
      manoObra: [
        TrabajoManoObra(
          id: 't4',
          descripcion: 'Mano de obra service completo',
          precio: 15000,
        ),
      ],
      repuestos: [usado('r1', 1), usado('r2', 1), usado('r3', 1)],
      pagos: [],
      fechaEntrega: null,
      stockDevuelto: false,
      actualizadoEn: _fecha(0, 9, 30),
    ),
    OrdenServicio(
      id: 'o4',
      numero: 4,
      idCliente: 'c1',
      idVehiculo: 'v2',
      idMecanico: 'm1',
      fechaIngreso: _fecha(0, 8, 0),
      problema: 'Pérdida de líquido refrigerante y temperatura alta.',
      estado: EstadoOrden.reparacion,
      kilometrajeIngreso: 152300,
      manoObra: [
        TrabajoManoObra(
          id: 't5',
          descripcion: 'Diagnóstico y revisión del circuito',
          precio: 8000,
        ),
      ],
      repuestos: [usado('r10', 1)],
      pagos: [],
      fechaEntrega: null,
      stockDevuelto: false,
      actualizadoEn: _fecha(0, 11, 0),
    ),
    OrdenServicio(
      id: 'o5',
      numero: 5,
      idCliente: 'c4',
      idVehiculo: 'v5',
      idMecanico: 'm2',
      fechaIngreso: _fecha(0, 8, 30),
      problema: 'Se encendió el testigo de motor. Revisar con escáner.',
      estado: EstadoOrden.diagnostico,
      kilometrajeIngreso: 34100,
      manoObra: [],
      repuestos: [],
      pagos: [],
      fechaEntrega: null,
      stockDevuelto: false,
      actualizadoEn: _fecha(0, 9, 0),
    ),
    OrdenServicio(
      id: 'o6',
      numero: 6,
      idCliente: 'c5',
      idVehiculo: 'v6',
      idMecanico: 'm2',
      fechaIngreso: _fecha(0, 9, 0),
      problema: 'No arranca. El cliente cree que es la batería.',
      estado: EstadoOrden.recibida,
      kilometrajeIngreso: 71500,
      manoObra: [],
      repuestos: [],
      pagos: [],
      fechaEntrega: null,
      stockDevuelto: false,
      actualizadoEn: _fecha(0, 9, 0),
    ),
    OrdenServicio(
      id: 'o7',
      numero: 7,
      idCliente: 'c6',
      idVehiculo: 'v7',
      idMecanico: 'm1',
      fechaIngreso: _fecha(-6, 15, 0),
      problema: 'Ruido en la caja al pasar de segunda a tercera.',
      estado: EstadoOrden.cancelada,
      kilometrajeIngreso: 112000,
      manoObra: [
        TrabajoManoObra(
          id: 't6',
          descripcion: 'Presupuesto de reparación de caja',
          precio: 10000,
        ),
      ],
      repuestos: [],
      pagos: [],
      fechaEntrega: null,
      stockDevuelto: false,
      actualizadoEn: _fecha(-5, 10, 0),
    ),
    OrdenServicio(
      id: 'o8',
      numero: 8,
      idCliente: 'c3',
      idVehiculo: 'v8',
      idMecanico: 'm2',
      fechaIngreso: _fecha(-3, 14, 0),
      problema: 'Service de la moto: aceite, filtro y bujía.',
      estado: EstadoOrden.entregada,
      kilometrajeIngreso: 12800,
      manoObra: [
        TrabajoManoObra(
          id: 't7',
          descripcion: 'Service de moto',
          precio: 12000,
        ),
      ],
      repuestos: [usado('r2', 1), usado('r4', 1)],
      pagos: [pago('p3', 20300, _fecha(-2, 18, 0), 'Tarjeta')],
      fechaEntrega: _fecha(-2, 18, 0),
      stockDevuelto: false,
      actualizadoEn: _fecha(-2, 18, 0),
    ),
  ];

  return DatosDemo(
    clientes: clientes,
    vehiculos: vehiculos,
    mecanicos: mecanicos,
    repuestos: repuestos,
    ordenes: ordenes,
  );
}
