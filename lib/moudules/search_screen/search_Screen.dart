import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Center(
          child: Text(
        'SearchScreen',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
      )),
    );
  }
}
