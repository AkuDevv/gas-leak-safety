// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_leak_safety/screens/login_email_password.dart';
import 'package:gas_leak_safety/screens/profil_view.dart';
import 'package:gas_leak_safety/ui/HomePage.dart';

// ignore: camel_case_types
class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _changePasswordState createState() => _changePasswordState();
}

// ignore: camel_case_types
class _changePasswordState extends State<changePassword> {
  
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = true;
  bool showConfirmPassword = true;
  bool showoldPassword = true;
  bool  save = true;

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


  /*changePassword() async {
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
*/
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     
              
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
             Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: const [Color(0xff00366f), Color(0xffd41d35)],
                        stops: const [0.2, 0.9])),
                child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      "Profil",
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileView()))
      ,),),
              ),
            SizedBox(height: 18,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.10,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            SizedBox(height: 30),
            Form(
              child: Column(
                key: _formkey,
                children: [
                  //old password
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 15.0),
                    child: TextFormField(
                      controller: oldPasswordController,
                      obscureText: showPassword,
                                  style: const TextStyle(
                                      fontSize: 15, fontFamily: 'Sfpro'),
                                  decoration: InputDecoration(
                                      labelText: " Ancien mot de passe ",
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
                  //new password
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 15.0),
                    child: TextFormField(
                      controller: newPasswordController,                 
                      obscureText: showPassword,
                                  style: const TextStyle(
                                      fontSize: 15, fontFamily: 'Sfpro'),
                                  decoration: InputDecoration(
                                      labelText: " Nouveau mot de passe ",
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
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 15.0),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      obscureText: showPassword,
                                  style: const TextStyle(
                                      fontSize: 15, fontFamily: 'Sfpro'),
                                  decoration: InputDecoration(
                                      labelText: " Confirmer votre mot de passe ",
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
                ],
              ),
            ),
                      // SAVE BUTTON
                      SizedBox(height: 10,),
                      
              Container(
                width: 50,
                height: MediaQuery.of(context).size.height*0.06,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  onPressed: () async {

                    final docRef = FirebaseFirestore.instance.collection('users').doc(user!.uid);
                    final snapshot = await docRef.get();
                    if(newPasswordController.text.length < 6){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Minimum 6 caracters')));}
                    if(newPasswordController.text!= confirmPasswordController.text){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verifiez votre mdp')));}
                    if(oldPasswordController.text.trim() != snapshot.data()!['password']) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Current password incorrect")));
                      setState(() {
                        save = false;
                      });
                      return;
                  }
                    await docRef.update({"password": newPasswordController.text});
                    await user!.updatePassword(newPasswordController.text.trim());
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  
                        },
                        child: const Text(
                                          "Enregistrer",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Sfpro',
                                          ),
                                        )),
              )],
                      ),
                    ),
                  );
  }
}