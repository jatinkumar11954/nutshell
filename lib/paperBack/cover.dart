import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nutshell/model/userdetails.dart';
import 'package:provider/provider.dart';

class Cover extends StatelessWidget {
  int _current;
  @override
  Widget build(BuildContext context) {
    _current = Provider.of<UserDetails>(context).currentIndex;
    final topic = Provider.of<UserDetails>(context).topicL;
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, actions: <Widget>[
          DropdownButton<String>(
            icon: Icon(Icons.more_vert),
            // value: "a",
            items: topic.map((v) {
              return new DropdownMenuItem<String>(
                value: v.key.split('??')[1],
                child: new Text(v.key.split('??')[1]),
              );
            }).toList(),
            onChanged: (value) => Provider.of<UserDetails>(context).topicTap(
                topic.indexWhere((e) => e.key.split("??")[1] == value)),
          )
          // ),
        ]),
        body: Consumer<UserDetails>(builder: (context, ind, _) {
          return Stack(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (i, r) {
                    Provider.of<UserDetails>(context, listen: false)
                        .changeIndex(i);
                  },
                  aspectRatio: 1.2,
                  autoPlay: false,
                  pauseAutoPlayOnTouch: true,
                ),
                items: topic[ind.topicIndex].value.map<Widget>((c) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: CachedNetworkImage(imageUrl: c,
                           placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                      )),
                    );
                  });
                }).toList(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:
                        ind.topicL[ind.topicIndex].value.map<Widget>((url) {
                      int index = ind.topicL[ind.topicIndex].value.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Provider.of<UserDetails>(context).currentIndex ==
                                      index
                                  ? Colors.blue
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
