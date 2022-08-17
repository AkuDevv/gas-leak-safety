// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/login_email_password.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text( 'Siham',
                style: TextStyle(
                    color: Colors.black, fontSize: 16, fontFamily: 'Sfpro')),
            accountEmail: Text('siham@gmail.com',
                style: TextStyle(
                    color: Colors.black, fontSize: 14, fontFamily: 'Sfpro')),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/images/image1.png'),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
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
