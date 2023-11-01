
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'package:jot_genius/screens/LogInPage.dart';
import 'package:jot_genius/utilities/firestoreCRUD.dart';
import 'package:jot_genius/widgets/displayAlertBox.dart';
import 'package:uuid/uuid.dart';


class RegisterScreen extends StatefulWidget {
  
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String? errorMessage ;
  bool isLogin = false;
  
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isTaken = false;
  List allData = [];

    

  checkAvailabiltiy(String text) async{
      var resultList = await FirebaseFirestore.instance.collection('users').where('username',isEqualTo: text).get();
      var data = resultList.docs;
      
      setState(() {
        allData = data;  
      });
      if(allData.length > 0){
        setState(() {
          isTaken = true;
        });
      }else{
        setState(() {
          isTaken = false;
        });
      }
      }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // searchList();
    super.didChangeDependencies();
  }

    
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  var uid = Uuid().v1();



    
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context: context);
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
        child: Container(
          height: ScreenSize.screenHeight*0.95,
          width: ScreenSize.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  height: ScreenSize.screenHeight*0.55,
                  width: ScreenSize.screenWidth,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Register Your Account",textAlign: TextAlign.justify,style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: emailController,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(),
                            border: UnderlineInputBorder(),
                            hintText: 'Email',
                          ),
                          
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextFormField(

                                textCapitalization: TextCapitalization.none,

                                onChanged: (value) {
                                  
                                  checkAvailabiltiy(value);
                                },
                                
                                
                                controller: userNameController,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(),
                                  
                                  border: UnderlineInputBorder(),
                                  
                                  hintText: 'Username',
                                ),
                                
                              ),
                            ),
                            isTaken == true || userNameController.text == '' ? 
                            Icon(Icons.close,size:40,color: Colors.red,) : Icon(Icons.done,size : 40 , color: Colors.green,)
                          ],
                        ),
                        TextFormField(
                          controller: phoneController,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(),
                            border: UnderlineInputBorder(),
                            hintText: 'Phone Number',
                          ),
                          
                        ),
                        
                        TextFormField(
                          
                          obscureText: true,
                          controller: passwordController,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(),
                            border: UnderlineInputBorder(),
                            hintText: 'Password',
                            
                          ),
                          
                        ),
                        Center(
                          child: SizedBox(
                            width: ScreenSize.screenWidth*0.4,
                            height: ScreenSize.screenHeight*0.06,
                            child: TextButton(onPressed: ()  async{
                                                  
                                                checkAvailabiltiy(userNameController.text.toString());
                                                if(isTaken == false){
                                                try {
                                                

                                                await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text,);
                                                await FirebaseAuth.instance.signOut();
                                                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const LogInScreen()));
                                                add(userNameController.text, emailController.text, phoneController.text, context , uid);


                                                }on FirebaseAuthException catch (e) {

                                                  if(e.code == "email-already-in-use"){
                                                    displayAlert(context, "The email is already in use. Please use a new email");
                                                    
                                                  }else{
                                                    displayAlert(context, e.message.toString());
                                                    
                                                  }
                                                }    }else{
                                                  displayAlert(context, "The username is taken");
                                                }  
                                                        
                            }, child: Text("Sign Up",style:TextStyle(fontFamily : "SpaceGrotesk",fontWeight: FontWeight.bold)),style: TextButton.styleFrom(
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
      ),
    );
  }
}