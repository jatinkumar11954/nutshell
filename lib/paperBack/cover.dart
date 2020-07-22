import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nutshell/model/userdetails.dart';
import 'package:provider/provider.dart';

class Cover extends StatelessWidget {
  List<dynamic> cover;
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    cover = Provider.of<UserDetails>(context).coverList;
    print(Provider.of<UserDetails>(context).topicL.length);
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, actions: <Widget>[
          // IconButton(
          //     icon: Icon(Icons.more_vert),
          //     onPressed: () =>
          DropdownButton<String>(
            icon: Icon(Icons.more_vert),
            // value: "a",
            items: Provider.of<UserDetails>(context).topicL.map((v) {
              return new DropdownMenuItem<String>(
                value: v.key.split('??')[1],
                child: new Text(v.key.split('??')[1]),
              );
            }).toList(),
            onChanged: (value) => print(value),
// onTap: () => Provider.of<UserDetails>(context,listen: false).getCover(),
          )
          // ),
        ]),
        body: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (i, r) {
                _current = i;
              },
              autoPlay: false,
              pauseAutoPlayOnTouch: true,
              // height: MediaQuery.of(context).size.height / 2,
            ),
            items: cover.map((back) {
              return Builder(builder: (BuildContext context) {
                return Container(
                    child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: back,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: cover.map((url) {
                              int index = cover.indexOf(url);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Colors.blue
                                      : Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                              );
                            }).toList(),
                          ),
                          // Positioned(
                          //   bottom: 0.0,
                          //   left: 0.0,
                          //   right: 0.0,
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       gradient: LinearGradient(
                          //         colors: [
                          //           Color.fromARGB(200, 0, 0, 0),
                          //           Color.fromARGB(0, 0, 0, 0)
                          //         ],
                          //         begin: Alignment.bottomCenter,
                          //         end: Alignment.topCenter,
                          //       ),
                          //     ),
                          //     padding: EdgeInsets.symmetric(
                          //         vertical: 10.0, horizontal: 20.0),
                          //     child: Text(
                          //       'No.  image',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20.0,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )),
                ));
              });
            }).toList()));
  }
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 margin: EdgeInsets.symmetric(horizontal: 10.0),
//                 // decoration: BoxDecoration(color: Colors.grey[300]),
//                 child: GestureDetector(
//                     child: CachedNetworkImage(imageUrl: back,fit: BoxFit.cover,
//                     height:MediaQuery.of(context).size.height ,),
//                     onTap: () {
//                       // Provider.of<UserDetails>(context, listen: false)
//                       //     .onPaperTap(back);
//                       // Navigator.pushReplacement(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //       builder: (context) => Topic(),
//                       //     ));
//                       print("this is pdf ");
//                     }));
//           },
//         );
//       }).toList(),
//     )
// ,
//     );

}
