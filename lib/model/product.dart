import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class product{
  String productId,productName,productImage,productContent;

  product({this.productId,this.productName, this.productImage, this.productContent});
  // String get pid => productId;
  // String get pname => productName;
  // String get pimage => productImage;
  // String get picontent => productContent;

  product.fromSnapShot(DataSnapshot snapshot){
    productId = snapshot.key;
    productName = snapshot.value['productName'];
    productImage = snapshot.value['productImage'];
    productContent = snapshot.value['productContent'];
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'name: $productName, email: $productContent';
  }

}