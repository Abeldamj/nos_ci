import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'main.dart';
class DetailCitation extends StatefulWidget {
  String id;
  DetailCitation({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailCitation> createState() => _DetailCitationState();
}

class _DetailCitationState extends State<DetailCitation> {
  final dio = Dio();
  var jsonInfo;
  @override
  void initState() {
    getCitationInfo(widget.id);
  }

  getCitationInfo(String id) async {
    var response = await dio.get('https://api.quotable.io/quotes/${id}');
    print("33333333333333333333333333333333333333333333 ${response}");

    if (response.statusCode == 200) {
      setState(() {
        jsonInfo = response.data;
      });
    } else {
      print(response.statusCode);
    }
  }

  static const routeName = '/citationInfo';

  Container citationSection () {
    return Container(
        child: Padding(
          padding: EdgeInsets.all(32),
          child:jsonInfo == null ? null :  Text(
            jsonInfo['content'],
            softWrap: true,
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: jsonInfo == null ? null :  Text(jsonInfo['author']),
      ),
      body: citationSection (),
    );
  }
}