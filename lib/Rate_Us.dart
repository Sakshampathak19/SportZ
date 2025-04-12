import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Home_Screen.dart';
import 'package:flutter_proj/Particles.dart';
import 'package:particles_flutter/particles_engine.dart';

class Rate_Us extends StatefulWidget {
  State<Rate_Us> createState() => _Rate_Us();
}

class _Rate_Us extends State<Rate_Us> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> Update_Ratings(int ratings) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Ratings')
            .doc(user!.uid)
            .set({'Ratings': ratings, 'Uid': user!.uid});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getRating() async{
    if(user!=null){
      final snapshot = await FirebaseFirestore.instance.collection('Ratings').where('Uid', isEqualTo: user!.uid).get();

      setState(() {
        if(snapshot.size!=0){
        is_rated=true;
      }
      else{
        is_rated=false;
      }
      });
    }
  }

  Future ? check;

  void initState(){
    check=getRating();
  }

  List<int> val = [0, 0, 0, 0, 0];
  int ratings = 0;
  bool is_rated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Particles(
                  particles: particle(),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width-25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          height: MediaQuery.of(context).size.width / 2,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                  image: AssetImage('assets/ratings.gif'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Your opinion matters to us !',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'We work super hard to make SportZ better for you, and would love to know how would you rate our app.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: val.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if(val[index]==1){
                                              if(index==4){
                                                for(int i=0;i<=index;i++){
                                                  val[i]=0;
                                                }
                                              }
                                              else{
                                                if(val[index+1]==0){
                                                  for(int i=0;i<=index;i++){
                                                    val[i]=0;
                                                  }
                                                }
                                                else{
                                                  for(int i=index+1;i<=4;i++){
                                                    val[i]=0;
                                                  }
                                                }
                                              }
                                            }
                                            else{
                                              for (int i = 0; i <=index; i++) {
                                                val[i]=1;
                                              }
                                            }
                            
                                            ratings = index + 1;
                                          });
                                        },
                                        icon: val[index] == 1
                                            ? const Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                                size: 40
                                              )
                                            : const Icon(
                                                Icons.star_outline,
                                                color: Colors.blue,
                                                size: 40
                                              )),
                                  );
                                }),
                          ),
                        ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              is_rated = true;
                    
                              Update_Ratings(ratings);

                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Screen()));
                            },
                            style: ButtonStyle(
                                padding: WidgetStateProperty.all(
                                    const EdgeInsets.all(0))),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: Colors.white, width: 2)),
                              child: const Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text('Love from the SportZ team.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            )),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,)))
            ],
          ),
        ));
  }
}
