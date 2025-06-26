import 'package:flutter/material.dart';
import 'package:rayride/nav_bar.dart'; 

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Myapp() 
    ),
  );
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("RayRide"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Welcome to RayRide!"),
      ),
      bottomNavigationBar: mainnavbar(), 
    );
  }
}
