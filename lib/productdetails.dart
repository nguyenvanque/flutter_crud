import 'package:firebasedemo/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class productdetails extends StatefulWidget {
  product producs;

  productdetails({this.producs});

  @override
  _productdetailsState createState() => _productdetailsState(producs);
}

class _productdetailsState extends State<productdetails>
     {

  bool isLiked = false;

  product producs;

  _productdetailsState(this.producs);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
    Widget _appBar() {
      return Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
              size: 15,
            ),
            Container(

              child: InkWell(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    print(isLiked);
                  });
                },
                child: isLiked == true
                    ? Icon(
                  Icons.favorite,
                  color: Colors.red,

                )
                    : Icon(Icons.favorite_border),
              ),
            ),
          ],
        ),
      );
    }
    Widget _productImage() {
      return Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: size.width,
              height: 330,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
                  image: new NetworkImage(
                    producs.productImage,
                  ),
                ),),
            ),
          ],
        ),
      );
    }
    Widget _availableSize() {
      return Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Available Size",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text("39"),
                ),
                Container(

                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text("40"),
                ),
                Container(

                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text("41"),
                ),
                Container(

                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text("42"),
                ),
              ],
            )
          ],
        ),
      );
    }
    Widget _colorWidget(Color color, {bool isSelected = false}) {
      return CircleAvatar(
        radius: 12,
        backgroundColor: color.withAlpha(150),
        child: isSelected
            ? Icon(
          Icons.check_circle,
          color: color,
          size: 18,
        )
            : CircleAvatar(radius: 7, backgroundColor: color),
      );
    }
    Widget _availableColor() {
      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Color",style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _colorWidget(Colors.orange, isSelected: true),
                SizedBox(
                  width: 30,
                ),
                _colorWidget(Colors.black87),
                SizedBox(
                  width: 30,
                ),
                _colorWidget(Colors.blue),
                SizedBox(
                  width: 30,
                ),
                _colorWidget(Colors.red),
                SizedBox(
                  width: 30,
                ),
                _colorWidget(Colors.blue),
              ],
            )
          ],
        ),
      );
    }
    Widget _description() {
      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Mô tả sản phẩm",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
            ),
            SizedBox(height: 20),
            Text(producs.productContent,)
          ],
        ),
      );
    }
    Widget _detailWidget() {
      return DraggableScrollableSheet(
        maxChildSize: .9,
        initialChildSize: .55,
        minChildSize: .55,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 5),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text( producs.productName,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(

                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isLiked = !isLiked;
                                        print(isLiked);
                                      });
                                    },
                                    child: isLiked == true
                                        ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,

                                    )
                                        : Icon(Icons.favorite_border),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "\$ ",
                                  style: TextStyle(fontSize: 18,color: Colors.yellow,fontWeight: FontWeight.bold),
                                ),

                                Text(
                                   "240",
                                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 17),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 17),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 17),
                                Icon(Icons.star_border, size: 17),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  _availableSize(),
                  _availableColor(),
                  SizedBox(
                    height: 10,
                  ),
                  _description(),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  _productImage()
                ],
              ),
              _detailWidget(),
              Positioned(
                bottom: 17,
               left: 30,
               child:Container(
                 width: size.width*0.7,
                 height: 45,
                 decoration: BoxDecoration(
                   color: Colors.lightBlue,
                   borderRadius: BorderRadius.circular(10),

                   ),
                 child: FlatButton(
                   onPressed: (){
                   },

                   child: Text('Xem giỏ hàng',style: TextStyle(color:Colors.white),),
                 ),

               ),
              )
            ]),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add_shopping_cart,
            color: Theme
                .of(context)
                .floatingActionButtonTheme
                .backgroundColor),
      ),
    );
  }
}
