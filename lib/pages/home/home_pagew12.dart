import 'package:flutter/material.dart';
import 'package:flutter_food_2/models/api_result.dart';
import 'package:flutter_food_2/models/food_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  List<FoodItem> _foodData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FLUTTER FOODS')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _handleClickButton,
                child: const Text('LOAD FOODS DATA'),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _foodData.length,
                  itemBuilder: (context, index) => _buildListItem(context, index),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }


  Future<void> _handleClickButton() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
    // Future<http.Response> result = http.get(url);
    var result = await http.get(url);
    // res = result.body;
    // print(result.body);

    var json = jsonDecode(result.body);
    var apiResult = ApiResult.fromJson(json);

    /*String status = json['status'];
    String? message = json['message'];
    List<dynamic> data = json['data'];*/

    setState(() {
      _foodData = apiResult.data.map<FoodItem>((item) => FoodItem.fromJson(item)).toList();

      // for(var element in apiResult.data){
      //   var foodItem = FoodItem.fromJson(element);
      //   _foodData.add(foodItem);
      // }
    });
    //print('status: $status, Message: $message, Number of food: ${data.length}');

    // result.then((response) => null);
    /*result.then((response) {
    print(response.body);
  });*/
  }

  Widget _buildListItem(BuildContext context, int index) {
    var foodItem = _foodData[index];

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            Image.network(
              foodItem.image,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          foodItem.name,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '${foodItem.price.toString()} บาท',
                          style: TextStyle(
                            fontSize: 20,
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
  }
}

