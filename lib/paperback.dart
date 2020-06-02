import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class Paperbacks extends StatefulWidget {
  @override
  _PaperbacksState createState() => _PaperbacksState();
}

class _PaperbacksState extends State<Paperbacks> {
  PDFDocument _doc;
  bool _loading=false;
  @override
  void initState() {
    super.initState();
    // _initPDF();
  }

  _initPDF() async {
    Book book;
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromAsset(book.pdf);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    createTile(Book book) => Hero(
          tag: book.title,
          child: GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                child: 
                Scaffold(
                body: 
                _loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PDFViewer(
                        document: _doc,
                      ),
              ),);
              // return Container(
              //   color: Colors.amber,
              // );
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0)
                    ],
                    image: DecorationImage(
                      image: AssetImage(book.image),
                      fit: BoxFit.fill,
                    )),
                // elevation: 15.0,
                // shadowColor: Colors.yellow.shade900,

                // child: Image(
                //   image: AssetImage(book.image),
                //   fit: BoxFit.fill,
                // ),
              ),
            ),
          ),
        );

    ///create book grid tiles
    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: books.map((book) => createTile(book)).toList(),
          ),
        )
      ],
    );
    return Container(
      // body: _loading ? Center(child: CircularProgressIndicator(),):
      // PDFViewer(
      //   document: _doc,

      // ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: grid,
      ),
    );
  }
}

class Book {
  String title, image, pdf;

  Book(this.title, this.image, this.pdf);
}

final List<Book> books = [
  Book('Nutshell November-December 2019', 'assets/book/nov.png',
      'assets/book/nov.pdf'),
  Book('Nutshell January-February 2020', 'assets/book/jan.png',
      'assets/book/jan.pdf'),
  // Book('Coming Soon', 'assets/images/book/soon.png',
  //     'assets/book/soon.pdf'),
];
