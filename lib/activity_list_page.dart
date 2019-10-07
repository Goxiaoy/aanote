import 'package:aanote/model/activity.dart';
import 'package:flutter/material.dart';

class ActivityListPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState()=>_ActivityListPageState();
}

///activity detail page
class _ActivityListPageState extends State<ActivityListPage>{

  ///current page Index
  int _currentPageIndex=0;

  ///per page count
  static const int _perPageCount=20;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}