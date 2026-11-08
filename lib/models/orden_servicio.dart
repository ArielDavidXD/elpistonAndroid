/// Estados posibles de una orden de servicio.
enum EstadoOrden {
  recibida,
  diagnostico,
  reparacion,
  lista,
  entregada,
  cancelada,
}

extension EstadoOrdenUi on EstadoOrden {
  String get etiqueta {
    switch (this) {
      case EstadoOrden.recibida:
        return 'Recibida';
      case EstadoOrden.diagnostico:
        return 'En diagnóstico';
      case EstadoOrden.reparacion:
        return 'En reparación';
      case EstadoOrden.lista:
        return 'Lista para entregar';
      case EstadoOrden.entregada:
        return 'Entregada';
      case EstadoOrden.cancelada:
        return 'Cancelada';
    }
  }

  bool get abierta =>
      this != EstadoOrden.entregada && this != EstadoOrden.cancelada;

  bool get entregada => this == EstadoOrden.entregada;

  bool get cancelada => this == EstadoOrden.cancelada;

  EstadoOrden? get siguiente {
    switch (this) {
      case EstadoOrden.recibida:
        return EstadoOrden.diagnostico;
      case EstadoOrden.diagnostico:
        return EstadoOrden.reparacion;
      case EstadoOrden.reparacion:
        return EstadoOrden.lista;
      case EstadoOrden.lista:
        return EstadoOrden.entregada;
      case EstadoOrden.entregada:
      case EstadoOrden.cancelada:
        return null;
    }
  }
}

class TrabajoManoObra {
  TrabajoManoObra({
    required this.id,
    required this.descripcion,
    required this.precio,
  });

  final String id;
  final String descripcion;
  final double precio;
}

class RepuestoUsado {
  RepuestoUsado({
    required this.idRepuesto,
    required this.codigo,
    required this.nombre,
    required this.cantidad,
    required this.precioUnitario,
  });

  final String idRepuesto;
  final String codigo;
  final String nombre;
  final int cantidad;
  final double precioUnitario;

  double get subtotal => cantidad * precioUnitario;
}

class Pago {
  Pago({
    required this.id,
    required this.monto,
    required this.fecha,
    required this.metodo,
  });

  final String id;
  final double monto;
  final DateTime fecha;
  final String metodo;
}

class OrdenServicio {
  OrdenServicio({
    required this.id,
    required this.numero,
    required this.idCliente,
    required this.idVehiculo,
    required this.idMecanico,
    required this.fechaIngreso,
    required this.problema,
    required this.estado,
    required this.kilometrajeIngreso,
    required this.manoObra,
    required this.repuestos,
    required this.pagos,
    required this.fechaEntrega,
    required this.stockDevuelto,
    required this.actualizadoEn,
  });

  final String id;
  final int numero;
  final String idCliente;
  final String idVehiculo;
  String idMecanico;
  final DateTime fechaIngreso;
  String problema;
  EstadoOrden estado;
  final int? kilometrajeIngreso;
  final List<TrabajoManoObra> manoObra;
  final List<RepuestoUsado> repuestos;
  final List<Pago> pagos;
  DateTime? fechaEntrega;
  bool stockDevuelto;
  DateTime actualizadoEn;

  double get totalManoObra =>
      manoObra.fold(0.0, (total, trabajo) => total + trabajo.precio);

  double get totalRepuestos =>
      repuestos.fold(0.0, (total, usado) => total + usado.subtotal);

  double get total => totalManoObra + totalRepuestos;

  double get pagado => pagos.fold(0.0, (total, pago) => total + pago.monto);

  double get saldo {
    final diferencia = total - pagado;
    return diferencia < 0 ? 0 : diferencia;
  }

  bool get pagada => saldo < 0.01;

  bool get entregada => estado == EstadoOrden.entregada;

  bool get cancelada => estado == EstadoOrden.cancelada;

  bool get abierta => estado.abierta;

  bool get editable => abierta;
}
