import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled2/models/contacts.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  Contact contact=Contact();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: Text(
          "Contacts",
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                size: 30,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onSaved: (value){
                  contact.name = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter name";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Name",
                    prefixIcon: Icon(Icons.account_circle_rounded,color: Colors.white,)),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                onSaved: (value){
                  contact.phone = value;
                },
                validator: (value) {
                  if (value!.length != 11 || value!.isEmpty) {
                    return "invalid number";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone,color: Colors.white,)),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async{
                  bool valid = formKey.currentState!.validate();
                  if (valid) {
                    formKey.currentState!.save();
                    var box = Hive.box('contacts');
                    await box.add(contact.toMap());
                    formKey.currentState!.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.purple,
                      content: Text("added sucssesfully"),
                    ));
                  }
                },
                child: Container(
                  child: Center(
                      child: Text(
                    "ADD",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.white),
                  )),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
