import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasedemo/addproduct.dart';
import 'package:firebasedemo/list_user.dart';
import 'package:firebasedemo/login_page.dart';
import 'package:firebasedemo/model/product.dart';
import 'package:firebasedemo/productdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class listproduct_screen extends StatefulWidget {
  @override
  _listproduct_screenState createState() => _listproduct_screenState();
}

class _listproduct_screenState extends State<listproduct_screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<product> listProduct = new List();
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference fb;


  String imageUpdate;
  String image;
  final edtName = TextEditingController();
  final edtImage = TextEditingController();
  final edtContent = TextEditingController();

  @override
  void initState() {
    super.initState();
    fb = database.reference().child('Products');
    fb.onChildAdded.listen((_onAddData));
    fb.onChildChanged.listen((_onChanged));


  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,

        body: Container(
          child: Column(
            children: [
              _appBar(),
              _title(),
              _search(),
              listProduct.length <= 0
                  ? Text('No data')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: listProduct.length,
                      itemBuilder: (context, index) {
                        return _item(
                            listProduct[index].productName,
                            listProduct[index].productImage,
                            listProduct[index].productContent,
                            listProduct[index].productId,
                            index);
                      },
                    ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addproduct()),
            );
          },
        ),
      ),
    );
  }

  Widget _item(
      String name, String image, String content, String key, int position) {
    return Container(
      height: 80,
      child: InkWell(
        onLongPress: () => _showDialog(context, position),
        onTap: () => showBottomSheetDialog(context, position),
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.2,
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.9),
                                      BlendMode.dstATop),
                                  image: new NetworkImage(
                                    image,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListTile(
                    title: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Text(
                          '\$ ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '200',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => productdetails(
                                producs: listProduct[position],
                              )),
                        );
                        // p: listProduct[position],
                      },
                      child: Container(
                        width: 40,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey[150],
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Chi tiết',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
  Widget _appBar() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () => _showDialogLogout(context),
            child: RotatedBox(
              quarterTurns: 4,
              child: Icon(Icons.sort, color: Colors.black54),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListUser()),
                  );
                },
                   child:Image.asset("assets/images/user.png") ,
                 )
            ),
          )
        ],
      ),
    );
  }
  Widget _title() {
    return Container(
        margin: EdgeInsets.only(left: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Our \nShopping',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ));
  }
  Widget _search() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(
                        left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
              onTap: () => _signOut(),
              child: Icon(Icons.filter_list, color: Colors.black54))
        ],
      ),
    );
  }
  void _onAddData(Event event) {
    setState(() {
      listProduct.add(new product.fromSnapShot(event.snapshot));
    });
  }
  void _onChanged(Event event) {
    var oldData = listProduct.singleWhere((entry) {
      return entry.productId == event.snapshot.key;
    });
    setState(() {
      listProduct[listProduct.indexOf(oldData)] =
          new product.fromSnapShot(event.snapshot);
    });
  }
  void showBottomSheetDialog(BuildContext context, int position) {
    String id = listProduct[position].productId;
    String name = listProduct[position].productName;
    image = listProduct[position].productImage;
    String content = listProduct[position].productContent;
    edtName.text = name;
    edtContent.text = content;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 30),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                       uploadImage();
                      },
                      child: Container(
                        child: image != null
                            ? Image.network(
                                image,
                                width: 100,
                                height: 100,
                              )
                            : AssetImage(
                                'assets/images/shop.png',
                              ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
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
                              edtName.text = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Icon(
                                  Icons.business_center,
                                  size: 28,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                              hintText: 'Tên sản phẩm',
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.lightBlueAccent,
                                  height: 1.5),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.lightBlueAccent,
                                height: 1.5),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextField(
                            controller: edtContent,
                            onChanged: (value) {
                              edtContent.text = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Icon(
                                  Icons.info,
                                  size: 28,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                              hintText: 'Nhập mô tả sản phẩm',
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.lightBlueAccent,
                                  height: 1.5),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.lightBlueAccent,
                                height: 1.5),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                'Cập nhật',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.lightBlueAccent,
                              onPressed: () {
                                setState(() {
                                  print('id' + id);
                                  HashMap<String, String> map = new HashMap();
                                  map.putIfAbsent('productId', () => id);
                                  map.putIfAbsent(
                                      'productName', () => edtName.text);
                                  map.putIfAbsent(
                                      'productImage', () => image);
                                  map.putIfAbsent(
                                      'productContent', () => edtContent.text);
                                  fb.child(id).update(map);
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                'Hủy',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

            ),
          );
        });
  }
  void _deleteProduct(
      BuildContext context, product products, int position) async {
    String url = products.productImage;
    deleteFileFRomFirebase(url);
    await fb.child(products.productId).remove().then((_) {
      setState(() {
        listProduct.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }
  Future<void> deleteFileFRomFirebase(String url) async {
    try {
      String filePath = url.replaceAll(
          new RegExp(
              'https://firebasestorage.googleapis.com/v0/b/fir-flutter-314b0.appspot.com/o/'),
          '');
      print('1' + filePath);
      filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');
      print('2' + filePath);
      filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');
      print('3' + filePath);
      await FirebaseStorage.instance
          .ref()
          .child(filePath)
          .delete()
          .catchError((val) {
        print('[Error]' + val);
      }).then((_) {
        print('[Sucess] Image deleted');
      });
    } catch (error) {
      print(error);
    }
  }
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    _showDialogLogout(context);
  }

  void _showDialogLogout(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cảnh báo'),
          content: Text('Bạn có muốn đăng xuất không ?'),
          actions: <Widget>[
            FlatButton(child: Text('Có'), onPressed: () => _signOut()),
            new FlatButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cảnh báo'),
          content: Text(
              'Bạn có muốn xóa ${listProduct[position].productName} không ?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Có'),
              onPressed: () => _deleteProduct(
                context,
                listProduct[position],
                position,
              ),
            ),
            new FlatButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile images;
    String timestime = DateTime.now().millisecondsSinceEpoch.toString();
    //Select Image
    images = await _picker.getImage(source: ImageSource.gallery);
    var file = File(images.path);
    if (images != null) {
      var snapshot = await _storage
          .ref()
          .child('ProductImages/image' + timestime)
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        image = downloadUrl;
      });
    }
  }
}
