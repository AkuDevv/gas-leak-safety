import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/forgot_password.dart';
import 'package:gas_leak_safety/screens/register.dart';
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
  bool google = false;
  bool facebook = false;
  bool apple = false;

  bool showPassword = true;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 90, 20, 10),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              // LOGO
              SizedBox(
                width: 120,
                height: 120,
                child: Image.asset("assets/images/logo_gas.png"),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Text(
                    "Se Connecter",
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Sfpro',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // EMAIL TEXT FIELD
              TextFormField(
                validator: (email) => !EmailValidator.validate(email!)
                    ? "Enter a valid email"
                    : null,
                controller: emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(fontSize: 16,fontFamily: 'Sfpro'),
                decoration: InputDecoration(
                    labelText: "  Email  ",
                    labelStyle: const TextStyle(fontSize: 16,fontFamily: 'Sfpro'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: const Icon(Icons.email)),
              ),

              const SizedBox(
                height: 10,
              ),

              // PASSWORD TEXT FIELD
              TextFormField(
                validator: (password) =>
                    password!.isEmpty ? "Enter your password!" : null,
                textInputAction: TextInputAction.done,
                controller: passwordController,
                obscureText: showPassword,
                style: const TextStyle(fontSize: 16,fontFamily: 'Sfpro'),
                decoration: InputDecoration(
                    labelText: "  Password  ",
                    labelStyle: const TextStyle(fontSize: 16,fontFamily: 'Sfpro'),
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

              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen()));
                  },
                  child: const Text("Forgot password?",style: TextStyle(fontFamily: 'Sfpro'),)),

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
                            "Login",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Sfpro'),
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
                            builder: (context) => const RegisterScreen()));
                  },
                  child: const Text(
                    "Don't have an account? Register here !",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'Sfpro'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
