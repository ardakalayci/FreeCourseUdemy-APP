import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'course_detail_screen.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore;
  @override
  void initState() {
initMethod();
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('courses');

    return Scaffold(
      appBar: AppBar(),
      body: Container(child: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return SingleChildScrollView(


            child: Column(

              children: [
              Expanded(

                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Text("arda");
                  }).toList(),

                ),
              ),

              Expanded(
                child: new ListView(

                  shrinkWrap: true,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: new ListTile(
                        onTap: (){Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return CourseDetail(document);

                            }));},

                        leading: Image.network(document.data()['image']),
                        title: new Text(document.data()['name']),
                        subtitle: new Text(document.data()['instructor']),
                      ),
                    );
                  }).toList(),
                ),
              ),

            ],),
          );
        },
      ),),
    );
  }

  Future<void> initMethod() async {
    firestore = FirebaseFirestore.instance;

  }
}
