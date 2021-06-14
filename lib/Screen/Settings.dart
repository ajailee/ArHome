import 'package:aj_ar/Provider/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySettings extends StatelessWidget {
  static String routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: user == null
          ? CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: user != null
                          ? NetworkImage(
                              user.photoURL,
                            )
                          : null,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text('Name',
                        style: Theme.of(context).textTheme.bodyText1),
                    subtitle: Text(user.displayName,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    title: Text('Email',
                        style: Theme.of(context).textTheme.bodyText1),
                    subtitle: Text(user.email,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    title: Text('Sign Out',
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signout();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text(
                      'About',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onTap: () {
                      showAboutDialog(
                        applicationName: 'My Home',
                        applicationVersion: '1.0.0',
                        context: context,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
