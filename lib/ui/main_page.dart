import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:regagrotest/ui/find_page.dart';
import 'package:regagrotest/ui/list_page.dart';

final myControllerId = TextEditingController();
final _formKey = GlobalKey<FormState>();

String id;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        key: globalKey,
        appBar: AppBar(
          centerTitle: false,
          leading: Image.network(
            'http://regagro.ru/images/logo2.png',
            width: double.infinity,
          ),
          title: Text('RegAgro'),
        ),
        body: Builder(builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  'http://regagro.ru/images/logo2.png',
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 50),
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    autofocus: false,
                    style:
                        TextStyle(height: 1, fontSize: 20, color: Colors.green),
                    cursorWidth: 10,
                    cursorColor: Colors.amber,
                    cursorRadius: Radius.circular(15),
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 20),
                        icon: Icon(
                          Icons.search,
                          size: 50,
                          color: Colors.green,
                        ),
                        labelText: 'Введите ID от 1 до 10',
                        labelStyle:
                            TextStyle(color: Colors.blue, letterSpacing: 0.5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2))),
                    controller: myControllerId,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Пожалуйста введите ID';
                      }
                      if (value.isNotEmpty) {
                        var numberId = int.tryParse(value);

                        if (numberId > 10 ||
                            numberId == 0 ||
                            numberId == null) {
                          return 'Вы указали неправльный ID';
                        } else {
                          id = myControllerId.text;

                          myControllerId.clear();
                        }
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Найти',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FindPage(
                                    id: id,
                                  ),
                                ));
                          }
                        });
                      },
                    ),
                    RaisedButton(
                      child: Text(
                        'List',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListPage()));
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
