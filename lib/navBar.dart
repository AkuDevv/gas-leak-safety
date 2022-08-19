// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/login_email_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  String? name = "";
  String? email = "";

  late String documentId;
  User? user = FirebaseAuth.instance.currentUser;

  Future _getUserFromFirebase() async {
    await FirebaseFirestore.instance.collection('users')
    .doc(user!.uid)
    .get().then((snapshot) async {
      if(snapshot.exists){
        setState(() {
          name = snapshot.data()!['name'];
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name ?? 'test',
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: 'Sfpro')),
            accountEmail: Text(email ?? 'test',
                style: TextStyle(
                    color: Colors.white, fontSize: 14, fontFamily: 'Sfpro')),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/images/logo_.png'),
                  width: 110,
                  height: 110,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              //image: DecorationImage(image: AssetImage('assets/images/conseils.jpg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historique'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text('Contact'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Se déconnecter'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
