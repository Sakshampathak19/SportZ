import 'package:flutter/material.dart';
import 'package:flutter_proj/Fav_sport.dart';
import 'package:flutter_proj/Login.dart';
import 'package:flutter_proj/Particles.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';
import 'dart:math';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUP extends StatefulWidget{
  const SignUP({super.key});

  @override
  State<SignUP> createState()=> One();
}

class One extends State<SignUP>{

  final GlobalKey<FormState> _globalKey = GlobalKey();

  Future <void> signUpUser() async{
    try{
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.toString(), password: password.text.toString());
      print('User added Successfully');

      User ?user=FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('Users').doc(user!.uid).set({
        'Name':name.text.toString(),
        'Email':email.text.toString(),
        'Password':password.text.toString(),
        'DOB':dob.text.toString(),
        'Phone_num':phone_num.text.toString()
      }).catchError((e){
        print(e);
      });

      await FirebaseFirestore.instance.collection('Players').doc(phone_num.text.toString()).set({
        'Name':name.text.toString(),
        'Uid':userCredential.user!.uid
      });

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const FavSport()));

    }
    on FirebaseAuthException catch (e){
      if (e.code=='weak-password'){
        print('The password provided is too weak.');
      }
      else if(e.code=='email-already-in-use'){
        print('The account already exists for that email.');
      }
      else{
        print('Error: ${e.message}');
      }
    } 
    catch (e) {
      print('Error: $e');
    }
  }

  bool show_pass = false;
  bool show_cpass= false;

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController dob=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController c_password=TextEditingController();
  TextEditingController phone_num=TextEditingController();

  late DateTime? time=DateTime(1800);


  Future datePick() async{
    time= await showDatePicker
    (context: context,
    currentDate: DateTime.now(),
    firstDate: DateTime(1960), 
    lastDate: DateTime.now()
    );

    if(time==null){
      setState(() {
        time=DateTime(1800);
      });
    }
    else{
      setState(() {
        if(time!=DateTime(1800)){
          age='${time!.day}/${time!.month}/${time!.year}';

          c=Colors.grey;
        }
      });
    }
  }

  bool date=true;

  Color c=Colors.grey;


  void submit() async{
    final isValid = _globalKey.currentState!.validate();
    if(time==DateTime(1800)){
      setState(() {
        c=Colors.red;
      });
      return;
    }

    if (isValid == true) {
      _globalKey.currentState!.save();


      signUpUser();
    } else {
      return;
    }
  }

  String age='Select you D.O.B';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          Particles(
              particles: particle(),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width
          ),
          
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
                  'Welcome To SportZ !!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                  TypewriterAnimatedText(
                  'Winners never quits,quitters never win !',
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  )
                ]),
                const SizedBox(
                  height: 30,
                ),
                const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.transparent,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty == true) {
                                return 'Enter a valid name';
                              }

                              return null;
                            },
                            controller: name,
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
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                hintText: 'Eg. Saksham Pathak',
                                hintStyle: const TextStyle(color: Colors.grey),
                                label: const Text(
                                  'Name',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                enabled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 3))),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            datePick();
                          },
                          child: Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: c,
                                width: 0.5
                              )
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10,),
                                const Icon(Icons.calendar_month,color: Colors.blue,),
                                const SizedBox(width: 15,),
                                Text(age,style: const TextStyle(color: Colors.blue,fontSize: 17),)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.transparent,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty == true ||
                                  value.length<10 || value.length>10) {
                                return 'Enter valid Phone number';
                              }

                              return null;
                            },
                            controller: phone_num,
                            keyboardType: TextInputType.phone,
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
                                  Icons.call,
                                  color: Colors.blue,
                                ),
                                hintText: 'Eg. 982724XXXX',
                                hintStyle: const TextStyle(color: Colors.grey),
                                label: const Text(
                                  'Phone',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                enabled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 3))),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.transparent,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty == true ||
                                  value.contains('@') == false ) {
                                return 'Enter valid E-mail';
                              }

                              return null;
                            },
                            controller: email,
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
                                return 'Enter valid Password';
                              } else if (value.length < 6) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            controller: password,
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
                        const SizedBox(height: 20,),

                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.transparent,
                          child: TextFormField(
                            validator: (value) {
                              if(value!.isEmpty){
                                return null;
                              }
                              else if (value.toString()!=password.text.toString()) {
                                return "Password Doesn't match";
                              }
                              return null;
                            },
                            controller: c_password,
                            obscuringCharacter: '•',
                            style: const TextStyle(color: Colors.blue),
                            obscureText: !show_cpass,
                            decoration: InputDecoration(
                                suffixIconColor: Colors.blue,
                                suffixIcon: show_cpass == false
                                    ? IconButton(
                                        disabledColor: Colors.blue,
                                        color: Colors.blue,
                                        onPressed: () {
                                          show_cpass = !show_cpass;
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.visibility_outlined))
                                    : IconButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          show_cpass = !show_cpass;
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
                                hintText: 'Repeat your password',
                                hintStyle: const TextStyle(color: Colors.grey),
                                label: const Text(
                                  'Confirm Password',
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
                          height: 34,
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
                              child: const Text("Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already having an account ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Login()));
                                },
                                child: const Text(
                                  'Log in',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
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