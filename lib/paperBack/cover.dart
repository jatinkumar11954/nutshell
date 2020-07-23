import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nutshell/model/userdetails.dart';
import 'package:nutshell/paperBack/topic.dart';
import 'package:provider/provider.dart';

class Cover extends StatelessWidget {
      final CarouselController _controller = CarouselController();

  int _current;
  @override
  Widget build(BuildContext context) {
    _current = Provider.of<UserDetails>(context).currentIndex;
    final topic = Provider.of<UserDetails>(context).topicL;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
                topic[Provider.of<UserDetails>(context).topicIndex]
                    .key
                    .split("??")[1],
                style: TextStyle(color: Colors.black)),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Topic()))),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: DropdownButton<String>(
                  icon: Icon(Icons.more_vert),
                  // value: "a",
                  items: topic.map((v) {
                    return new DropdownMenuItem<String>(
                      value: v.key.split('??')[1],
                      child: new Text(v.key.split('??')[1]),
                    );
                  }).toList(),
                  onChanged: (value) => Provider.of<UserDetails>(context)
                      .topicTap(topic
                          .indexWhere((e) => e.key.split("??")[1] == value)),
                ),
              )
              // ),
            ]),
        body: Consumer<UserDetails>(builder: (context, ind, _) {
          return Stack(
            children: <Widget>[
              CarouselSlider(
                                  carouselController: _controller,

                options: CarouselOptions(
                  carouselController: _controller,
                  enableInfiniteScroll: false,
                  height: MediaQuery.of(context).size.height * 0.9,
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
                    return Column(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              c
                                  .split(RegExp(r'(%2F)..*(%2F)'))[1]
                                  .split("?")[0]
                                  .split("-")[1]
                                  .replaceAll(RegExp(r"%20"), " "),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: CachedNetworkImage(
                                imageUrl: c,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                              )),
                        ),
                      ],
                    );
                  });
                }).toList(),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        print("back");
                        _controller.previousPage(
                          duration: Duration(milliseconds:300 ),
                          // curve: Curves.easeIn
                        );
                      })),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () => _controller.nextPage(
                      
                          duration: Duration(milliseconds:300 ),
                          // curve: Curves.easeIn
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20, top: 5),
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
