
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/login_email_password.dart';
import 'package:gas_leak_safety/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool sended = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formkey,
          child: ListView(
            
            children: [
              // LOGO
              SizedBox(
                width: 120,
                height: 120,
                child: Image.asset("assets/images/logo.png"),
              ),

              const Text(
                "Enter the email address associated with your account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 20,),
        
              TextFormField(
                validator: (email) => email != null && !EmailValidator.validate(email) ? "Enter a valid email" : null,
                controller: emailController,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  fontSize: 16
                ),
                decoration: InputDecoration(
                  labelText: "  Email  ",
                  labelStyle: const TextStyle(
                    fontSize: 16
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.email)
                ),
              ),

              const SizedBox(height: 20,),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if(!_formkey.currentState!.validate()) {
                      return;
                    }
                    if(await AuthService().resetPassword(emailController.text.trim(), context)) {
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: const Text("Reset Password"),
                        content: const Text(
                          "Check your email to reset your password and login again!",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          }, child: const Text("Ok"))
                        ],
                      ));
                    }                  
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}