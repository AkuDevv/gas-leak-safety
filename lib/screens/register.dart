import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/signIn.dart';
import 'package:gas_leak_safety/screens/verify_email.dart';
import 'package:gas_leak_safety/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool loading = false;
  final _formkey = GlobalKey<FormState>();

  bool showPassword = true;
  bool showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return Scaffold(
      
      body: Padding(

        padding: const EdgeInsets.all(20),
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

              const SizedBox(height: 10,),

              // FIRST NAME TEXT FIELD
              TextFormField(
                controller: fnameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    labelText: " First Name ",
                    labelStyle: const TextStyle(
                      fontSize: 16
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10)
                ),
              ),

              const SizedBox(height: 10,),

              // LAST NAME TEXT FIELD
              TextFormField(
                controller: lnameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    labelText: " Last Name ",
                    labelStyle: const TextStyle(
                      fontSize: 16
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10)
                ),
              ),

              TextFormField(
                controller: cinController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    labelText: " CIN ",
                    labelStyle: const TextStyle(
                      fontSize: 16
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10)
                ),
              ),

              TextFormField(
                controller: telController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    labelText: " Numéro Téléphone ",
                    labelStyle: const TextStyle(
                      fontSize: 16
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10)
                ),
              ),
              TextFormField(
                controller: adresseController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    labelText: " Adresse Postale ",
                    labelStyle: const TextStyle(
                      fontSize: 16
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10)
                ),
              ),

              const SizedBox(height: 10,),

              // EMAIL TEXT FIELD
              TextFormField(
                validator: (email) => !EmailValidator.validate(email!) ? "Enter a valid email" : null,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    labelText: " Email ",
                    prefixIcon: const Icon(Icons.email),
                    labelStyle: const TextStyle(
                      fontSize: 16
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10)
                ),
                autofillHints: const [AutofillHints.email],
              ),

              const SizedBox(height: 10,),

              // PASSWORD TEXT FIELD
              TextFormField(
                validator: (password) {
                  if(password!.isEmpty) {
                    return "Enter a password!";
                  } else if(password.length < 6) {
                    return "At least 6 characters"; 
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
                textInputAction: TextInputAction.next,
                obscureText: showPassword,
                style: const TextStyle(
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    labelText: " Password ",
                    prefixIcon: const Icon(Icons.lock),
                    labelStyle: const TextStyle(
                      fontSize: 16
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }, icon: showPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off))
                ),
              ),

              const SizedBox(height: 10,),
              
              // CONFIRM PASSWORD TEXT FIELD
              TextFormField(
                validator: (value) => passwordController.text != confirmPasswordController.text ? "passwords doesn't match" : null,
                controller: confirmPasswordController,
                textInputAction: TextInputAction.done,
                obscureText: showConfirmPassword,
                style: const TextStyle(
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    labelText: " Confirm Password ",
                    prefixIcon: const Icon(Icons.lock),
                    labelStyle: const TextStyle(
                      fontSize: 16
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        showConfirmPassword = !showConfirmPassword;
                      });
                    }, icon: showConfirmPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off))
                ),
              ),

              const SizedBox(height: 10,),

              // REGISTER BUTTON
              loading ? const Center(
                child: CircularProgressIndicator(),
              ) : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if(!_formkey.currentState!.validate() == true) {
                      return;
                    }
                    setState(() {
                      loading = true;
                    });
                    User? user = await AuthService().register(emailController.text, passwordController.text, context);
                    if(user != null) {
                      CollectionReference users = firebaseFirestore.collection('users');
                      await users.doc(user.uid).set({
                        'name': "${fnameController.text} ${lnameController.text}",
                        'email': emailController.text,
                        'photo': "",
                        'uid': user.uid,
                        'provider': "EMAIL"
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VerifyEmailScreen()));
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                  child: const Text("Register", style: TextStyle(
                    fontSize: 25, 
                    fontWeight: FontWeight.bold
                  ),)
                ),
              ),

              const SizedBox(height: 20,),

              // LOGIN BUTTON
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInMethodScreen()));
                },
                child: const Text(
                  "Already have an account? Login here",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
