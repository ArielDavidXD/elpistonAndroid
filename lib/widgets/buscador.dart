import 'package:flutter/material.dart';

class Buscador extends StatefulWidget {
  const Buscador({
    required this.hint,
    required this.onChanged,
    this.textoInicial = '',
    super.key,
  });

  final String hint;
  final ValueChanged<String> onChanged;
  final String textoInicial;

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.textoInicial,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (texto) {
        widget.onChanged(texto);
        setState(() {});
      },
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search_rounded, size: 21),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: 'Limpiar búsqueda',
                onPressed: () {
                  _controller.clear();
                  widget.onChanged('');
                  setState(() {});
                },
                icon: const Icon(Icons.close_rounded, size: 19),
              ),
        isDense: true,
      ),
    );
  }
}
