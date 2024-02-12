import 'package:flutter/material.dart';
import 'package:flutter_application_to_do_list/home_to_do.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   
    super.initState();
     gotoLogin();
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home:  Scaffold(
       body: Center(
         child: ListView(
            children:<Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 300, 0, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 17.0,
                          )
                        ]
                      ),
                      child: const Image(
                        image: AssetImage('assets/logo.webp'),
                        height: 200,
                         )
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                     child: CircularProgressIndicator(backgroundColor: Colors.red,) 
                     
                  ),

                ],
              ),
             
            ]
          ),
       ),
     
    ));
    
   
  }
   void gotoLogin() {
    Future.delayed(const Duration(seconds: 3), () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ToDOHome()));
      
    });
  }
}