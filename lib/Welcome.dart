import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Home_Screen.dart';
import 'package:flutter_proj/Login.dart';
import 'package:flutter_proj/globals.dart';

class Welcome extends StatefulWidget{
  const Welcome({super.key});

    @override
  State<Welcome> createState()=> _Welcome();
}

class _Welcome extends State<Welcome>{
    @override
  void initState() {
    user=FirebaseAuth.instance.currentUser;
    // TODO: implement initState
    Timer(
     const Duration(milliseconds: 3300),
     (){
        if(user==null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Screen()));
        }
     }

    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
            alignment: const Alignment(0, 100),
        width: MediaQuery.of(context).size.width-50,
        height: MediaQuery.of(context).size.height-500,
        decoration:  BoxDecoration(
          boxShadow: const [
              BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              spreadRadius: 4
            )
          ],
          borderRadius: BorderRadius.circular(60),
            image: const DecorationImage(
                image: AssetImage('assets/Welcome_GIF2.gif'),
                fit: BoxFit.cover)),
      )),
    );
    }

}



