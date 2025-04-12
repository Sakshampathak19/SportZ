import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class Live_page extends StatefulWidget {
  List<Map<String,dynamic>> ? list;

  Live_page({required List<Map<String,dynamic>> list}){
    this.list=list;
  }

  _Live_pageState createState() => _Live_pageState(list: list!);
}

class _Live_pageState extends State<Live_page> {
  List<Map<String,dynamic>> ? list;

  _Live_pageState({required List<Map<String,dynamic>> list}){
    this.list=list;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
          itemCount: list!.length,
          itemBuilder: (context, index) {
            if (index % 2 == 0) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.blue,),
                    width: MediaQuery.of(context).size.width - 50,
                    
                    child: Stack(
                      children: [
                        Positioned(
                            top: -50,
                            left: -180,
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                child: Container(
                                    height: 280,
                                    width: 280,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.blue, width: 5),
                                        shape: BoxShape.circle)),
                              ),
                            )),
                        BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4)),
                        Positioned(
                            top: 75,
                            left: 0,
                            child: Container(
                              height: 50,
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    height: 13,
                                    width: 13,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                            
                                        shape: BoxShape.circle),
                                  ),
                                  const Text(
                                    'LIVE',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                            Positioned(
                              right: 0,
                              child: Container(
                              
                              height: 200,
                              width: MediaQuery.of(context).size.width*(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('${list![index]['Team1']}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                      Text('${list![index]['Score1']}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                                      
                                    ],
                                  ),
                                  Text('-',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('${list![index]['Team2']}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                      Text('${list![index]['Score2']}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                                    ],
                                  )
                                 ],)
                                ],
                              ),
                            ))
                      ],
                    )),
              );
            } else if (index % 2 == 1){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.white,),
                    width: MediaQuery.of(context).size.width - 50,
                    
                    child: Stack(
                      children: [
                        Positioned(
                            top: -50,
                            right: -180,
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: const BoxDecoration(
                                  color: Colors.blue, shape: BoxShape.circle),
                              child: Center(
                                child: Container(
                                    height: 280,
                                    width: 280,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.white, width: 5),
                                        shape: BoxShape.circle)),
                              ),
                            )),
                        Positioned(
                            top: 75,
                            right: 0,
                            child: Container(
                              height: 50,
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 800),
                                    height: 13,
                                    width: 13,
                                    decoration: BoxDecoration(
                                        color: 
                                             Colors.red
                                            ,
                                        shape: BoxShape.circle),
                                  ),
                                  const Text(
                                    'LIVE',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                            Positioned(
                              left: 0,
                              child: Container(
                              
                              height: 200,
                              width: MediaQuery.of(context).size.width*(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('${list![index]['Team1']}',style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                                      Text('${list![index]['Goal1']}',style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),)
                                      
                                    ],
                                  ),
                                  Text('-',style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('${list![index]['Team2']}',style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                                      Text('${list![index]['Goal2']}',style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),)
                                    ],
                                  )
                                 ],)
                                ],
                              ),
                            ))
                      ],
                    )),
              );
          }  
          }),
    );
  }
}
