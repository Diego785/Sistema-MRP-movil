import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_mrp/Controllers/Login/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //device info
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _deviceName = "unknown";

  @override
  void initState() {
    // TODO: implement initState
    _emailController.text = 'diego@gmail.com';
    _passwordController.text = '123456789';
    getDeviceName();
    super.initState();
  }

  void getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceName = androidInfo.model.toString();
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceName = iosInfo.utsname.machine.toString();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Colors.green.shade800],
                ),
              ),
              child: Image.asset(
                "assets/images/logo.png",
                height: 200,
              ),
            ),
            Transform.translate(
              offset: Offset(0, -90),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 335, bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email:",
                            ),
                            controller: _emailController,
                            validator: (value) => value!.isEmpty
                                ? "Please enter a valid email"
                                : null,
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password:",
                            ),
                            controller: _passwordController,
                            validator: (value) => value!.isEmpty
                                ? "Please enter a password"
                                : null,
                            obscureText: true,
                          ),
                          SizedBox(height: 40),
                          FlatButton(
                            minWidth: double.infinity,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.green.shade600,
                            onPressed: () {
                              Map credentials = {
                                'email': _emailController.text,
                                'password': _passwordController.text,
                                'device_name': _deviceName,
                              };

                              if (_formKey.currentState!.validate()) {
                                Provider.of<Auth>(context, listen: false)
                                    .login(credentials);
                                Navigator.pushNamed(context, "/main-screen");
                              }
                            },
                          ),
                          /*Theme(
                            data: Theme.of(context)
                                .copyWith(accentColor: Colors.white),
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              onPressed: () => _login(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Iniciar Sesión"),
                                  if (_loading)
                                    Container(
                                      height: 20,
                                      width: 20,
                                      margin: EdgeInsets.only(left: 20),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),*/
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("¿No está registrado?"),
                              FlatButton(
                                textColor: Theme.of(context).primaryColor,
                                child: Text("Registrarse"),
                                onPressed: () => Navigator.pushNamed(context, "/main-screen"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed("/register");
  }
}
