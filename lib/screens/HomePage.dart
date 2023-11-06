import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'package:jot_genius/screens/AddNotes.dart';
import 'package:jot_genius/screens/SettingScreen.dart';
import 'package:jot_genius/utilities/firestoreCRUD.dart';
import 'package:jot_genius/widgets/notesBox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? currUID;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
          await getCurrentUserId().then((value){
              setState(() {
                currUID = value;
              });
          });
  });
  }

  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context: context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFfaf1da),
        floatingActionButton:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            elevation: 5,
          child: Icon(Icons.add,color: Colors.yellow,size: 40,),
          backgroundColor: Colors.black,
          onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: ((context) => AddNotesScreen())));
          },
              ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: Container(
          height: ScreenSize.screenHeight,
          width: ScreenSize.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: ScreenSize.screenHeight*0.10,
                  width: ScreenSize.screenWidth,
                  // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: ScreenSize.screenWidth *0.48,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                        child: Text("Jot Genius",style: TextStyle(fontSize: 30 , fontFamily: "SpaceGrotesk",fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        width: ScreenSize.screenWidth *0.30,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.menu),iconSize: 30,),
                            IconButton(onPressed: (){
                                Navigator.push(context, CupertinoPageRoute(builder: ((context) => SettingsScreen())));
                            }, icon: Icon(Icons.settings),iconSize: 30,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenSize.screenHeight*0.10,
                  width: ScreenSize.screenWidth * 0.9,
                  child: TextField(decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                    prefixIcon: Icon(Icons.search),
                  ),controller: searchController,),
                ),
                Container(
                  width: ScreenSize.screenWidth,
                  child: Center(
                    child: Row(children: [
                      Icon(Icons.notes),
                      SizedBox(width: 8,),
                      Text("Notes",style: TextStyle(fontSize: 30 , fontFamily: "SpaceGrotesk",fontWeight: FontWeight.bold))
                    ],),
                  ),
                ),
                SizedBox(height: 30,),
                StreamBuilder(
                        stream:  FirebaseFirestore.instance
                            .collection('users/${currUID}/Notes')
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if(streamSnapshot.connectionState == ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }else{
                          return Expanded(
                              
                            
                              child : 
                                GridView.count(crossAxisCount: 2,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children :
                              
                              List.generate(streamSnapshot.data!.docs.length, (index){
                                return NotesBox(title: streamSnapshot.data!.docs[index]['title'], body: streamSnapshot.data!.docs[index]['body'],);
                              })
                              
                                )
                          );}
                        },
                      )
              ],
            ),
          )
        ),
      ),
    );
  }
}