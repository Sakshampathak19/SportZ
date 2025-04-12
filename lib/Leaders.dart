import 'package:flutter/material.dart';

class Leaders extends StatefulWidget {
  State<Leaders> createState() => _Leaders();
}

class _Leaders extends State<Leaders> {
  List<String> name = [];
  List<int> value = [];

  void initState(){
    for(int i=0;i<20;i++){
      name.add('Saksham Pathak');
      value.add(65);
    }
  }

  String str='Cricket';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width-40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            child:Center(
              child:  DropdownButton( 
                underline: SizedBox.shrink(),
                value: str,
                dropdownColor: Colors.black,
              iconEnabledColor: Colors.white,
              style: TextStyle(color: Colors.white,fontSize: 18),
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(child: Text('Cricket'),value: 'Cricket'),
                DropdownMenuItem(child: Text('Football'),value: 'Football'),
                DropdownMenuItem(child: Text('Volleyball'),value: 'Volleyball'),
                DropdownMenuItem(child: Text('Badminton'),value: 'Badminton'),
                DropdownMenuItem(child: Text('Chess'),value: 'Chess'),
                DropdownMenuItem(child: Text('Carrom'),value: 'Carrom'),
                DropdownMenuItem(child: Text('Table Tennis'),value: 'Table Tennis'),
              ], 
              onChanged: (value){
              setState(() {
                str = value.toString();
              });
            }),
            )
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        child: ListTile(
                          tileColor: Colors.blue,
                          title: Text(name[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text("Runs scored",
                              style: const TextStyle(
                                  color: Colors.white,
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          leading: Text(
                            '${index+1}.'.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(value[index].toString(),
                          style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),)
                        ),
                      ));
                }),
          )
        ],
      ),)
    );
  }
}
