import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:untitled2/callScreen.dart';
import 'package:untitled2/myContacts.dart';

import 'addContact Screen.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox("contacts");
  runApp(Contacts());
}

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  List<Widget> currentScreen = [AddContactScreen(), MyComtacts(), CallScreen()];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        body: currentScreen[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white54,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                label: "Add contact"),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts),
                label: "Contacts"),
            BottomNavigationBarItem(icon: GestureDetector(
                onTap: (){

                },
                child: Icon(Icons.call)), label: "CallS")
          ],
        ),
      ),
    );
  }
}
