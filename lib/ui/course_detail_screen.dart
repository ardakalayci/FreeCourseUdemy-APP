import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDetail extends StatefulWidget {
  DocumentSnapshot data;
  CourseDetail(this.data);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot data=widget.data;

    return Scaffold(
      appBar: AppBar(),
      body:ListView(
        children: [
          Image.network(data.data()["image"]),
          Text(data
          .data()["link"]),
          Text(data.data()["description"]),

        ],
      ),
    );
  }
}
