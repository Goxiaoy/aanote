import 'package:aanote/model/activity.dart';
import 'package:aanote/model/activity_note.dart';
import 'package:flutter/material.dart';

class ActivityDetailPage extends StatefulWidget{

  final Activity activity;

  const ActivityDetailPage({this.activity}):assert(activity!=null);



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

///activity detail page
class _ActivityDetailPageState extends State<ActivityDetailPage>{

  Activity get activity=>widget.activity;

  ///activity notes
  List<ActivityNote> activityNotes;

  ///current page Index
  int _currentPageIndex=0;

  String _searchFilter;

  ///per page count
  static const int _perPageCount=20;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}