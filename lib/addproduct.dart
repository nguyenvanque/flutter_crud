
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

File image;
File imageURI;
String filename;
class addproduct extends StatefulWidget {
  @override
  _addproductState createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  String productName='';
  String productImage='';
  String productContent='';
  final edtProductName=TextEditingController();
  final edtProductImage=TextEditingController();
  final edtProductContent=TextEditingController();

  String productImages;
  String imageUrl;
  String productUid;
  // pickerCam() async {
  //   File img = (await ImagePicker.pickImage(source: ImageSource.camera)) as File;
  //   // File img = await ImagePicker.pickImage(source: ImageSource.camera);
  //   if (img != null) {
  //     image = img;
  //     setState(() {});
  //   }
  // }

  // pickerGallery() async {
  //   File img = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   // File img = await ImagePicker.pickImage(source: ImageSource.camera);
  //   if (img != null) {
  //     image = img;
  //     setState(() {});
  //   }
  // }
  // Future getImageFromCamera() async {
  //
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //
  //   setState(() {
  //     imageURI = image;
  //   });
  //
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('App '),
        backgroundColor: Colors.green,
      ),
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              children: [
                Text('THÊM SẢN PHẨM', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,),),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                   setState(() {
                     print('pick');
                  // pickerGallery();
                     uploadImage();
                   });
                  },

                  child: imageUrl!=null?FadeInImage.assetNetwork(
                    placeholder: 'assets/images/login_bg.png',
                    image: imageUrl,width: 150,height: 170,):Image.asset('assets/images/login_bg.png',width: 150,height: 170,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.grey[500].withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextField(
                        controller: edtProductName,
                        onChanged: (value){
                          this.productName=value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.info,
                              size: 28,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Nhập tên sản phẩm',
                          hintStyle: TextStyle(
                              fontSize: 18, color: Colors.grey, height: 1.5),
                        ),
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey, height: 1.5),
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.grey[500].withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextField(
                        controller: edtProductContent,
                        obscureText: true,
                        onChanged: (value){
                          this.productContent=value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.import_contacts,
                              size: 28,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Nhập mô tả sản phẩm',
                          hintStyle: TextStyle(
                              fontSize: 18, color: Colors.grey, height: 1.5),
                        ),
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey, height: 1.5),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: FlatButton(
                        onPressed: (){
                            pushProductData(productName,productImage,productContent);
                        },
                          child: Text('Thêm sản phẩm',style: TextStyle(color: Colors.white),)),

                    ),
                    SizedBox(width: 20),
                  ],
                )

              ],
            ),
          )
      ),
    );
  }

  void pushProductData(String productName, String productImage, String productContent) {
    String productId=DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseDatabase database=FirebaseDatabase.instance;
    DatabaseReference reference = database.reference();
    reference.child('Products').child(productId).set(<String, String>{
      'productId': productId,
      'productName': productName,
      'productImage': imageUrl,
      'productContent': productContent
    });
    edtProductName.text='';
    edtProductContent.text='';
    imageUrl=null;
  }
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    String timestime=DateTime.now().millisecondsSinceEpoch.toString();
    //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('ProductImages/image'+timestime)
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;

        });
    }

  }
}
