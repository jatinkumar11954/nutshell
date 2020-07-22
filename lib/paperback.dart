import './paperBack/topic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nutshell/bottomNav.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutshell/model/userdetails.dart';
import 'package:provider/provider.dart';

class Paperbacks extends StatefulWidget {
  @override
  _PaperbacksState createState() => _PaperbacksState();
}

class _PaperbacksState extends State<Paperbacks> {
  @override
  // void initState() {
  //   super.initState();
  //   // getPaperBack();
  // }

  // getPaperBack() {}
  // Future<List<DocumentSnapshot>> getName() async {
  //   final db = Firestore.instance;
  //   QuerySnapshot qs;
  //   qs = await Firestore.instance.collection("$grpName").getDocuments();
  //   print("doc");
  //   List<DocumentSnapshot> d = qs.documents;

  //   return d;
  // }

  // List<String> books = ["assets/images/INTRO1.svg"];
  int count;
  List<DocumentSnapshot> paper = List<DocumentSnapshot>();
  @override
  Widget build(BuildContext context) {
    count = Provider.of<UserDetails>(context).noOfPaper;

    // paper = Provider.of<UserDetails>(context).qs.documents.sublist(0, 1);
    paper.addAll(Provider.of<UserDetails>(context).qs.documents.sublist(0,count));
    // print(count);

    ///create book grid tiles
    final widget = CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: false,
        autoPlay: false,
        pauseAutoPlayOnTouch: true,
        height: MediaQuery.of(context).size.height / 2,
      ),
      items: paper.map((back) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: GestureDetector(
                    child: CachedNetworkImage(imageUrl: back.data["img"]),
                    onTap: () {
                      Provider.of<UserDetails>(context, listen: false)
                          .onPaperTap(back);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Topic(),
                          ));
                      print("this is pdf ");
                    }));
          },
        );
      }).toList(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: bottomBar(context, 0),
      // bottomNavigationBar: BottomBar(),

      // bottomNavigationBar: PersistentNavBar(),
      body: Container(
        // body: _loading ? Center(child: CircularProgressIndicator(),):
        // PDFViewer(
        //   document: _doc,

        // ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget,
          ),
        ),
      ),
    );
  }
}
