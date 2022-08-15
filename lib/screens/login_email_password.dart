import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/Register_.dart';
import 'package:gas_leak_safety/screens/forgot_password.dart';
import 'package:gas_leak_safety/screens/verify_email.dart';
import 'package:gas_leak_safety/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool login = false;

  bool showPassword = true;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              // LOGO
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.height/2,
                  height: 150,
                  child: Image.asset("assets/images/login.png"),
                ),
              ),

              // EMAIL TEXT FIELD
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  validator: (email) => !EmailValidator.validate(email!)
                      ? "Entrez un email valide!"
                      : null,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 16,fontFamily: 'Sfpro'),
                  decoration: InputDecoration(
                      labelText: "  Email  ",
                      labelStyle: const TextStyle(fontSize: 14,fontFamily: 'Sfpro'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(Icons.email)),
                ),
              ),

              // PASSWORD TEXT FIELD
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  validator: (password) =>
                      password!.isEmpty ? "Entez votre mot de passe!" : null,
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  obscureText: showPassword,
                  style: const TextStyle(fontSize: 16,fontFamily: 'Sfpro'),
                  decoration: InputDecoration(
                      labelText: "  Mot de passe  ",
                      labelStyle: const TextStyle(fontSize: 14,fontFamily: 'Sfpro'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: showPassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off))),
                ),
              ),

              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen()));
                  },
                  child: const Text("Mot de passe oublié?",style: TextStyle(fontFamily: 'Sfpro'),)),

              // FORGOT PASSWORD BUTTON

              // LOGIN BUTTON
              login
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!_formkey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              login = true;
                            });
                            User? res = await AuthService().login(
                                emailController.text,
                                passwordController.text,
                                context);
                            if (res != null) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VerifyEmailScreen()),
                                  (route) => false);
                            }
                            setState(() {
                              login = false;
                            });
                          },
                          child: const Text(
                            "Se Connecter",
                            style: TextStyle(
                                fontSize: 20,fontFamily: 'Sfpro'),
                          ),
                        ),
                      ),
                    ),

              // REGISTER BUTTON
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FirstLanding()));
                  },
                  child: const Text(
                    "Vous n'avez pas du compte? S'inscrire ici!",
                    style: TextStyle(fontSize: 15,fontFamily: 'Sfpro'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
