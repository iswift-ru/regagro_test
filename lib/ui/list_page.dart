import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:regagrotest/models/users_model.dart';

import 'find_page.dart';
import 'main_page.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    getResults();
  }

  Future<List<Datum>> getResults() async {
    String url = 'https://reqres.in/api/users?page=1';
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decJson = jsonDecode(response.body)['data'];
      print(decJson);
      List<Datum> data = decJson.map<Datum>((f) => Datum.fromJson(f)).toList();

      return data;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: FutureBuilder(
        future: getResults(),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, ind) {
                  return ListTile(
                    title: Text(
                        '${snap.data[ind].firstName} ${snap.data[ind].lastName}'),
                    subtitle: Text(
                        '${snap.data[ind].email} \n ID ${snap.data[ind].id.toString()}'),
                    isThreeLine: true,
                    trailing: Icon(
                      Icons.input,
                      color: Colors.green,
                      size: 40,
                    ),
                    leading: Image.network(
                      snap.data[ind].avatar,
                    ),
                    onTap: () {
                      id = snap.data[ind].id.toString();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FindPage(
                              id: id,
                            ),
                          ));
                    },
                  );
                });
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
      ),
    );
  }
}
