import 'package:flutter/material.dart';
import 'package:gas_leak_safety/screens/otp.dart';

class LoginWithPhoneNumberScreen extends StatefulWidget {
  const LoginWithPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumberScreen> createState() => _LoginWithPhoneNumberScreenState();
}

class _LoginWithPhoneNumberScreenState extends State<LoginWithPhoneNumberScreen> {
  TextEditingController phoneController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool phone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login With Phone Number"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              // LOGO
              SizedBox(
                width: 120,
                height: 120,
                child: Image.asset("assets/images/logo_gas.png"),
              ),
              
              const Text("Phone Number"),

              const SizedBox(height: 20,),

              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  fontSize: 16
                ),
                decoration: InputDecoration(
                  labelText: "  Phone Number  ",
                  labelStyle: const TextStyle(
                    fontSize: 16
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.phone)
                ),
              ),

              const SizedBox(height: 20,),
              
              phone ? const Center(
                child: CircularProgressIndicator()
              ) : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if(!_formkey.currentState!.validate()) {
                      return;
                    }
                    setState(() {
                      phone = true;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OTPVerfication(phone: phoneController.text)));
                    setState(() {
                      phone = false;
                    });
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}