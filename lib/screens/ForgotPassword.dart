import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'package:jot_genius/utilities/firestoreCRUD.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? result;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    ScreenSize().init(context: context);
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
              height: ScreenSize.screenHeight,
              width: ScreenSize.screenWidth,
              child: Column(
                children: [
                  
                  Container(
                  height: ScreenSize.screenHeight*0.3,
                  width: ScreenSize.screenWidth,
                  decoration: BoxDecoration(color: Color(0xFFf7ecdf),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                        width: ScreenSize.screenWidth*0.5,
                        height: ScreenSize.screenHeight*0.1,
                        child: Image.asset("assets/images/notes_logo.png")),
                          Column(children: [
                                Text("Jot Genius",style: TextStyle(fontSize: 30,fontFamily: "SpaceGrotesk"),),
                                Text("From Ideas to Infinity: Your Digital Notebook",style: TextStyle(fontSize: 20 , fontFamily: "SpaceGrotesk"),),
                          ],)
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: ScreenSize.screenHeight*0.25,
                    width: ScreenSize.screenWidth,
                    
                    // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Enter the email with which your account is connected ",textAlign: TextAlign.justify,style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.bold)),
                          TextField(
                            controller: emailController,
                              decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                            ),
                          ),
                          Center(
                          child: SizedBox(
                            width: ScreenSize.screenWidth*0.5,
                            height: ScreenSize.screenHeight*0.06,
                            child: TextButton(onPressed: () {
                                               
                                forgotPw(email: emailController.text, context: context);

                                
                                Navigator.pop(context);
                                displaySuccess(context, "An email has been sent to you. Please follow the instructions in the email to change your password");
                                                
                            }, child: Text("Retrieve Account",style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.bold)),style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                fontSize: 20
                              ),
                              primary: Colors.black,
                              backgroundColor: Color(0xFFf7ecdf),
                              elevation: 10,
                              shape: ContinuousRectangleBorder(
                              )
                            ),),
                          ),
                        ),
                          
                          
                          
                          
                          
                        ],
                      ),
                    ),
                  ),
                )
                ],
              ),
        ),
      ),
    ));
  }
}