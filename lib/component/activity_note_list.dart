import 'package:aanote/component/activity_note_card.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/model/activity_note.dart';
import 'package:aanote/repositpory/activity_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queries/queries.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  _ActivityNoteListSate(this.activityId);

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onRefresh() async{
    // monitor network fetch
    var newData=await ActivityRepository().getNotesGroupedByDate(activityId: activityId,pageIndex: currentIndex);
    groupedNotes.addAll(newData.items);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    var newData=await ActivityRepository().getNotesGroupedByDate(activityId: activityId,pageIndex: currentIndex);
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    groupedNotes.addAll(newData.items);
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
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
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  Text("pull up load");
          }
          else if(mode==LoadStatus.loading){
            body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = Text("release to load more");
          }
          else{
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder: (c, i) => _buildItem(context, groupedNotes[i]),
        itemCount: groupedNotes.length,
      ),
    );
  }

}

