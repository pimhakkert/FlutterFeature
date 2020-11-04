import 'dart:convert';

import 'package:FlutterFeature/kat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  //Not important for cats
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opdracht 1: JSON/API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Opdracht 1: JSON/API'),
    );
  }
}

//Not important for cats
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Kat> _katten = List<Kat>();

  //Get the JSON and create new katten from that data. Return the list of katten
  //Future is like a Javascript Promise
  Future<List<Kat>> getKatten() async {

    //Define URL and wait for a response
    var url = 'http://hers.hosts1.ma-cloud.nl/catabase/getcats.php';
    var response = await http.get(url);

    //Make empty list of Katten
    var katten = List<Kat>();

    //If reponse all good start looping through JSON
    if(response.statusCode == 200) {
      var kattenJson = json.decode(response.body);
      for(var katJson in kattenJson['cats']) {
        //Make a new Kat for each item in the cats array
        katten.add(Kat.fromJson(katJson));
      }
    }

    return katten;
  }

  @override
  void initState() {
    //Put the katten into the app
    getKatten().then((value) {
      setState(() {
        _katten.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //Make list of cats
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Text('Naam: ' + _katten[index].name),
                Text('Soort: ' + _katten[index].breed),
                Image(image: NetworkImage(_katten[index].imgUrl))
              ]
            )
          );
        },
        itemCount: _katten.length,
      )
    );
  }
}
