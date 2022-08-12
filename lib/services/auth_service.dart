import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Register User : Email And Password
  Future<User?> register(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        )
      );
    }
    return null;
  }

  // Login User : Email and Password
  Future<User?> login(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        )
      );
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        )
      );
    }
    return null;
  }

  Future<bool> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        )
      );
      return false;
    }
  }

  // Login User : Google
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<User?> loginGoogle(BuildContext context) async {
      try {
        GoogleSignInAccount? googleSignInAccount  = await googleSignIn.signIn();
        if(googleSignInAccount == null) return null;
        
        final googleSignInAuthentication  = await googleSignInAccount.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication .accessToken,
          idToken: googleSignInAuthentication .idToken
        );

        final result = await firebaseAuth.signInWithCredential(credential);
        User user = result.user!;

        bool exist = await checkUserExists(user.uid);
        if(exist) {
          print("EXISTS");
          return result.user;
        }
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        await users.doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'photo': user.photoURL,
          'uid': user.uid,
          'provider': "GOOGLE"
        });
        return result.user;

      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            backgroundColor: Colors.red,
          )
        );
      }
      return null;
  }

  void logoutGoogle()   async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  // CHECK IF USER EXISTS IN FIRESTORE
  Future<bool> checkUserExists(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return true;
    }
    return false;
  }

  // GET USER DATA FROM FIRESTORE
  Future<User?> getUserDataFromFirestore(String uid) async {
    User? user;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if(snapshot.exists) { 
      return user;
    }
    else {return user;}
  }
}