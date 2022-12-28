// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:bookstore/src/screens/save_page.dart';
import 'package:flutter/material.dart';

import '../data/library.dart';
import '../routing.dart';
import '../widgets/author_list.dart';

class AuthorsScreen extends StatelessWidget {
  final String title = 'Authors';

  const AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
        RouteStateScope.of(context).go('/save');
      },),
      body: AuthorList(
        authors: libraryInstance.allAuthors,
        onTap: (author) {
          RouteStateScope.of(context).go('/author/${author.id}');
        },
      ),
    );
  }
}
