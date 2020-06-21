import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:regagrotest/models/users_model.dart';
import 'package:regagrotest/res/app_strings.dart';
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
    var response = await http.get(AppString.userListUrl);
    if (response.statusCode == 200) {
      var decJson = jsonDecode(response.body)['data'];

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
                    leading: CachedNetworkImage(
                      imageUrl: snap.data[ind].avatar,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
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
