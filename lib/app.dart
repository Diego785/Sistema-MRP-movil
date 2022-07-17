import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Complements/Dashboard/constants.dart';
import 'package:sistema_mrp/Controllers/Dashboard/MenuController.dart';
import 'package:sistema_mrp/Controllers/Login/auth.dart';
import 'package:sistema_mrp/Views/Inventario/NotaCompra/detalle_compra_screen.dart';
import 'package:sistema_mrp/Views/Inventario/show_pedido.dart';
import 'package:sistema_mrp/Views/main/main_screen.dart';
import 'package:sistema_mrp/Views/views.dart';

class MyApp extends StatelessWidget {
  static const String title = 'SISTEMA MRP';
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      initialRoute: '/',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return Drawer(
                  child: Consumer<Auth>(builder: (context, auth, child) {
                if (!auth.authenticated) {
                  return LoginPage();
                } else {
                  return WelcomePage();
                }
              }));

            case '/login':
              return LoginPage();
            case '/home':
              return WelcomePage();
            case '/main-screen':
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => MenuController(),
                  ),
                ],
                child: MainScreen(),
              );
            case '/materia-prima':
              return ShowMateriaPrima();
            case '/producto':
              return ProductoScreen();
            case '/pedido':
              return ShowPedido();
            case '/nota-compra':
              return const NotaCompraScreen();
            case '/detalle-compra':
              return const DetalleCompraScreen();
            case '/reportes':
              return const PdfPageScreen();
            case '/show-pdf':
              return const ShowPdfScreen();
          }
          return const Text("xd");
        });
      },
    );
  }
}
