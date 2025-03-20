import 'package:flutter/material.dart';
import 'package:second_flutter_app/widgets/drawer.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vertical Layout")),
      drawer: MyDrawer(),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Image.asset(
                    "assets/images/wp6910874-jf-17-wallpapers.jpg",
                    height: 200,
                  ),
                  SizedBox(height: 20,),
                  Text("Food Paradise", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Image.asset("assets/images/wp8371852-minimal-code-wallpapers.jpg", height: 200),
                  SizedBox(height: 20,),
                  Text(
                    "Nature Beauty",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Image.asset("assets/images/wp13586229-2560x1440-dark-wallpapers.jpg", height: 200),
                  SizedBox(height: 20,),
                  Text("City Lights", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Image.network("https://images.unsplash.com/photo-1738996674608-3d2d9d8450a0?q=80&w=1631&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", height: 200),
                  SizedBox(height: 20,),
                  Text("Mountain View", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Image.network("https://plus.unsplash.com/premium_photo-1675847898176-824143229880?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", height: 200),
                  SizedBox(height: 20,),
                  Text("Ocean Breeze", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Image.network("https://plus.unsplash.com/premium_photo-1674583794429-4de817e07f3d?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", height: 200),
                  SizedBox(height: 20,),
                  Text("Desert Safari", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ],
      ),
      // To make the list horizontally scrollable, replace ListView with the following:
      // body: ListView(
      //   scrollDirection: Axis.horizontal,
      //   padding: EdgeInsets.all(20),
      //   children: [
      //     // Add your Container and Card widgets here
      //   ],
      // ),
    );
  }
}
