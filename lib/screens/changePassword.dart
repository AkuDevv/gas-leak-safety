// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_leak_safety/screens/signIn.dart';
import 'package:gas_leak_safety/screens/verify_email.dart';
import 'package:gas_leak_safety/services/auth_service.dart';
import 'package:gas_leak_safety/services/services_locator.dart';

import 'login_email_password.dart';

class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = true;
  bool showConfirmPassword = true;
  bool showoldPassword = true;

  bool checkCurrentPasswordValid = true;

 var newPassword = "";
String? oldPassword = "";
 final _formkey = GlobalKey<FormState>();

 User? user = FirebaseAuth.instance.currentUser;

   Future _getUserFromFirebase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          oldPassword = snapshot.data()!['password'];
        });
      }
    });
  }

   @override
  void initState() {
    super.initState();
    _getUserFromFirebase();
  }

  
   @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  

  

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
                width: MediaQuery.of(context).size.width*0.6,
                height: MediaQuery.of(context).size.height*0.10,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            SizedBox(height:40),
            Form(
              child: Column(
                key: _formkey,
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: 'old password'),
                    obscureText: true,
                    controller: oldPasswordController,
                       validator: (value) 
                    {
                      oldPassword == oldPasswordController.text ? "ssss" : "error";
                     
                    } ,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'New Password'),
                    controller: passwordController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'confirm new Password'),
                    obscureText: true,
                    controller: confirmPasswordController,
                    validator:(value){
                      return passwordController.text == value ? null :
                      "please validate ur entered password";
                    } ,
                  ),
                ],
              ),
            ),
                      // SAVE BUTTON
                      SizedBox(height: 10,),
                      RaisedButton(
                        onPressed: () async {
                                          if (!_formkey.currentState!
                                                  .validate() ){
                                                    setState(() {
                                                      newPassword = passwordController.text;
                                                    });
                                                    changePassword();
                                                  }
                      })
                          
            
                        ],
                      ),
                    ),
                  
                
             
       
    );
  }
}