import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetail extends StatefulWidget {
  DocumentSnapshot data;

  CourseDetail(this.data);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot data = widget.data;

    var devwidth = MediaQuery.of(context).size.width;
    var devheight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton.extended(
            onPressed: () {
              launch(data.data()["link"]);
            },
            label: Column(
              children: [
                Text(
                  "İndirimli Al",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )),
      ),
      appBar: AppBar(),
      body: Stack(children: [
        ListView(
          children: [
            Image.network(
              data.data()["image"],
              fit: BoxFit.fill,
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(data.data()["description"]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.red,

                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.fromLTRB(20,5,20,5),
                    child: Text(
                      data.data()["price"],
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
                    ))
              ],
            ),
            SizedBox(
              height: devheight/10,
            )
          ],
        ),

        Positioned(
          right: 10,
          top: 10,
          child: ClipOval(
              child: Container(
            padding: EdgeInsets.all(5),
            color: Colors.white,
            child: Row(
              children: [
                Icon(
                  Icons.trending_down,
                  color: Colors.red,
                ),
                Text(
                  data.data()["discount"] ?? "",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        )
      ]),
    );
  }
}
