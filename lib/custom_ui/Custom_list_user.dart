import 'package:firebasedemo/model/user.dart';
import 'package:flutter/material.dart';

class CustomListUser extends StatelessWidget {
  List<user> listUser;

  CustomListUser({this.listUser});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listUser.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 3.0),
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              Divider(
                height: 1.0,
              ),
              Container(
                padding: new EdgeInsets.all(3.0),
                child: Card(
                  child: Column(
                    children: [

                         Column(
                          children: [
                            Text(
                              '${listUser[position].name}',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 21.0,
                              ),
                            ),
                            Text(
                              '${listUser[position].email}',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 21.0,
                              ),
                            )
                          ],
                        ),
                        // child: Text(
                        //   '${listUser[position].name}',
                        //   style: TextStyle(
                        //     color: Colors.blueAccent,
                        //     fontSize: 21.0,
                        //   ),
                        // ),

                    ],
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          );
        });
  }
}
