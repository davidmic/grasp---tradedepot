import 'package:flutter/material.dart';
import 'package:grasp/views/myprofile.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int selectedIndex = 0;

  List<Widget> pages = [MyProfile(), Text('No Notification')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
         onTap: (val) {
          setState(() {
            selectedIndex = val;
          });
         },
         selectedItemColor: Color(0xff62D9A2),
         items: [
           BottomNavigationBarItem(
             icon: Icon(Icons.person_outline),
             title: Text("Account"),
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.mail_outline),
             title: Text("Notification"),
           ),
         ],
      ),
    );
  }
}
