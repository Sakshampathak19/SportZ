import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Home_Screen.dart';
import 'globals.dart';

class Foot_Score extends StatefulWidget {
  const Foot_Score({super.key});
  _Foot_ScoreState createState() => _Foot_ScoreState();
}

class _Foot_ScoreState extends State<Foot_Score> {
  User? user=FirebaseAuth.instance.currentUser;
  String A_name = team1['Name'];
  String B_name = team2['Name'];
  List<String> A = team1['Player'];
  List<String> B = team2['Player'];

  int score_A=0;
  int score_B=0;


  Timer? timer;
  int seconds = 0;
  int minutes = 0;

  String time = '00:00';
  bool is_live = false;

  DateTime match_date=DateTime.now();

  Future<void> add_past() async{
    await FirebaseFirestore.instance.collection('Past_Matches').add({
      'Team1': A_name,
      'Team2': B_name,
      'Winner': score_A>score_B ? A_name : score_A<score_B ? B_name : "Draw",
      'Score1':score_A,
      'Score2':score_B,
      'Goals1':goals['team1'],
      'Goals2':goals['team2'],
      'Date':'${match_date.day}-${match_date.month}-${match_date.year}',
      'Num':match_num
    });

    match_num++;
    match_num%=100000;
  }

  void start() async{
    await FirebaseFirestore.instance.collection('Live').doc(user!.uid).set({
      'Team1': A_name,
      'Team2': B_name,
      'Score1':0,
      'Score2':0,
      'Date':'${match_date.day}-${match_date.month}-${match_date.year}',
    });
    setState(() {
      is_live = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        seconds++;

        if (seconds == 60) {
          minutes++;
          seconds %= 60;
        }

        if (minutes < 10) {
          time = '0${minutes}:';
        } else {
          time = '${minutes}:';
        }

        if (seconds < 10) {
          time = time + '0${seconds}';
        } else {
          time = time + '${seconds}';
        }

        if ((minutes == 1 && seconds == 00) ||
            (minutes == 2 && seconds == 00)) {
          is_live = false;
          t.cancel();

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                        onPressed: () async{
                          if(minutes == 1){
                            Navigator.pop(context);
                          }
                          else if(minutes==2){
                            add_past();
                            await FirebaseFirestore.instance.collection('Live').doc(user!.uid).delete();
                            Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home_Screen()));
                          }
                        },
                        child: const Text(
                          "OK",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ))
                  ],
                  content: Text(
                    minutes == 1 ? "Half Time !!" : "Full Time",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                );
              });
        }
      });
    });
  }

  void pause() {
    setState(() {
      is_live = false;
      timer!.cancel();
    });
  }

  Map<String, dynamic> goals = {'team1': {}, 'team2': {}};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                '${A_name} v/s ${B_name}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  time,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    if (is_live == false) {
                      start();
                    } else {
                      pause();
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40)),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                        child: Text(
                      is_live == false ? "Start" : "Pause",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Container(
                height: 250,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${A_name}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Text(
                            '${score_A}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  // barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              50,
                                          child: ListView.builder(
                                              itemCount: 11,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  child: ListTile(
                                                    onTap: () async{
                                                      if (is_live == true) {
                                                        setState(() {
                                                          score_A++;
                                                          int a = minutes;
                                                          int b = seconds;

                                                          String str =
                                                              "${a}'${b}";
                                                          goals['team1'][
                                                                  '${A[index]}'] =
                                                              str;
                                                        });

                                                        Navigator.pop(context);
                                                        await FirebaseFirestore.instance.collection('Live').doc(user!.uid).update({
                                                          'Score1':score_A
                                                        });
                                                      }
                                                    },
                                                    title: Text("${A[index]}"),
                                                  ),
                                                );
                                              }),
                                        ));
                                  });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(color: Colors.blue),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    Expanded(
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${B_name}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Text(
                            '${score_B}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  // barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              50,
                                          child: ListView.builder(
                                              itemCount: 11,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  child: ListTile(
                                                    onTap: () async{
                                                      if (is_live == true) {
                                                        setState(() {
                                                          score_B++;
                                                          int a = minutes;
                                                          int b = seconds;

                                                          String str =
                                                              "${a}'${b}";
                                                          goals['team2'][
                                                                  '${B[index]}'] =
                                                              str;
                                                        });

                                                        Navigator.pop(context);
                                                        await FirebaseFirestore.instance.collection('Live').doc(user!.uid).update({
                                                          'Score2':score_B
                                                        });
                                                      }
                                                    },
                                                    title: Text("${B[index]}"),
                                                  ),
                                                );
                                              }),
                                        ));
                                  });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(color: Colors.blue),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Container(
                height: 400,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ListView.builder(
                          itemCount: goals['team1'].entries.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  goals['team1'].entries.elementAt(index).key,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  goals['team1'].entries.elementAt(index).value,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            );
                          }),
                    ),
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                          itemCount: goals['team2'].entries.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  goals['team2'].entries.elementAt(index).key,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  goals['team2'].entries.elementAt(index).value,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            );
                          }),
                    ))
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
