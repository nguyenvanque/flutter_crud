import 'dart:async';


import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedemo/addproduct.dart';
import 'package:firebasedemo/listproduct_screen.dart';
import 'package:firebasedemo/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebasedemo/model/user.dart';
import 'package:firebasedemo/custom_ui/Custom_list_user.dart';



class ListUser extends StatefulWidget {

  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {

 List<user> listUser=new List();
 final productReference = FirebaseDatabase.instance.reference().child('Users');
 StreamSubscription<Event> _onProductAddedSubscription;
 StreamSubscription<Event> _onProductChangedSubscription;
  String uemail = '';
  String uname='';
  String uid='';

 @override
 void initState() {
   super.initState();
   listUser = new List();
   _onProductAddedSubscription =
       productReference.onChildAdded.listen(_onProductAdded);
   _onProductChangedSubscription =
       productReference.onChildChanged.listen(_onProductUpdate) ;
 }

 @override
 void dispose() {
   super.dispose();
   _onProductAddedSubscription.cancel();
   _onProductChangedSubscription.cancel();
 }
  @override

  Widget build(BuildContext context) {

    getProfileUser();

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
                icon: Icon(Icons.local_airport),
                onPressed: () {
                  setState(() {
                    _signOut();
                  });
                })
          ],
          backgroundColor: Colors.black87,
        ),
        body:  SafeArea(
          // thẻ làm cho layout sẽ nằm dưới statusbar
            minimum: EdgeInsets.only(left: 20, right: 20),
            // cách bên trái mà hình 20px , cách bên phải mà hình 20px
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  // Column(
                  //   // children: listProduct()
                  //
                  // ),
                  Text(
                    'Danh sách',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  CustomListUser(listUser: listUser),
                  // gọi contrucstor của Listview
                ],
              ),
            )),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.local_mall),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => listproduct_screen()),
          );
        },
      ),


    );
  }

  getProfileUser() async {
    final userProfile = await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(FirebaseAuth.instance.currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        uname = snapshot.value['name'];
        uid = snapshot.value['uid'];
      });
    });
    return userProfile;
  }



  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => login_page()),
    );
  }
 void _onProductAdded(Event event) {
   setState(() {
     listUser.add(new user.fromSnapShot(event.snapshot));
   });
 }
 void _onProductUpdate(Event event) {
   var oldProductValue =
   listUser.singleWhere((product) => product.id == event.snapshot.key);
   setState(() {
     listUser[listUser.indexOf(oldProductValue)] =
     new user.fromSnapShot(event.snapshot);
   });
 }

}
