import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'models/contacts.dart';

class MyComtacts extends StatefulWidget {
  const MyComtacts({super.key});

  @override
  State<MyComtacts> createState() => _MyComtactsState();
}

class _MyComtactsState extends State<MyComtacts> {

  List<Contact> contacts =[];

  void getDataFromDB(){
    Box box=Hive.box("contacts");
    List keys=box.keys.toList();
    List<Contact> readedContacts =[];
    for(var key in keys){
      Map valueAsMap=box.get(key);
      Contact contact=Contact.fromMap(valueAsMap);
      contact.key=key;
      readedContacts.add(contact);
    }
    setState(() {
      contacts=readedContacts;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromDB();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(itemBuilder: (context,i){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              IconButton(
                onPressed: () async{
                  Box box = Hive.box("contacts");
                  setState(() { // To change it instantly in UI
                    contacts[i].name = 'ibrahim';
                  });
                  await box.put(contacts[i].key, contacts[i].toMap()); // to save it in database
                },
                icon: Icon(Icons.update),
              ),
              Column(
                children: [
                  Text(
                    contacts[i].name.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    contacts[i].phone.toString(),
                    style: TextStyle(),
                  ),
                ],
              ),
              IconButton(
                onPressed: (){
                  Box box = Hive.box("contacts");
                  box.delete(contacts[i].key); // delete from database
                  setState(() {
                    contacts.removeAt(i); // delete from list
                  });
                },
                icon: Icon(Icons.delete),
              ),
            ],
          );
        },
            separatorBuilder: (context,i){
          return SizedBox(
            height: 15,
          );
            },
            itemCount: contacts.length),
      ),
    );
  }
}
