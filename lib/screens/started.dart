// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gas_leak_safety/models/slide.dart';
import 'package:gas_leak_safety/screens/login_email_password.dart';
import 'package:gas_leak_safety/widgets/slidesitem.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final int _numPages = 3;

  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 2.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? /*Color(0xff326789)*/Color(0xff41436a) : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: <Widget>[
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                itemCount: slideList.length,
                itemBuilder: (ctx, i) => SlideItem(i),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginScreen()));},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Color(0xff41436a),
                    textColor: Colors.white,
                    child: const Text(
                      'Rejoinez nous!',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Sfpro',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Vous êtes un pompier ?',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Sfpro',
                            color: Color(0xff41436a),
                      ),),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Se connecter',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Sfpro',
                              color: Color(0xff41436a),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
