import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jot_genius/constants/ScreenSize.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context: context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            elevation: 5,
          child: Icon(Icons.note_add_outlined,color: Colors.black,),
          backgroundColor: const Color.fromARGB(255, 197, 153, 136),
          onPressed: () {
            
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
                        child: Text("My Notes",style: TextStyle(fontSize: 30 , fontFamily: "SpaceGrotesk",fontWeight: FontWeight.bold),),
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(Icons.search),
                  ),controller: searchController,),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}