import 'package:flutter/material.dart';
import 'models/product.dart';
import 'screens/main_shell.dart';
import 'state/shop_state.dart';

void main() {
  runApp(const SnapCartApp());
}

class SnapCartApp extends StatefulWidget {
  const SnapCartApp({super.key});

  @override
  State<SnapCartApp> createState() => _SnapCartAppState();
}

class _SnapCartAppState extends State<SnapCartApp> {
  final ShopState shopState = ShopState();

  @override
  Widget build(BuildContext context) {
    return ShopScope(
      state: shopState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShopEase',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6C3CE9),
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF8F7FC),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF8F7FC),
            surfaceTintColor: Colors.transparent,
            centerTitle: false,
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFFECE8F5)),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE5E0EF)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE5E0EF)),
            ),
          ),
        ),
        home: const MainShell(),
      ),
    );
  }
}
