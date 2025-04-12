import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_proj/Home_Screen.dart';
import 'package:flutter_proj/Particles.dart';
import 'package:particles_flutter/particles_engine.dart';

class FavSport extends StatefulWidget {
  const FavSport({super.key});

  @override
  State<FavSport> createState() => spo();
}

class spo extends State<FavSport> {
  List<int> arr = [0, 0, 0, 0, 0, 0, 0];

  List<String> sports = [
    'Cricket',
    'Football',
    'Badminton',
    'Volleyball',
    'Table Tennis',
    'Chess',
    'Carrom'
  ];

  String ?name;

  @override
  void initState() {
    super.initState();
    getName();
  }

  Future<void> favSports(List<String> sp) async{
    try{
      final user=await FirebaseAuth.instance.currentUser;

      if(user!=null){
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
          'favsport':sp
        });

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Screen()));
      }
      else{
        print("User do not exists");
      }
    }
    catch (e){
      print('e');
    }
  }

  Future<String?> getName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
            String g = doc.data()?['Name'];
            String h='';

            g.trimLeft();

            for(int i=0;i<g.length;i++){
              if(g[i]==' '){
                h=g.substring(0,i);
                break;
              }
              else{
                h=g.substring(0,i);
              }
            }

            setState(() {
              name=h;
            });
          
          return name;
        }
      }
      return null;
    } catch (e) {
      print('Error fetching name: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(future: getName(), builder: (context,snapshot){
        if(name==null){
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
        else{
          return Stack(
        children: [
          SingleChildScrollView(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Text('Welcome ${name} !!',
                    textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold))
                  ),
                  SizedBox(height:30),
                  const Center(
                    child: Text("Choose your favourite Sports",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(Icons.sports_kabaddi,color: Colors.white,size: 100,),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                arr[index] ^= 1;
                              });
                            },
                            child: Container(
                              height: 100,
                              width:
                                  (0.5 * (MediaQuery.of(context).size.width)) - 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: arr[index]==0? Colors.blue:Colors.white,
                                border: arr[index] == 1
                                    ? Border.all(color: Colors.blue, width: 5)
                                    : Border.all(),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 25,),
                                    Text(
                                      sports[index],
                                      style: TextStyle(
                                          color: arr[index]==0 ? Colors.white:Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10,),
                                    if(index==0)
                                    const Icon(Icons.sports_cricket,color: Colors.blue,)
                                    else if(index==1)
                                    const Icon(Icons.sports_soccer,color: Colors.blue,)
                                    else if(index==2)
                                    const Icon(Icons.sports_tennis,color: Colors.blue,)
                                    else if(index==3)
                                    const Icon(Icons.sports_volleyball,color: Colors.blue,)
                                    else if(index==4)
                                    const Icon(Icons.sports_score,color: Colors.blue,)
                                    else if(index==5)
                                    const Icon(Icons.done,color: Colors.blue,)
                                    else if(index==6)
                                    const Icon(Icons.circle_outlined,color: Colors.blue,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 70),
                ],
              ),
          ),

          if (arr.contains(1) == true)
                Positioned(
                  left: 5,
                  bottom: 10,
                  child: InkWell(
                    onTap: () {
                      List<String> ans=[];

                      for(int i=0;i<sports.length;i++){
                        if(arr[i]==1){
                          ans.add(sports[i]);
                        }
                      }

                      favSports(ans);
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                )
        ],
      );
        }
      })
    );
  }
}
