import 'package:firebase_auth/firebase_auth.dart';
import 'Authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authentication.dart';
import 'package:webfix_task/Dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WebFix',
        home: Authenticate(),
        routes: {
          "/dashboard": (context) =>Dashboard()
        },
        theme: ThemeData(
          primaryColor: Color(0xff1d6484)
        ),
      ),
    );
  }
}