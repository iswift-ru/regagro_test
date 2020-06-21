import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:regagrotest/models/user_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:regagrotest/res/app_strings.dart';
import 'main_page.dart';

class FindPage extends StatefulWidget {
  final String id;

  FindPage({Key key, @required this.id}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  void initState() {
    super.initState();
    getDetailResults();
  }

  Future<UserDetailModel> getDetailResults() async {
    var response = await http.get(AppString.userDetailUrl);

    if (response.statusCode == 200) {
      var result = UserDetailModel.fromJson(jsonDecode(response.body));

      return result;
    } else {
      return throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Поиск по ID $id'),
        ),
        body: FutureBuilder<UserDetailModel>(
          future: getDetailResults(),
          builder: (context, snap) {
            if (snap.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Результат поиска по ID № $id',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.green,
                        letterSpacing: 0.8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CachedNetworkImage(
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      imageUrl: snap.data.data.avatar,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ID ${snap.data.data.id.toString()}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            '${snap.data.data.firstName} ${snap.data.data.lastName}',
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(snap.data.data.email, style: TextStyle(fontSize: 20)),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ));
  }
}
