import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutshell/bottomNav.dart';
import 'package:nutshell/paperback.dart';
import 'package:provider/provider.dart';

import 'cover.dart';
import '../model/userdetails.dart';

class Topic extends StatelessWidget {
  DocumentSnapshot topic;
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(milliseconds: 800));
    topic = Provider.of<UserDetails>(context).doc;
    // d = Provider.of<UserDetails>(context).docSnap;
    //  final varia= topic.data["Topic"].toList();
    List<MapEntry<String, dynamic>> topicList =
        topic.data["Topic"].entries.toList();
//  req=   ob.entries.toList();
//     print(req[0].key);
    topicList.sort((a, b) => int.parse(a.key.split("??")[0])
        .compareTo(int.parse(b.key.split("??")[0])));
    // print(topicL);
    // List<dynamic> topicList = topic.data["Topic"].keys.toList();
    // topicList.sort((a, b) =>
    //     int.parse(a.split("??")[0]).compareTo(int.parse(b.split("??")[0])));
    // print(topicList);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              // print(grpName);
              return BottomBar();
            },
          ));
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: Column(
            children: <Widget>[
              Consumer<UserDetails>(builder: (context, obj, _) {
                return Expanded(
                  child: GridView.builder(
                    // reverse: true,
                    scrollDirection: Axis.vertical,
                    // shrinkWrap: true,
                    itemCount: topicList.length,
                    itemBuilder: (context, i) {    return Center(
                        child: GestureDetector(
                          onTap: () {
                            // print(topicList[i].value);
                            Provider.of<UserDetails>(context, listen: false)
                                .sortedList(topicList);
                            // print(topicList[i].value[0]);
                            Provider.of<UserDetails>(context, listen: false)
                                .topicTap(i);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                // print(grpName);
                                return Cover();
                              },
                            ));
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 4.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: GridTile(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            topicList[i].key.split('??')[2],
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (_, str, dynamic) =>
                                            Center(
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                  child: Text(
                                      // "Topic " +
                                      //     topic.data["Topic"].keys
                                      //         .toList()[i]
                                      //         .split('??')[0] +
                                      //     "\n" +
                                      topicList[i].key.split('??')[1],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
    // return
  }
}
