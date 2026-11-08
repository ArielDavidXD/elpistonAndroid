const _meses = [
  'enero',
  'febrero',
  'marzo',
  'abril',
  'mayo',
  'junio',
  'julio',
  'agosto',
  'septiembre',
  'octubre',
  'noviembre',
  'diciembre',
];

String _dos(int valor) => valor.toString().padLeft(2, '0');

String dinero(num valor) {
  final negativo = valor < 0;
  final texto = valor.abs().toStringAsFixed(2);
  final partes = texto.split('.');
  final entero = partes.first;
  final conSeparadores = StringBuffer();
  for (var i = 0; i < entero.length; i++) {
    if (i > 0 && (entero.length - i) % 3 == 0) conSeparadores.write('.');
    conSeparadores.write(entero[i]);
  }
  return '${negativo ? '-' : ''}\$$conSeparadores,${partes.last}';
}

String dineroCorto(num valor) {
  if (valor == valor.roundToDouble()) return dinero(valor).split(',').first;
  return dinero(valor);
}

String fechaCorta(DateTime fecha) =>
    '${_dos(fecha.day)}/${_dos(fecha.month)}/${fecha.year}';

String fechaHora(DateTime fecha) =>
    '${fechaCorta(fecha)} ${_dos(fecha.hour)}:${_dos(fecha.minute)}';

String fechaLarga(DateTime fecha) =>
    '${fecha.day} de ${_meses[fecha.month - 1]} de ${fecha.year}';

String iniciales(String texto) {
  final partes = texto
      .trim()
      .split(RegExp(r'\s+'))
      .where((parte) => parte.isNotEmpty)
      .toList();
  if (partes.isEmpty) return '?';
  if (partes.length == 1) return partes.first.substring(0, 1).toUpperCase();
  return (partes.first.substring(0, 1) + partes.last.substring(0, 1))
      .toUpperCase();
}

String normalizarMatricula(String texto) =>
    texto.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();

String normalizarCodigo(String texto) =>
    texto.replaceAll(RegExp(r'[^A-Za-z0-9-]'), '').toUpperCase();

String soloDigitos(String texto) => texto.replaceAll(RegExp(r'\D'), '');
