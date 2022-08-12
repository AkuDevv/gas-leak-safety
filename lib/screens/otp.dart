import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPVerfication extends StatefulWidget {
  String phone = '';

  OTPVerfication({Key? key, required this.phone}) : super(key: key);

  @override
  State<OTPVerfication> createState() => _OTPVerficationState();
}

class _OTPVerficationState extends State<OTPVerfication> {

  String _verificationCode = '';

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 16, 
      color: Color.fromRGBO(30, 60, 87, 1), 
      fontWeight: FontWeight.w600
    ),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Phone Verification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              "Verify: ${widget.phone}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 20,),
            
            Center(
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyDecorationWith(
                  border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: const Color.fromRGBO(234, 239, 243, 1),
                  ),
                ),
                validator: (s) {
                  print("v $_verificationCode");
                  print(s);
                  return s == _verificationCode ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onSubmitted: (pin) async {
                  try {
                    await FirebaseAuth.instance.signInWithCredential(
                      PhoneAuthProvider.credential(
                        verificationId: _verificationCode, 
                        smsCode: pin
                      )
                    ).then((value) async {
                      if(value.user != null) {
                        print("GO TO HOME !");
                      }
                    });
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
                  }
                },
                onCompleted: (pin)  {
                  print(pin);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(
          credential
        ).then((value) async {
          if(value.user != null) {
            print("SUCCESS");
          }
        });
      }, 
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        )
      );
      }, 
      codeSent: (String verificationId, int? forceResendingToken) {
        setState(() {
          _verificationCode = verificationId;
        });
        print("CODE SENT $forceResendingToken");
      }, 
      codeAutoRetrievalTimeout: (String id) {
        setState(() {
          _verificationCode = id;
        });
      },
      timeout: const Duration(seconds: 60)
    );
  }
}