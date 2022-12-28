// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:bookstore/src/db/operation.dart';
import 'package:bookstore/src/models/note.dart';
import 'package:bookstore/src/screens/save_page.dart';
import 'package:flutter/material.dart';

import '../data/library.dart';
import '../routing.dart';
import '../widgets/author_list.dart';

class AuthorsScreen extends StatelessWidget {
  final String title = 'Authors';

  const AuthorsScreen({super.key});
  @override
  Widget build (BuildContext context){



    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
        RouteStateScope.of(context).go('/save');
      },),
      appBar:
      AppBar(
        title: Text("Listado"),
      ),
      body: Container(
        child: _MyList(),),
    );
  }
}

class _MyList extends StatefulWidget {
  @override
  State<_MyList> createState() => _MyListState();
}

class _MyListState extends State<_MyList> {
  List<Note> notes = [];

  @override
  void initState(){
    _loadData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, i) => _createItem(i),
    );
  }

  _loadData() async {
    List<Note> auxNote = await Operation.notes();
    setState(() {
      notes = auxNote;
    });
  }

  _createItem(int i){
    return Dismissible(
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 5),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white,)),
      ),
      onDismissed: (direction){
        Operation.delete(notes[i]);
      },
      child: ListTile(
        title: Text(notes[i].title),

      ),
    );
  }
}
