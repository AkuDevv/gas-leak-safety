// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/navBar.dart';
import 'package:gas_leak_safety/ui/ObjectBox.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gas_leak_safety/services/calls_service.dart';
import 'package:gas_leak_safety/services/services_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: const [Color(0xff00366f), Color(0xffd41d35)],
                        stops: const [0.2, 0.9])),
                child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      "Accueil",
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 160,
                        height: 140,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey
                          ),
                        ),
                      ),
                      Text(
                        'Solution innovante \net affordable ',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Sfpro',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff04346c)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: const [
                    ObjectBox(
                      title: 'Maintenance',
                      assetPath: 'assets/images/maintenance.png',
                    ),
                    ObjectBox(
                      title: 'Consultation',
                      assetPath: 'assets/images/consulter.jpg',
                    ),
                    ObjectBox(
                      title: 'Nos services',
                      assetPath: 'assets/images/serv.jpg',
                    ),
                    ObjectBox(
                      title: "Conseils d'utilisation",
                      assetPath: 'assets/images/conseils.jpg',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, left: 5, right: 5),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    _service.call('0697545209');
                  },
                  label: const Text(
                    'Contactez Nous!',
                    style: TextStyle(
                        fontFamily: 'Sfpro', fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.call),
                  backgroundColor: Color(0xff04346c),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
