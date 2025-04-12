import 'package:flutter/material.dart';
import 'package:flutter_proj/Home_Screen.dart';
import 'package:flutter_proj/Particles.dart';
import 'package:flutter_proj/SignUp.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';
import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState()=> _Login();
}

class _Login extends State<Login>{

  String error_text='';

  Future <void> loginUser() async{
    try{
      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail_cont.text.toString(), password: pass_cont.text.toString());
    print('Login Successful');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Screen()));
    }
    on FirebaseAuthException catch(e){
      setState(() {
        error_text=e.message.toString();
      });
    }
    catch (e){
      setState(() {
          error_text='Network error please try after some time';
        });
    }
  }

    final GlobalKey<FormState> _globalKey = GlobalKey();

  TextEditingController pass_cont = TextEditingController();
  TextEditingController mail_cont = TextEditingController();

  bool show_pass = false;

  void submit() {
    final isValid = _globalKey.currentState!.validate();

    if (isValid == true) {
      _globalKey.currentState!.save();
      loginUser();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Particles(
              particles: particle(),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                  color: Colors.white.withOpacity(0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),
            ),
          ),
          SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'WELCOME BACK !!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'You were missed !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 100,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(error_text,textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),),
                const SizedBox(height: 25,),
                Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.transparent,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty == true ||
                                  value.contains('@') == false) {
                                return 'Enter valid E-mail';
                              }

                              return null;
                            },
                            controller: mail_cont,
                            style: const TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 3)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color: Colors.blue,
                                ),
                                hintText: 'Eg. abc@gmail.com',
                                hintStyle: const TextStyle(color: Colors.grey),
                                label: const Text(
                                  'Email',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                enabled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 3))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.transparent,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty == true) {
                                return "Password can't be empty";
                              } 
                              return null;
                            },
                            controller: pass_cont,
                            obscuringCharacter: '•',
                            style: const TextStyle(color: Colors.blue),
                            obscureText: !show_pass,
                            decoration: InputDecoration(
                                suffixIconColor: Colors.blue,
                                suffixIcon: show_pass == false
                                    ? IconButton(
                                        disabledColor: Colors.blue,
                                        color: Colors.blue,
                                        onPressed: () {
                                          show_pass = !show_pass;
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.visibility_outlined))
                                    : IconButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          show_pass = !show_pass;
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                            Icons.visibility_off_outlined)),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 3)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                prefixIcon: const Icon(
                                  Icons.lock_outline_sharp,
                                  color: Colors.blue,
                                ),
                                hintText: '(Atleast -6 characters)',
                                hintStyle: const TextStyle(color: Colors.grey),
                                label: const Text(
                                  'Password',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                enabled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 3))),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){

                            }, child: const Text('Forgot Password?',
                            style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                            )),
                            const SizedBox(width: 15,),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.blue),
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.white),
                              ),
                              onPressed: () {
                                submit();
                              },
                              child: const Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Not having an account ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignUP()));
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ],

                    ))
              ],
            )),
          )
        ],
      ),
  );
  }
}