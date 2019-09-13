import 'package:aanote/component/activity_note_card.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/model/activity_note.dart';
import 'package:aanote/repositpory/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:loadany/loadany.dart';
import 'package:queries/queries.dart';

class ActivityNoteList extends StatefulWidget{

  final Activity activity;

  const ActivityNoteList({Key key, this.activity}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityNoteListSate(activity.id);
  }
}

class _ActivityNoteListSate extends State<ActivityNoteList>{

  final String activityId;

  final int pageCount=7;

  List<IGrouping<DateTime,ActivityNote>> groupedNotes=new List();

  int currentIndex=0;

  bool isLoading=false;

  LoadStatus status = LoadStatus.normal;

  _ActivityNoteListSate(this.activityId);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /// Load More Get Data
  Future<void> getLoadMore() async {
    setState(() {
      status = LoadStatus.loading;
    });
    var newData=await ActivityRepository().getNotesGroupedByDate(activityId: activityId,pageIndex: currentIndex);
    if(newData.totalCount<=currentIndex*pageCount){
      status = LoadStatus.completed;
    }else{
      groupedNotes.addAll(newData.items);
      status=LoadStatus.normal;
    }
    setState(() {});
  }

  Widget _buildItem(BuildContext context, IGrouping<DateTime, ActivityNote> groupedNote) {
    var ret=<Widget>[
      Text(groupedNote.key.toIso8601String()),
    ];
    var noteCards=groupedNote.select((p)=>ActivityNoteCard(p)).toList();
    for (var value in noteCards) {
      ret.add(value);
    }
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ret,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadAny(
      onLoadMore: getLoadMore,
      status: status,
      footerHeight: 40,
      endLoadMore: true,
      bottomTriggerDistance: 200,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return _buildItem(context, groupedNotes[index]);
              },
              childCount: groupedNotes.length,
            ),
          )
        ],
      ),
    );
  }
}

