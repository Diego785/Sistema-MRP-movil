import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Views/login.dart';

import 'package:sistema_mrp/Controllers/Login/auth.dart';
import 'package:sistema_mrp/Views/welcome.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MyApp(),
    ),
  );
}
