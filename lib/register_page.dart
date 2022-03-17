import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedemo/listproduct_screen.dart';
import 'package:firebasedemo/login_page.dart';
import 'package:flutter/material.dart';

class register_page extends StatefulWidget {
  @override
  _register_pageState createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  final edtName = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  String name = '';
  String email = '';
  String password = '';
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Widget texField(
        {String values,
        String hinttext,
        Icon icon,
        TextEditingController controller}) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.09),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                values = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: icon),
                hintText: hinttext,
                hintStyle: TextStyle(
                    fontSize: 18, color: Colors.lightBlueAccent, height: 1.5),
              ),
              style: TextStyle(
                  fontSize: 18, color: Colors.lightBlueAccent, height: 1.5),
              textInputAction: TextInputAction.next,
            ),
          ),
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top:60),

          alignment: Alignment.center,
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/shop.png',
                    width: size.width * 0.8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: TextField(
                          controller: edtName,
                          onChanged: (value) {
                            this.name = value;
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
                            hintText: 'Nhập tên',
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.lightBlueAccent,
                                height: 1.5),
                          ),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                              height: 1.5),
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
                          controller: edtEmail,
                          onChanged: (value) {
                            this.email = value;
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
                            hintText: 'Nhập email',
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.lightBlueAccent,
                                height: 1.5),
                          ),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                              height: 1.5),
                          keyboardType: TextInputType.name,
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
                          onChanged: (value) {
                            this.password = value;
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
                            hintText: 'Nhập mật khẩu ',
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.lightBlueAccent,
                                height: 1.5),
                          ),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                              height: 1.5),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                          validation();
                          Register(name, email, password);
                        });
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => login_page()),
                  );
                },
                child: Container(
                  child: Text(
                    'Đã có tài khoản',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.5),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.white))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validation() {
    if (edtName.text == '') {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text('Tên không được bỏ trống'),
      ));
      return;
    }
    if (edtEmail.text == '') {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text('email không được bỏ trống'),
      ));
      return;
    }
    if (edtPassword.text == '') {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text('Mật khẩu không được bỏ trống'),
      ));
      return;
    }
    if (edtPassword.text.length < 6) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text('Mật khẩu từ 6 kí tự'),
      ));
      return;
    }
  }

  Future<void> Register(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        final FirebaseDatabase database = FirebaseDatabase.instance;
        DatabaseReference reference = database.reference();
        reference.child('Users').child(value.user.uid).set(<String, String>{
          'uid': value.user.uid,
          'name': name,
          'email': email,
          'password': password
        });
        edtName.text = '';
        edtPassword.text = '';
        edtEmail.text = '';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => login_page()),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text('Email đã tồn tại'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
