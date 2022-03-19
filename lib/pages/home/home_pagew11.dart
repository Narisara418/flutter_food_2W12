import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_2/models/api_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _foodData = [];

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
    String status = json['status'];
    String? message = json['message'];
    List<dynamic> data = json['data'];

    setState(() {
      for(var element in data){
        _foodData.add(element);
      }
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
            foodItem['image'],
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
                        foodItem['name'],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${foodItem['price'].toString()} บาท',
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

