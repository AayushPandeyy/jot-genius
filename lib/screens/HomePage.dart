import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'package:jot_genius/screens/AddNotes.dart';
import 'package:jot_genius/screens/EditNotesScreen.dart';
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
        backgroundColor: Color(0xFFe3b3a5),
        
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/page.jpg'),
              fit: BoxFit.fitHeight
            )
          ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        
                        child: Container(
                          width: ScreenSize.screenWidth *0.48,
                          // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                          child: Text("Jot Genius",style: TextStyle(fontSize: 30 , fontFamily: "Gabarito",fontWeight: FontWeight.bold,),),
                        ),
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
                  height: ScreenSize.screenHeight*0.07,
                  width: ScreenSize.screenWidth * 0.8,
                  child: TextField(decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                    prefixIcon: Icon(Icons.search),
                  ),controller: searchController,),
                ),
                SizedBox(height: 10,),
                Container(
                  width: ScreenSize.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.push_pin),
                    SizedBox(width: 8,),
                    Text("Pins",style: TextStyle(fontSize: 30 , fontFamily: "SpaceGrotesk",fontWeight: FontWeight.bold))
                  ],),
                ),
                SizedBox(height: 20,),
                StreamBuilder(
                        stream:  FirebaseFirestore.instance
                            .collection('users/${currUID}/Pinned').orderBy('timestamp')
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if(streamSnapshot.connectionState == ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }else{
                          // countPinned();
                          if(streamSnapshot.data!.docs.length == 0  ){
                            return Center(
                              child: Text("No Pinned Notes yet.",style: TextStyle(fontSize: 20 , fontFamily: "SpaceGrotesk",fontWeight: FontWeight.bold)),
                            );
                          }else{
                          return Expanded(
                              
                            
                              child : 
                                GridView.count(crossAxisCount: 2,
                                
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children :
                              
                              List.generate(streamSnapshot.data!.docs.length, (index){
                                
                                
                                    return GestureDetector(
                                  onTap: (){
                                    
                      
                                    Navigator.of(context).push(CupertinoPageRoute(builder: (context){
                                          return EditNotesScreen(title: streamSnapshot.data!.docs[index]['title'], body: streamSnapshot.data!.docs[index]['body'],date:streamSnapshot.data!.docs[index]['date'] , editedDate: streamSnapshot.data!.docs[index]['editedDate'] ,isPinned: true,);
                                    }));
                                    
                                  },
                                  
                                  child: NotesBox(title: streamSnapshot.data!.docs[index]['title'], body: streamSnapshot.data!.docs[index]['body'],));
                                
                              })
                              
                                ));
                          
                          }
                        };
                }),
  SizedBox(height:20),
                Container(
                  width: ScreenSize.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.newspaper),
                    SizedBox(width: 8,),
                    Text("Notes",style: TextStyle(fontSize: 30 , fontFamily: "SpaceGrotesk",fontWeight: FontWeight.bold))
                  ],),
                ),
                SizedBox(height: 20,),
                StreamBuilder(
                        stream:  FirebaseFirestore.instance
                            .collection('users/${currUID}/Notes').orderBy('timestamp')
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if(streamSnapshot.connectionState == ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }else{
                          if(streamSnapshot.data!.docs.length == 0){
                            return Expanded(child: Text("No notes created yet.",style: TextStyle(fontSize: 20 , fontFamily: "SpaceGrotesk",fontWeight: FontWeight.bold)));
                          }else{
                          return Expanded(
                              
                            
                              child : 
                                GridView.count(crossAxisCount: 2,
                                
                                
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                physics: AlwaysScrollableScrollPhysics(),
                
                                children :
                              
                              List.generate(streamSnapshot.data!.docs.length, (index){
                                
                                
                                    return GestureDetector(
                                  onTap: (){
                                    
                      
                                    Navigator.of(context).push(CupertinoPageRoute(builder: (context){
                                          return EditNotesScreen(title: streamSnapshot.data!.docs[index]['title'], body: streamSnapshot.data!.docs[index]['body'],date:streamSnapshot.data!.docs[index]['date'] , editedDate: streamSnapshot.data!.docs[index]['editedDate'] ,isPinned: false,timeStamp: streamSnapshot.data!.docs[index]['timestamp'].toString() ,);
                                    }));
                                    
                                  },
                                  
                                  child: NotesBox(title: streamSnapshot.data!.docs[index]['title'], body: streamSnapshot.data!.docs[index]['body'],));
                                
                              })
                              
                                )
                          );}}
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