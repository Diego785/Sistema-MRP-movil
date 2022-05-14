import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Menu%20Aside/nav_bar.dart';
import 'package:sistema_mrp/Controllers/Login/auth.dart';
import 'package:sistema_mrp/Views/Login.dart';

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
    /*return Scaffold(
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
    );*/
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.green.shade800,
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        child: const Center(
          child: Text('This is your Welcome Page in your MRP system'),
        ),
      ),
    );
  }
}
