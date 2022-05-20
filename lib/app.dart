import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Controllers/Login/auth.dart';
import 'Views/views.dart';

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SISTEMA MRP',
      initialRoute: '/',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green[800],
          primaryColorLight: Colors.green[800],
          cardColor: Colors.grey[100],
          focusColor: Colors.grey[100],
          indicatorColor: Colors.green[800],
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.white))),
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
            case '/materia-prima':
              return ShowMateriaPrima();
            case '/producto':
              return ProductoScreen();
          }
          return Text("Null");
        });
      },
    );
  }
}
