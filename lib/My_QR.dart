import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Particles.dart';
import 'package:flutter_proj/QR_Scanner.dart';
import 'package:flutter_proj/globals.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:particles_flutter/particles_engine.dart';
import 'package:qr_flutter/qr_flutter.dart';

class My_QR extends StatefulWidget{
  State<My_QR> createState()=> _My_QR();
}

class _My_QR extends State<My_QR>{
  String str='';

  late Future<String?> name;

  User ? user=FirebaseAuth.instance.currentUser;

  Future<String?> getName() async{
    try{
      if(user!=null){
        final doc =await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();

        if(doc.exists){
          return doc.data()!['Name'];
        } 
        else{
          return '';
        }
      }
    }
    catch(e){
      print(e);
    }
  }

  void initState(){
    name=getName();
  }

  @override
  Widget build(BuildContext content){
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: FutureBuilder(future: name, builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting || snapshot.hasData==false){
          return Center(child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }

        
         
            str=snapshot.data.toString();
          
        return Stack(
        children: [
          Particles(particles: particle(), height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width),
          ClipRRect(
            child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
            child: Container(
                  color: Colors.white.withOpacity(0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width)
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height:100),
                  Stack(
                    children: [
                      Container(
                        height: 450,
                        width: MediaQuery.of(context).size.width-50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 70,),
                            Text(str,textAlign: TextAlign.center ,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 20,),
                            QrImageView(
                              size: 200,
                              data: user!.uid.toString()),
                              const SizedBox(height: 20,),
                              const Text("Scan the QR to get your friend's Stats.",textAlign: TextAlign.center ,style: TextStyle(color: Colors.black,fontSize: 12),),
                              const SizedBox(height: 20,),
                              const Text('SportZ',textAlign: TextAlign.center ,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),

                  ElevatedButton(
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),     
                    )
                    ,onPressed: (){
                      Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QRScannerPage(),
                ),
              );
                  }, child:Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child:const Center(child: Text('Scan QR Code',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),) 
                    )
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 50,
            child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Container(height: 90,width: 90,decoration: BoxDecoration(
              image: DecorationImage(image: profile==''?AssetImage('assets/profile.png'):FileImage(File(profile)),fit: BoxFit.cover,opacity: 1,),
            shape:BoxShape.circle,
            color: Colors.black 
          ),),)),
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close_rounded,color:Colors.white,size:30,)))
        ],
      );
      })),
    );
  }
}

