import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/list_user.dart';
import 'package:firebasedemo/listproduct_screen.dart';
import 'package:firebasedemo/register_page.dart';
import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top:60),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset('assets/images/shop.png',width: size.width*0.85,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextField(
                              controller: edtEmail,
                              onChanged: (value){
                                this.email=value;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Icon(
                                    Icons.email,
                                    size: 28,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                                hintText: 'Nhập email',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.lightBlueAccent, height: 1.5),
                              ),
                              style: TextStyle(
                                  fontSize: 16, color: Colors.lightBlueAccent, height: 1.5),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextField(
                              controller: edtPassword,
                              obscureText: true,
                              onChanged: (value){
                                this.password=value;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Icon(
                                    Icons.lock,
                                    size: 28,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                                hintText: 'Nhập mật khẩu',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.lightBlueAccent, height: 1.5),
                              ),
                              style: TextStyle(
                                  fontSize: 16, color: Colors.lightBlueAccent, height: 1.5),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.lightBlueAccent,
                        ),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                             Login(context, email, password);
                            });
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 4,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => register_page()),
                          );
                        },
                        child: Container(
                          child: Text(
                            'Tạo tài khoản mới',
                            style: TextStyle(
                                fontSize: 15,fontWeight: FontWeight.bold, color: Colors.black, height: 1.5),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1, color: Colors.white))),
                        ),
                      ),


                    ],

                  ),
                ],
              ),
            ),
          ),
        );
  }
  Future<void> Login(BuildContext context, String email,
      String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => listproduct_screen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
