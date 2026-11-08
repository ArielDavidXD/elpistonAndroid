import 'package:flutter/material.dart';

class AppThemeController extends ChangeNotifier {
  ThemeMode _tema = ThemeMode.system;

  ThemeMode get tema => _tema;

  void cambiarTema(ThemeMode nuevo) {
    if (_tema == nuevo) return;
    _tema = nuevo;
    notifyListeners();
  }

  void alternarTema() {
    cambiarTema(_tema == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}

class TemaScope extends InheritedNotifier<AppThemeController> {
  const TemaScope({
    required AppThemeController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static AppThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<TemaScope>();
    assert(scope != null, 'TemaScope no encontrado en el árbol.');
    return scope!.notifier!;
  }
}

class AppTheme {
  static const Color primarioClaro = Color(0xFF006A60);
  static const Color primarioContenedorClaro = Color(0xFF9FF2E4);
  static const Color secundarioContenedorClaro = Color(0xFFCCE8E2);
  static const Color terciarioClaro = Color(0xFF8B4D00);
  static const Color errorClaro = Color(0xFFBA1A1A);
  static const Color errorContenedorClaro = Color(0xFFFFDAD6);
  static const Color superficieClaro = Color(0xFFF4FBF9);
  static const Color superficieContenedorClaro = Color(0xFFE5EFED);
  static const Color contornoClaro = Color(0xFF6F7977);

  static const Color primarioOscuro = Color(0xFF53DBC9);
  static const Color primarioContenedorOscuro = Color(0xFF005047);
  static const Color secundarioContenedorOscuro = Color(0xFF314B47);
  static const Color terciarioOscuro = Color(0xFFFFB870);
  static const Color errorOscuro = Color(0xFFFFB4AB);
  static const Color errorContenedorOscuro = Color(0xFF93000A);
  static const Color superficieOscura = Color(0xFF0E1514);
  static const Color superficieContenedorOscura = Color(0xFF1A2120);
  static const Color contornoOscuro = Color(0xFF899390);

  static final ThemeData claro = _crear(Brightness.light);
  static final ThemeData oscuro = _crear(Brightness.dark);

  static ThemeData _crear(Brightness brillo) {
    final oscuro = brillo == Brightness.dark;
    final esquema = ColorScheme(
      brightness: brillo,
      primary: oscuro ? primarioOscuro : primarioClaro,
      onPrimary: oscuro ? const Color(0xFF003731) : Colors.white,
      primaryContainer: oscuro
          ? primarioContenedorOscuro
          : primarioContenedorClaro,
      onPrimaryContainer: oscuro
          ? const Color(0xFF9FF2E4)
          : const Color(0xFF00201C),
      secondary: oscuro ? const Color(0xFFB1CCC6) : const Color(0xFF4A635E),
      onSecondary: oscuro ? const Color(0xFF1C3531) : Colors.white,
      secondaryContainer: oscuro
          ? secundarioContenedorOscuro
          : secundarioContenedorClaro,
      onSecondaryContainer: oscuro
          ? const Color(0xFFD0E8E2)
          : const Color(0xFF051F1B),
      tertiary: oscuro ? terciarioOscuro : terciarioClaro,
      onTertiary: oscuro ? const Color(0xFF4A2800) : Colors.white,
      tertiaryContainer: oscuro
          ? const Color(0xFF633D00)
          : const Color(0xFFFFDDBB),
      onTertiaryContainer: oscuro
          ? const Color(0xFFFFDDBB)
          : const Color(0xFF2D1600),
      error: oscuro ? errorOscuro : errorClaro,
      onError: oscuro ? const Color(0xFF690005) : Colors.white,
      errorContainer: oscuro ? errorContenedorOscuro : errorContenedorClaro,
      onErrorContainer: oscuro
          ? const Color(0xFFFFDAD6)
          : const Color(0xFF410002),
      surface: oscuro ? superficieOscura : superficieClaro,
      onSurface: oscuro ? const Color(0xFFE0E3E1) : const Color(0xFF191C1B),
      surfaceContainer: oscuro
          ? superficieContenedorOscura
          : superficieContenedorClaro,
      outline: oscuro ? contornoOscuro : contornoClaro,
      outlineVariant: oscuro
          ? const Color(0xFF3F4947)
          : const Color(0xFFBEC9C6),
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brillo,
      fontFamily: 'Poppins',
      colorScheme: esquema,
      scaffoldBackgroundColor: esquema.surface,
      visualDensity: VisualDensity.standard,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: esquema.surface,
        foregroundColor: esquema.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: esquema.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: esquema.surfaceContainerLow,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: esquema.outlineVariant.withAlpha(140)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: esquema.outlineVariant.withAlpha(130),
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: esquema.surfaceContainer.withAlpha(135),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: esquema.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: esquema.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: esquema.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: esquema.error, width: 1.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 46),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(color: esquema.outlineVariant),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        side: BorderSide(color: esquema.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: esquema.surfaceContainerLow,
        indicatorColor: esquema.primaryContainer,
        elevation: 2,
        height: 70,
        labelTextStyle: WidgetStateProperty.resolveWith((estados) {
          final seleccionado = estados.contains(WidgetState.selected);
          return TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: seleccionado ? FontWeight.w600 : FontWeight.w500,
            color: seleccionado
                ? esquema.onPrimaryContainer
                : esquema.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((estados) {
          final seleccionado = estados.contains(WidgetState.selected);
          return IconThemeData(
            color: seleccionado
                ? esquema.onPrimaryContainer
                : esquema.onSurfaceVariant,
            size: 23,
          );
        }),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: esquema.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: esquema.surfaceContainerLow,
        modalBackgroundColor: esquema.surfaceContainerLow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        showDragHandle: true,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: oscuro
            ? esquema.surfaceContainerHighest
            : const Color(0xFF233331),
        contentTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 13,
        ),
      ),
      textTheme: base.textTheme.apply(
        fontFamily: 'Poppins',
        bodyColor: esquema.onSurface,
        displayColor: esquema.onSurface,
      ),
    );
  }
}
