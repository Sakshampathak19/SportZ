import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/live_ui.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Tournaments extends StatefulWidget {
  const Tournaments({super.key});
  _TournamentsState createState() => _TournamentsState();
}

class _TournamentsState extends State<Tournaments> {
  int val = 0;

  List<int> tournament = [];

  late Future<void> _future;

  List<Map<String, dynamic>> p_matches = [];
  List<Map<String, dynamic>> l_matches = [];
  List<Map<String, dynamic>> u_matches = [];

  Future<void> get_data() async {
    if (val == 0) {
      l_matches.clear();
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Live').get();

      l_matches = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } else if (val == 1) {
      p_matches.clear();
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Past_Matches').get();

      p_matches = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      p_matches.sort((a, b) => (a['Num'].compareTo(b['Num'])));
    } else if (val == 2) {}
  }

  Future<void> refresh() async{
    _future = get_data() ;
    
    setState(() {
      
    });
    return _future;
  }

  void initState() {
    refresh();
  }

  List<String> tense = ['Live', 'Past', 'Upcoming'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LiquidPullToRefresh(
          showChildOpacityTransition: false,
          height: 100,
          color: Colors.blue,
          animSpeedFactor: 2.5,
          backgroundColor: Colors.white,
          onRefresh: refresh,
          child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              val = index;
                              _future = get_data();
                            });
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: val == index ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                tense[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ));
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: val == 0
                    ? FutureBuilder(
                        future: _future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          } else if (l_matches.isEmpty == true) {
                            return  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(spreadRadius: 3,blurRadius: 4,color: Colors.white)],
                                        image: DecorationImage(image: AssetImage('assets/dne.png'),fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    const Text(
                                      "No Live Tournaments!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ));
                          }
                          return Live_page(list: l_matches,);
                        },
                      )
                    : val == 1
                        ? FutureBuilder(
                        future: _future,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                );
                              } else if (p_matches.isEmpty == true) {
                                return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(spreadRadius: 3,blurRadius: 4,color: Colors.white)],
                                        image: DecorationImage(image: AssetImage('assets/dne.png'),fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    const Text(
                                      "No Past Tournaments!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ));
                              }
                              return ListView.builder(
                                itemCount: p_matches.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Card(
                                      color:
                                          const Color.fromARGB(255, 77, 77, 77),
                                      child: Container(
                                        height: 200,
                                        child: Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '${p_matches[index]['Team1']} vs ${p_matches[index]['Team2']}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${p_matches[index]['Score1']} vs ${p_matches[index]['Score2']}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : FutureBuilder(
                        future: _future,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                );
                              } else if (u_matches.isEmpty == true) {
                                return  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(spreadRadius: 3,blurRadius: 4,color: Colors.white)],
                                        image: DecorationImage(image: AssetImage('assets/dne.png'),fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    const Text(
                                      "No Upcoming Tournaments!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ));
                              }
                              return ListView.builder(
                                itemCount: u_matches.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Card(
                                      color: const Color(0xff4e4d4d),
                                      child: Container(height: 200),
                                    ),
                                  );
                                },
                              );
                            },
                          ))
          ],
        )),
      )
    );
  }
}
