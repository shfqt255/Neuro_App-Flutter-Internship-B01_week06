import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/Pages/ui.dart';
import 'package:users_app/Provider/api_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UsersPage(),
      ),
    );
  }
}