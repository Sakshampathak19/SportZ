import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Leaders.dart';
import 'package:flutter_proj/Login.dart';
import 'package:flutter_proj/My_QR.dart';
import 'package:flutter_proj/Rate_Us.dart';
import 'package:flutter_proj/Start.dart';
import 'package:flutter_proj/Stats.dart';
import 'package:flutter_proj/Tournament.dart';
import 'package:flutter_proj/globals.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  PageController pg = PageController();

  void imagePick() async {
    final currUser = await FirebaseAuth.instance.currentUser;

    if (currUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currUser.uid)
          .get();

      if (doc.exists) {
        setState(() {
          image = doc.data()?['profile']?? "";
          profile=image;
        });
      }
    } else {
      setState(() {
        image = '';
        profile='';
      });
    }
  }

  String stat_str='';

  void initState() {
    if(stat_useer!=null){
      setState(() {
        stat_str=stat_useer!.uid.toString();
      });
    }
    imagePick();
  }

  final stat_useer=FirebaseAuth.instance.currentUser;

  ImagePicker picker = ImagePicker();

  XFile? file;

  List<Widget> pages = [
    const Tournaments(),
    Start(),
    Leaders(),
  ];

  int curr_val = 0;

  void jump(int index) {
    setState(() {
      curr_val = index;
    });

    pg.jumpToPage(curr_val);
  }

  void update(int value) {
    setState(() {
      curr_val = value;
    });
  }

  String image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "SportZ",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
          backgroundColor: Colors.black,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Container(
            color: Colors.black,
            child: ListView(
              children: [
                DrawerHeader(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () async {
                              file = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (file != null) {
                                final currUser =
                                    FirebaseAuth.instance.currentUser;

                                if (currUser != null) {
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(currUser.uid)
                                      .update({'profile': file!.path});

                                  imagePick();
                                }
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              maxRadius: 45,
                              minRadius: 25,
                              backgroundImage: image == ''
                                  ? AssetImage('assets/profile.png')
                                  : FileImage(File(image)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Saksham Pathak',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Stats(str: stat_str,)));
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.query_stats,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'My Stats',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        print('Yes');
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.flag_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'My Teams',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        print('Yes');
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.leaderboard_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'My Performance',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>My_QR()));
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.qr_code_2,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'My QR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                      },
                                      child: const Text('YES')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('NO')),
                                ],
                                title: const Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            });
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Log Out',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Rate_Us()));
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.star_rate,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Rate Us',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        print('Yes');
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'About Us',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
      body: PageView(
        children: pages,
        controller: pg,
        onPageChanged: (value) {
          update(value);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            jump(value);
          },
          currentIndex: curr_val,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.blue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  curr_val == 0 ? Icons.home : Icons.home_outlined,
                )),
            BottomNavigationBarItem(
                label: 'Start',
                icon: Icon(
                  curr_val == 1 ? Icons.add : Icons.add_outlined,
                )),
            BottomNavigationBarItem(
                label: 'Leaderboard',
                icon: Icon(
                  curr_val == 2
                      ? Icons.leaderboard
                      : Icons.leaderboard_outlined,
                )),
          ]),
    );
  }
}

Widget field(String str,IconData icon) {
  return Row(
    children: [
      SizedBox(
        width: 20,
      ),
      Icon(
        icon,
        color: Colors.white,
      ),
      SizedBox(
        width: 20,
      ),
      Text(
        str,
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      )
    ],
  );
}
