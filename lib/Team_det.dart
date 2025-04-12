import 'package:flutter/material.dart';
import 'package:flutter_proj/Football_Scoring.dart';
import 'globals.dart';

class Team_1 extends StatefulWidget {
  int num;

  Team_1({required this.num});

  _Team_1State createState() => _Team_1State(num: num);
}

class _Team_1State extends State<Team_1> {
  int num;
  _Team_1State({required this.num});

  TextEditingController team = TextEditingController();
  List<TextEditingController> list = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Enter the name of Team${num}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width - 40,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: team,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xff595b5d), width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.blue, width: 2)),
                  prefixIcon: const Icon(
                    Icons.sports,
                    color: Colors.blue,
                  ),
                  label: const Text(
                    'Team Name',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Enter Players of Team${num}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          Expanded(
              child: ListView.builder(
                  itemCount: 11,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: list[index],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Color(0xff595b5d), width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.blue, width: 2)),
                              prefixIcon: const Icon(
                                Icons.sports,
                                color: Colors.blue,
                              ),
                              label: Text(
                                'Player ${index + 1}',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    );
                  })),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              if (num == 1) {
                if (team.text.isEmpty == false) {
                  team1['Name'] = team.text.toString();
                }

                for (int i = 0; i < list.length; i++) {
                  if (list[i].text.isEmpty == false) {
                    team1['Player'][i] = list[i].text.toString();
                  }
                }

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Team_1(num: 2)));
              }
              if (num == 2) {
                if (team.text.toString().length != 0) {
                  team2['Name'] = team.text.toString();
                }

                for (int i = 0; i < list.length; i++) {
                  if (list[i].text.toString() != 0) {
                    team2['Player'][i] = list[i].text.toString();
                  }
                }

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Foot_Score()));
              }
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text("Confirm",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),)
    );
  }
}