import 'package:aj_ar/Provider/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Home',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        body: Column(children: [
          SizedBox(
            height: size.height * .8,
            child: FittedBox(
              child: Image.asset('assets/logo.gif'),
              fit: BoxFit.fitHeight,
            ),
          ),
          InkWell(
            onTap: () => Provider.of<AuthProvider>(context, listen: false)
                .signinWithGoogle(),
            child: Image.asset('assets/SignIn.png'),
          ),
        ]));
  }
}
