import 'dart:convert';

import 'package:fashionetti/entities/Phone.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class PhonesPage extends StatefulWidget {
  @override
  _PhonesPageState createState() => _PhonesPageState();
}

class _PhonesPageState extends State<PhonesPage> {
  List<Phone> allPhones = [];

  Future<List<Phone>> _getPhoneData() async {
    var apiData = await http
        .get("https://my.api.mockaroo.com/getallphones.json?key=46f01930");
    var phoneData = json.decode(apiData.body);

    for (var i in phoneData) {
      Phone allphones = Phone(
        product_id: i['product_id'],
        phone_name: i['phone_name'],
        phone_description: i['phone_description'],
        price: i['price'],
        quantity: i['quantity'],
        image_url: i['image_url'],
      );
      allPhones.add(allphones);
    }
    return allPhones;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("The best phones on the market !"),
        ),
        body: Center(
          child: FutureBuilder(
            future: _getPhoneData(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    color: Color(0xfffF7F7F7),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return getPhoneInfo(
                            snapshot.data[index].phone_name,
                            snapshot.data[index].phone_description,
                            snapshot.data[index].price,
                            snapshot.data[index].quantity,
                            snapshot.data[index].image_url);
                      },
                    ));
              }
            },
          ),
        ));
  }

  Widget getPhoneInfo(
    String name,
    String description,
    int price,
    int quantitiy,
    String imageurl,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 250.00,
            height: 270.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              image: DecorationImage(
                image: new NetworkImage(imageurl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 100.0,
            top: 70.0,
            child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Container(
                  width: 230.0,
                  height: 200.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          child: Center(
                              child: Text(name,
                                  style: TextStyle(
                                      color: Color(0xff07128a),
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: Center(
                            child: Text(description,
                                style: TextStyle(
                                    color: Color(0xff2da9ef),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(price.toString() + " ksh",
                              style: TextStyle(
                                  color: Color(0xffff6f00), fontSize: 16.0)),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.angleRight,
                              color: Color(0xffff6f00),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
