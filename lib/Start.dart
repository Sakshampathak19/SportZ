import 'package:flutter/material.dart';
import 'package:flutter_proj/Team_det.dart';

class Start extends StatefulWidget {
  State<Start> createState() => _Start();
}

class _Start extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: (){

            },
            child: cont(context, 'Start a tournament',Icons.emoji_events_outlined)),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Team_1(num: 1)));
            },
            child: cont(context, 'Start a match',Icons.sports_score)),
        ],
      ),
      )
    );
  }
}

Widget cont(BuildContext context, String text,IconData icon) {
  return Container(
    width: MediaQuery.of(context).size.width - 40,
    height: (MediaQuery.of(context).size.height / 4),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white,width: 2),
      color: Colors.blue,
      borderRadius: BorderRadius.circular(40),
      boxShadow: const [
        BoxShadow(spreadRadius: 3, blurRadius: 15, color: Color.fromARGB(255, 137, 182, 236))
      ],
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon,color: Colors.white,size: 50,),
          Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
        ],
      )
    ),
  );
}
