class Resultado<T> {
  const Resultado.ok(this.valor) : error = null;
  const Resultado.fallo(this.error) : valor = null;

  final T? valor;
  final String? error;

  bool get ok => error == null;
}
