import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/signIn.dart';
import 'package:gas_leak_safety/screens/started.dart';
import 'package:gas_leak_safety/screens/verify_email.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GettingStarted(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasData) {
            return const VerifyEmailScreen();
          } else if(snapshot.hasError) {
            return const Center(child: Text("Something went wrong"),);
          } else {
            return const SignInMethodScreen();
          }
        },
      ),
    );
  }
}