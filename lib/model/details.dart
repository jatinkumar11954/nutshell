import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserDetails extends ChangeNotifier {
  String _grpName;
  int _noOfPaper;
  int get noOfPaper => _noOfPaper;
  int _topicIndex;
  QuerySnapshot _q;
  // String _newsGrpName;
  // String get newsGrpName => _newsGrpName;

  // DocumentSnapshot get docSnap => _docSnap;

  String get grpName => _grpName;
  // String get folder => _folder;
  // String get topicKey => _topicKey;

  void onGrpTap(String grp) {
    _grpName = grp;
    // notifyListeners();
  }

  int get topicIndex => _topicIndex;
  setnoOfPaper(String plan) {
    switch (plan) {
      case "f":
        _noOfPaper = 2;
        break;
      case "b":
        _noOfPaper = 3;
        break;
      case "s":
        _noOfPaper = 5;
        break;
      case "p":
        _noOfPaper = 8;
        break;
    }
    notifyListeners();
  }

  DocumentSnapshot _doc;
  DocumentSnapshot get doc => _doc;
  QuerySnapshot get qs => _q;
  void setQuery(QuerySnapshot q) {
    _q = q;
    notifyListeners();
  }

  void onPaperTap(DocumentSnapshot d) {
    _doc = d;
    notifyListeners();
  }

  void topicTap(int ind) {
    // _folder = fol;
    // _topicKey = tkey;
    _topicIndex = ind;
    notifyListeners();
  }
}
