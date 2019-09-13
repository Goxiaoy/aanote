import 'package:aanote/model/activity_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class ActivityNoteCard extends StatefulWidget{

  ActivityNote activityNote;

  ActivityNoteCard(this.activityNote);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityNoteCardState(activityNote: activityNote);
  }

}

class _ActivityNoteCardState extends State<ActivityNoteCard>{
  ActivityNote activityNote;

  _ActivityNoteCardState({@required this.activityNote});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Icon(Icons.category),
            Container(
              height: 20,
              child: VerticalDivider(
                width: 20,
                color: Colors.black,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //display name, participation count,total cost,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(activityNote.name??"Empty Name"),
                    Text(activityNote.from.length.toString()+"=>"+activityNote.to.length.toString()),
                    Text(activityNote.totalCost.toString())
                  ],
                ),
                //time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Time :"+ DateFormat('HH:mm').format(activityNote.time)),
                    if(activityNote.items.length>0) Text("Items :"+activityNote.items.length.toString())
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

