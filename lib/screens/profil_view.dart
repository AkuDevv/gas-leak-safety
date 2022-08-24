// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_leak_safety/screens/changePassword.dart';
import 'package:gas_leak_safety/ui/HomePage.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? fname = "";
  String? cin = "";
  String? tel = "";
  String? adresse = "";
  String? email = "";
   
  User? user = FirebaseAuth.instance.currentUser;

  final _formkey = GlobalKey<FormState>();

  bool showPassword = true;
  
  Future _getUserFromFirebase() async {
    await FirebaseFirestore.instance.collection('users')
    .doc(user!.uid)
    .get().then((snapshot) async {
      if(snapshot.exists){
        setState(() {
          fname = snapshot.data()!['name']; 
          cin = snapshot.data()!['cin']; 
          tel = snapshot.data()!['tel'];
          adresse  = snapshot.data()!['adresse'];
          email = snapshot.data()!['email'];
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
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    
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
            onPressed:() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()))
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
            SizedBox(height: 20,),
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
                            child: Text('Nom et prénom :',
                            style: TextStyle(color: Theme.of(context).primaryColor,
                            fontFamily: 'Sfpro',fontSize: 16),
                            ),),
                          // FIRST NAME TEXT FIELD
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                            child: TextFormField(
                              controller: fnameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Sfpro'),
                              decoration: InputDecoration(
                              
                                  hintText: fname,
                                  labelStyle: const TextStyle(
                                      fontSize: 14, fontFamily: 'Sfpro'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  contentPadding: const EdgeInsets.all(10)),
                                  
                            ),
                          ),
                         
                          Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 2,top: 10),
                            child: Text('CIN :',
                            style: TextStyle(color: Theme.of(context).primaryColor,
                            fontFamily: 'Sfpro',fontSize: 16),
                            ),),
                            //CIN FIELD

                          Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                            child: TextFormField(
                              controller: cinController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Sfpro'),
                              decoration: InputDecoration(
                                  hintText: cin,
                                  labelStyle: const TextStyle(
                                      fontSize: 14, fontFamily: 'Sfpro'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  contentPadding: const EdgeInsets.all(10)),
                            ),
                          ),
                        
                        
                        Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 2,top: 10),
                            child: Text('Téléphone :',
                            style: TextStyle(color: Theme.of(context).primaryColor,
                            fontFamily: 'Sfpro',fontSize: 16),
                            ),), 

                        Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                            child: TextFormField(
                              controller: telController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Sfpro'),
                              decoration: InputDecoration(
                                  hintText: tel,
                                  labelStyle: const TextStyle(
                                      fontSize: 14, fontFamily: 'Sfpro'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  contentPadding: const EdgeInsets.all(10)),
                            ),
                          ), 
 
                        Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 2,top: 10),
                            child: Text('Adresse :',
                            style: TextStyle(color: Theme.of(context).primaryColor,
                            fontFamily: 'Sfpro',fontSize: 16),
                            ),), 
                        
                        Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                            child: TextFormField(
                              controller: adresseController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Sfpro'),
                              decoration: InputDecoration(
                                  hintText: adresse,
                                  labelStyle: const TextStyle(
                                      fontSize: 14, fontFamily: 'Sfpro'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  contentPadding: const EdgeInsets.all(10)),
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
                                                  .validate() ==
                                              true) {
                                            return;
                                          }
                                         
                                          if (user != null) {
                                            CollectionReference users =
                                                firebaseFirestore
                                                    .collection('users');
                                            await users.doc(user!.uid).set({
                                              'name':  "${fnameController.text} ${lnameController.text}" == "" ? fname : "${fnameController.text} ${lnameController.text}",
                                              'email': emailController.text == "" ?  email : emailController.text ,
                                              'cin': cinController.text == "" ? cin : cinController.text,
                                              'tel': telController.text == "" ? tel : telController.text,
                                              'adresse': adresseController.text == "" ? adresse : adresseController.text ,
                                              'photo': "",
                                              'uid': user!.uid,
                                              'provider': "EMAIL"
                                            });
                                            }
                                          
                                        },
                                        child: const Text(
                                          "Enregistrer",
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
                              onPressed: () {  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const changePassword()));},
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