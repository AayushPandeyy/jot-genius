

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'package:jot_genius/screens/ForgotPassword.dart';
import 'package:jot_genius/screens/HomePage.dart';
import 'package:jot_genius/screens/RegisterPage.dart';
import 'package:jot_genius/widgets/displayAlertBox.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  

  String? errorMessage ;
  bool? isLoading;
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    

    
    ScreenSize().init(context: context);
    return  SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenSize.screenHeight*0.95,
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
              Expanded(
                child: Container(
                  height: ScreenSize.screenHeight*0.65,
                  width: ScreenSize.screenWidth,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login To Your Account",textAlign: TextAlign.justify,style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.bold)),
                        TextField(
                          controller: emailController,
                            decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                            decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                          ),
                        ),
                        GestureDetector(onTap: (){
                          Navigator.of(context).push(CupertinoPageRoute(builder: ((context) => ForgotPasswordScreen())));
                        },
                          child: Text("Forgot Password ?",style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.bold))),
                        Center(
                          child: SizedBox(
                            width: ScreenSize.screenWidth*0.4,
                            height: ScreenSize.screenHeight*0.06,
                            child: TextButton(onPressed: () async{
                                          setState(() {
                                            isLoading = true;
                                          });
                                                try {
                                                await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).whenComplete((){
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                });
                                                isLoading! ? displayLoading(context):
                                                
                                                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=> HomeScreen()));
                                                  
                                                 print("signed in");
                                                }on FirebaseAuthException catch (e) {

                                                if(e.code == "invalid-email"){
                                                displayAlert(context , "The email is invalid.");
                                                
                                                
                                                }else if((e.code == "invalid-password")){
                                                    displayAlert(context , "The password is invalid.");
                                                    
                                                }else if(e.code == "INVALID_LOGIN_CREDENTIALS"){
                                                      displayAlert(context , "The email or password is invalid.");
                                                }else if(e.code == "ERROR_USER_NOT_FOUND"){
                                                  displayAlert(context , "The User is not found");
                                                }else if(e.code=="too-many-requests"){
                                                  displayAlert(context , "Too Many Requests. Please try again later.");
                                                }
                                                else {
                                                  displayAlert(context , e.code!);
                                                }

                                                }
                                                  
                                                        
                                                        


                                                
                                                
                                                
                            }, child: Text("Login",style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.bold)),style: TextButton.styleFrom(
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
                        Center(
                          child: Container(
                            width: ScreenSize.screenWidth*0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                              width: ScreenSize.screenWidth*0.15,
                              height: ScreenSize.screenHeight*0.06,
                              child: TextButton(onPressed: (){
                                                  
                              }, child: Image.network(
                                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                                          fit:BoxFit.cover
                                      ),
                                    style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                  fontSize: 20
                                ),
                                primary: Colors.red,
                                backgroundColor: Colors.black,
                                elevation: 10,
                                shape: CircleBorder(
                                )
                              ),),
                            ),
                            SizedBox(
                              width: ScreenSize.screenWidth*0.15,
                              height: ScreenSize.screenHeight*0.06,
                              child: TextButton(onPressed: (){
                                                  
                              }, child: Icon(Icons.facebook),style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                  fontSize: 20
                                ),
                                primary: Colors.blue,
                                backgroundColor: Colors.black,
                                elevation: 10,
                                shape: CircleBorder(
                                )
                              ),),
                            ),
                              ],
                            ),
                          ),
                        ),
                        Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dont have an Account? ",style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.normal,fontSize: 13)),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>const RegisterScreen()));
                              },
                              child: Container(child: Text("Sign Up Now ",style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.bold,fontSize: 13)))),
                          ],
                        )),
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