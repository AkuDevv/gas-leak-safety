
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
        backgroundColor: const Color(0xff78A6C8),
        title: const Text("Reinitialiser le mot de passe",style: TextStyle(
          fontFamily: 'Sfpro'
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Form(
          key: _formkey,
          child: ListView(
            
            children: [
              // LOGO
              SizedBox(
                width: 120,
                height: 120,
                child: Image.asset("assets/images/forgot.png"),
              ),

              const SizedBox(height: 20,),
        
              TextFormField(
                validator: (email) => email != null && !EmailValidator.validate(email) ? "Entrez un mail valide!" : null,
                controller: emailController,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Sfpro'
                ),
                decoration: InputDecoration(
                  labelText: "  Email  ",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Sfpro'
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.email_rounded)
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(!_formkey.currentState!.validate()) {
                        return;
                      }
                      if(await AuthService().resetPassword(emailController.text.trim(), context)) {
                        showDialog(context: context, builder: (context) => AlertDialog(
                          title: const Text("Reinitialiser"),
                          content: const Text(
                            "Veuillez vérifier votre mail!",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontFamily: 'Sfpro',
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
                      "Envoyer",
                      style: TextStyle(
                        fontSize: 20, 
                        fontFamily: 'Sfpro',
                      ),
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