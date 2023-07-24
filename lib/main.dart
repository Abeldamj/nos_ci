import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'detail.dart';

final dio = Dio();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Date de publication',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return MaterialApp(
      title: 'Flutter citations',
      theme: ThemeData(
          primarySwatch: Colors.green
      ),
      //home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var jsonList;
//   var jsonLength;
  @override
  void initState() {
    getCitations();
  }

  void getCitations() async {
    try {
      var response = await dio.get('https://api.quotable.io/quotes');
      if (response.statusCode == 200) {
        setState(() {
//           jsonLength = response.data["count"];
          jsonList = response.data['results'] as List;
        });
//         print(response);
      } else {
        print(response.statusCode);
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our citations'),
      ),
      body: ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
                child: ListTile(
                  /*leading: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        jsonList[index],
                        fit: BoxFit.fill,
                        width: 50,
                        height: 50,
                      ),
                    )*/
                    title: Text(jsonList[index]['content']),
                    subtitle: Text(jsonList[index]['author']),
                    onTap: (){
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QuoteInfoPage()),
                    );*/
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailCitation(id: jsonList[index]['_id'])
                          ));
                    }
                ));
          }),
    );
  }
}