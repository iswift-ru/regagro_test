import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:regagrotest/models/users_model.dart';
import 'package:regagrotest/ui/find_page.dart';
import 'package:regagrotest/ui/list_page.dart';

final myControllerId = TextEditingController();
final _formKey = GlobalKey<FormState>();
//final globalKey = GlobalKey<ScaffoldState>();
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 30),
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    autofocus: false,
                    style:
                        TextStyle(height: 1, fontSize: 50, color: Colors.green),
                    cursorWidth: 60,
                    cursorColor: Colors.amber,
                    cursorRadius: Radius.circular(25),
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.search,
                          size: 100,
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
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Вы указали несуществующий ID'),
                              backgroundColor: Colors.red));
                          myControllerId.clear();
                        } else {
                          id = myControllerId.text;
                          print('ID $id');
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Форма успешно заполнена'),
                              backgroundColor: Colors.green));

//                          myControllerId.clear();
                        }
                        print('NumberID ${numberId.runtimeType}');
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
                            print('Передаём на второй экран Id $id');
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
