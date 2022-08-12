import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/signIn.dart';
import 'package:gas_leak_safety/screens/verify_email.dart';
import 'package:gas_leak_safety/services/auth_service.dart';

class FirstLanding extends StatefulWidget {
  @override
  _FirstLandingState createState() => _FirstLandingState();
}

class _FirstLandingState extends State<FirstLanding> {
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

  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
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
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.1,
                0.4,
                0.7,
                0.9
              ],
                  colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ])),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 425.0,
                  child: Form(
                    key: _formkey,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: Image.asset("assets/images/logo_gas.png"),
                                ),
                              ),
                  
                              const SizedBox(
                                height: 10,
                              ),
                  
                              // FIRST NAME TEXT FIELD
                              TextFormField(
                                controller: fnameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: " First Name ",
                                    labelStyle: const TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                  
                              const SizedBox(
                                height: 10,
                              ),
                  
                              // LAST NAME TEXT FIELD
                              TextFormField(
                                controller: lnameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: " Last Name ",
                                    labelStyle: const TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                  
                              TextFormField(
                                controller: cinController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: " CIN ",
                                    labelStyle: const TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                  
                              TextFormField(
                                controller: telController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: " Numéro Téléphone ",
                                    labelStyle: const TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                              
                              TextFormField(
                                controller: adresseController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: " Adresse Postale ",
                                    labelStyle: const TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                validator: (email) =>
                                    !EmailValidator.validate(email!)
                                        ? "Enter a valid email"
                                        : null,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: " Email ",
                                    prefixIcon: const Icon(Icons.email),
                                    labelStyle: const TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                                autofillHints: const [AutofillHints.email],
                              ),
                  
                              const SizedBox(
                                height: 10,
                              ),
                  
                              // PASSWORD TEXT FIELD
                              TextFormField(
                                validator: (password) {
                                  if (password!.isEmpty) {
                                    return "Enter a password!";
                                  } else if (password.length < 6) {
                                    return "At least 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText: showPassword,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: " Password ",
                                    prefixIcon: const Icon(Icons.lock),
                                    labelStyle: const TextStyle(fontSize: 16),
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
                                            : const Icon(Icons.visibility_off))),
                              ),
                  
                              const SizedBox(
                                height: 10,
                              ),
                  
                              // CONFIRM PASSWORD TEXT FIELD
                              TextFormField(
                                validator: (value) => passwordController.text !=
                                        confirmPasswordController.text
                                    ? "passwords doesn't match"
                                    : null,
                                controller: confirmPasswordController,
                                textInputAction: TextInputAction.done,
                                obscureText: showConfirmPassword,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: " Confirm Password ",
                                    prefixIcon: const Icon(Icons.lock),
                                    labelStyle: const TextStyle(fontSize: 16),
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
                                            : const Icon(Icons.visibility_off))),
                              ),
                  
                              const SizedBox(
                                height: 10,
                              ),
                  
                              // REGISTER BUTTON
                              loading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            if (!_formkey.currentState!
                                                    .validate() ==
                                                true) {
                                              return;
                                            }
                                            setState(() {
                                              loading = true;
                                            });
                                            User? user = await AuthService()
                                                .register(
                                                    emailController.text,
                                                    passwordController.text,
                                                    context);
                                            if (user != null) {
                                              CollectionReference users =
                                                  firebaseFirestore
                                                      .collection('users');
                                              await users.doc(user.uid).set({
                                                'name':
                                                    "${fnameController.text} ${lnameController.text}",
                                                'email': emailController.text,
                                                'photo': "",
                                                'uid': user.uid,
                                                'provider': "EMAIL"
                                              });
                                              // ignore: use_build_context_synchronously
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const VerifyEmailScreen()));
                                            }
                                            setState(() {
                                              loading = false;
                                            });
                                          },
                                          child: const Text(
                                            "Register",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                  
                              const SizedBox(
                                height: 20,
                              ),
                  
                              // LOGIN BUTTON
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInMethodScreen()));
                                },
                                child: const Text(
                                    "Already have an account? Login here",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ), 
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(microseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    fontFamily: 'Sfpro',
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
