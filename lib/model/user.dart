
import 'package:firebase_database/firebase_database.dart';

class user{
  String uid,name,email,password;

  user({this.uid,this.name, this.email, this.password});
  String get id => uid;
  String get uname => name;
  String get uemail => email;

  user.fromSnapShot(DataSnapshot snapshot){
    uid = snapshot.key;
    name = snapshot.value['name'];
    email = snapshot.value['email'];
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'name: $name, email: $email';
  }

}