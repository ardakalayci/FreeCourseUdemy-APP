import 'package:carousel_slider/carousel_slider.dart';
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
  double devwidth;
  double devheight;

  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('courses');
    devwidth = MediaQuery.of(context).size.width;
    devheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ücretsiz İndirimli Udemy Kursları"),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: CarouselSlider(

                      items: imageSliders(snapshot),

                        options: CarouselOptions(
                          height: devheight/5,
                          viewportFraction: 0.7,
                          initialPage: 0,

                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                  Container(
                    height: devheight / 2,
                    child: new ListView(
                      shrinkWrap: true,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: new ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CourseDetail(document);
                              }));
                            },
                            leading: Image.network(document.data()['image']),
                            title: new Text(document.data()['name']),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text(document.data()['instructor']),
                                  ClipOval(
                                    child: document.data()["discount"]!=null ?Container(
                                      padding: EdgeInsets.all(5),
                                      color:Colors.red,child: Row(
                                      children: [
                                        Icon(Icons.trending_down,color: Colors.white,),
                                        Text(document.data()["discount"]??"",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                      ],
                                    ),):Container()),


                                ]),


                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> initMethod() async {
    firestore = FirebaseFirestore.instance;
  }

  imageSliders(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs.map((DocumentSnapshot document) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[

                Image.network(document.data()["image"], fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      document.data()["name"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color:Colors.white,child: Row(
                          children: [
                            Icon(Icons.trending_down,color: Colors.red,),
                            Text(document.data()["discount"]??"",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                          ],
                        ),)),
                ),
              ],
            )
        ),
      ),
    )).toList();



  }

}
