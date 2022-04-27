import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Menu%20Aside/nav_bar.dart';
import 'package:sistema_mrp/Controllers/Login/auth.dart';
import 'package:sistema_mrp/Views/Login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          accentColor: Colors.green[800],
          cardColor: Colors.grey[100],
          focusColor: Colors.grey[100],
          cursorColor: Colors.green[800],
          indicatorColor: Colors.green[800],
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.white))),
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
          }
          return Text("Null");
        });
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    try {
      String? token = await storage.read(key: 'token');
      Provider.of<Auth>(context, listen: false).tryToken(token!);
      print(token);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("MRP SYSTEM"),
        backgroundColor: Colors.green.shade800,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        child: const Center(
          child: Text('This is your Welcome Page in your MRP system'),
        ),
      ),
    );
  }
}
