import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_2/models/covid_model.dart';
import 'package:flutter_food_2/models/food_item.dart';
import 'package:flutter_food_2/models/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var l1;
  var l2;
  var l3;
  var res;
  var foods = [
    new FoodItem(
      id: 1,
      name: 'ข้าวไข่เจียว',
      price: 25,
      image: "https://cpsu-test-api.herokuapp.com/images/kao_kai_jeaw.jpg",
    ),
    FoodItem(
      id: 2,
      name: 'ข้าวหมูแดง',
      price: 30,
      image: "https://cpsu-test-api.herokuapp.com/images/kao_moo_dang.jpg",
    ),
    FoodItem(
      id: 3,
      name: 'ข้าวมันไก่',
      price: 30,
      image: "https://cpsu-test-api.herokuapp.com/images/kao_mun_kai.jpg",
    ),
    FoodItem(
      id: 4,
      name: 'ข้าวหน้าเป็ด',
      price: 40,
      image: "https://cpsu-test-api.herokuapp.com/images/kao_na_ped.jpg",
    ),
    FoodItem(
      id: 5,
      name: 'ข้าวผัด',
      price: 30,
      image: "https://cpsu-test-api.herokuapp.com/images/kao_pad.jpg",
    ),
    FoodItem(
      id: 6,
      name: 'ผัดซีอิ๋ว',
      price: 30,
      image: "https://cpsu-test-api.herokuapp.com/images/pad_sie_eew.jpg",
    ),
    FoodItem(
      id: 7,
      name: 'ผัดไทย',
      price: 35,
      image: "https://cpsu-test-api.herokuapp.com/images/pad_thai.jpg",
    ),
    FoodItem(
      id: 8,
      name: 'ราดหน้า',
      price: 30,
      image: "https://cpsu-test-api.herokuapp.com/images/rad_na.jpg",
    ),
    FoodItem(
      id: 9,
      name: 'ส้มตำไก่ย่าง',
      price: 80,
      image: "https://cpsu-test-api.herokuapp.com/images/som_tum_kai_yang.jpg",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FLUTTER FOODS')),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: foods.length,
          itemBuilder: (BuildContext context, int index) {
            var foodItem = foods[index];

            return Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(8.0),
              elevation: 5.0,
              shadowColor: Colors.black.withOpacity(0.2),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: foodItem.image,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  foodItem.name,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  '${foodItem.price.toString()} บาท',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

    );
  }


  Future<void> _handleClick() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
    // Future<http.Response> result = http.get(url);
    var result = await http.get(url);
    res = result.body;
    print(result.body);

    var json = jsonDecode(result.body);
    String status = json['status'];
    String? message = json['message'];
    List<dynamic> data = json['data'];
    l1 = status;
    l2 = message;
    l3 = data.length;

    print('status: $status, Message: $message, Number of food: ${data.length}');

    // result.then((response) => null);
    /*result.then((response) {
    print(response.body);
  });*/
  }
}


/*class MyCard extends StatefulWidget {
  final FoodItem food;

  const MyCard({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  late bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(),
      ),
    );
  }
}*/
