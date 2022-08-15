import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/Register_.dart';
import 'package:gas_leak_safety/screens/login_email_password.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class SignInMethodScreen extends StatefulWidget {
  const SignInMethodScreen({Key? key}) : super(key: key);

  @override
  State<SignInMethodScreen> createState() => _SignInMethodScreenState();
}

class _SignInMethodScreenState extends State<SignInMethodScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool email = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 90, 20, 10),
          child: ListView(
            children: [

              // LOGO
              SizedBox(
                width: 120,
                height: 120,
                child: Image.asset("assets/images/logo_gas.png"),
              ),

              Center(
                child:  Text(
                  "Se Connecter",
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Sfpro',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              
              email ? const Center(child: CircularProgressIndicator(),) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignInButton(Buttons.Email, onPressed: () {
                  setState(() {
                    email = true;
                  });

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const LoginScreen()));
                }),
              ),
          
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstLanding()));
                  },
                  child: const Text(
                    "Don't have an account? Register here !", 
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.bold
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}