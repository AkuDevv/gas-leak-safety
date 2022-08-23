// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_leak_safety/screens/signIn.dart';
import 'package:gas_leak_safety/screens/verify_email.dart';
import 'package:gas_leak_safety/services/auth_service.dart';

import 'login_email_password.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = true;
  bool showConfirmPassword = true;
  bool showoldPassword = true;

 var newPassword = "";
   
@override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  User? user = FirebaseAuth.instance.currentUser;

  final _formkey = GlobalKey<FormState>();

  changePassword() async {
    try{
      await user!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar (
      backgroundColor : Colors.black,
      content: Text('Vous avez modifié votre mot de passe'),
    ));
    }
    catch(error){

    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    
    return Scaffold(
     appBar : AppBar(
      title: Text("Profil",style: TextStyle(fontFamily: 'Sfpro',fontSize: 20,
      fontWeight: FontWeight.bold),)
              ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.16,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            
            Container(
              height: MediaQuery.of(context).size.height*0.70,
              child: Form(
                key: _formkey,
                child: PageView(
                  
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           // ignore: prefer_const_constructors
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 2),
                            child: Text('Taper votre ancien mot de passe :',
                            style: TextStyle(color: Theme.of(context).primaryColor,
                            fontFamily: 'Sfpro',fontSize: 16),
                            ),),
                          // OLD PASSWORD
                            Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  validator: (password) =>
                      password!.isEmpty ? "Entrez votre mot de passe!" : null,
                  textInputAction: TextInputAction.done,
                  controller: oldPasswordController,
                  obscureText: showPassword,
                  style: const TextStyle(fontSize: 16,fontFamily: 'Sfpro'),
                  decoration: InputDecoration(
                      labelText: "  Ancien mot de passe  ",
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
                           Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 2),
                            child: Text('Taper votre nouveau mot de passe :',
                            style: TextStyle(color: Theme.of(context).primaryColor,
                            fontFamily: 'Sfpro',fontSize: 16),
                            ),),
                            // PASSWORD TEXT FIELD
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                validator: (password) {
                                  if (password!.isEmpty) {
                                    return "Entrez un mot de passe!";
                                  } else if (password.length < 6) {
                                    return "6 caractères minimum!";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText: showPassword,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Mot de passe ",
                                    prefixIcon: const Icon(Icons.lock),
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        icon: showPassword
                                            ? const Icon(Icons.visibility)
                                            : const Icon(
                                                Icons.visibility_off))),
                              ),
                            ),
                           Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 2),
                            child: Text('Confirmer votre nouveau mot de passe :',
                            style: TextStyle(color: Theme.of(context).primaryColor,
                            fontFamily: 'Sfpro',fontSize: 16),
                            ),),
                            // CONFIRM PASSWORD TEXT FIELD
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (value) => passwordController.text !=
                                        confirmPasswordController.text
                                    ? "Mot de passe non correcte!"
                                    : null,
                                controller: confirmPasswordController,
                                textInputAction: TextInputAction.done,
                                obscureText: showConfirmPassword,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Confirmer le mot de passe ",
                                    prefixIcon: const Icon(Icons.lock),
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showConfirmPassword =
                                                !showConfirmPassword;
                                          });
                                        },
                                        icon: showConfirmPassword
                                            ? const Icon(Icons.visibility)
                                            : const Icon(
                                                Icons.visibility_off))),
                              ),
                            ),

                           Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                                  padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height*0.06,
                                    child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        onPressed: () async {
                                          if (!_formkey.currentState!
                                                  .validate() ){
                                                    setState(() {
                                                      newPassword = passwordController.text;
                                                    });
                                                    changePassword();
                                                  }
                                     
                                         /* setState(() {
                                            loading = true;
                                          });*/
                                         /* User? user = await AuthService()
                                              .register(
                                                  emailController.text,
                                                  passwordController.text,
                                                  context);*/
                                         
                                            
                                          
                                        },
                                        child: const Text(
                                          "Changer le mot de passe",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Sfpro',
                                          ),
                                        )),
                                  ),
                                ),

                        ],
                      ),
                    ),
                   
                          // LOGIN BUTTON
                          Center(
                            child: TextButton(
                              onPressed: () { },
                              child: const Text("Voulez vous changer le mot de passe?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Sfpro')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ),
                  
          ],
          ),
          ),
       
    );
  }
}