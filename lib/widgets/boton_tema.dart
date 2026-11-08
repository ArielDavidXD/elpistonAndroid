import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BotonTema extends StatelessWidget {
  const BotonTema({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TemaScope.of(context);
    return PopupMenuButton<ThemeMode>(
      tooltip: 'Cambiar tema',
      icon: Icon(switch (controller.tema) {
        ThemeMode.dark => Icons.dark_mode_outlined,
        ThemeMode.light => Icons.light_mode_outlined,
        ThemeMode.system => Icons.brightness_auto_outlined,
      }),
      initialValue: controller.tema,
      onSelected: controller.cambiarTema,
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: ThemeMode.system,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.brightness_auto_outlined),
            title: Text('Sistema'),
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.light,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.light_mode_outlined),
            title: Text('Claro'),
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.dark,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.dark_mode_outlined),
            title: Text('Oscuro'),
          ),
        ),
      ],
    );
  }
}
