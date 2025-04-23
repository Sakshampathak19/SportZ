import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'globals.dart';

class Stats extends StatefulWidget {
  String str='';

  Stats({required this.str});

  _StatsState createState() => _StatsState(string: str);
}

class _StatsState extends State<Stats> {
  String string='';

  _StatsState({required string}){
    this.string=string;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 10),
                        image: DecorationImage(
                            image: profile==''?const AssetImage('assets/profile.png'):FileImage(File(profile)),
                            opacity: 1,
                            fit: BoxFit.cover)),
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5)),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                          0.15 -
                                      10,
                                  width: MediaQuery.of(context).size.height *
                                          0.15 -
                                      10,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: profile==''?const AssetImage('assets/profile.png'):FileImage(File(profile)),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Saksham Pathak',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Left Back',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                          size: 25,
                        )),
                  )
                ],
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 8,
                itemBuilder: (context, index) {
                  String str = index == 0
                      ? 'Matches'
                      : index == 1
                          ? 'Won'
                          : index == 2
                              ? 'Lost'
                              : index == 3
                                  ? 'Draw'
                                  : index == 4
                                      ? 'Goals'
                                      : index == 5
                                          ? 'Yellow'
                                          : index == 6
                                              ? 'Red'
                                              : string;
                  String val=index == 0
                      ? '10'
                      : index == 1
                          ? '6'
                          : index == 2
                              ? '3'
                              : index == 3
                                  ? '1'
                                  : index == 4
                                      ? '5'
                                      : index == 5
                                          ? '3'
                                          : index == 6
                                              ? '1'
                                              : '60 %';
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(val,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Text(str,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200))
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      )),
    );
  }
}
