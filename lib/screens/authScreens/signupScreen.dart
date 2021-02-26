import 'package:flutter/material.dart';
import 'package:minor/widgets/customTextField.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover),
            gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Colors.purple,
              Theme.of(context).accentColor,
              Colors.blue,
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: MediaQuery.of(context).size.height * 0.210,
                  child: Image.asset(
                    'assets/signup.png',
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Create Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomTextField(
                  hint: '    enter email',
                  issecured: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: '    enter name',
                  issecured: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: '    choose a strong Password',
                  issecured: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: ButtonTheme(
                      buttonColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          'Create',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
