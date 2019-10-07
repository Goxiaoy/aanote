import 'package:aanote/generated/i18n.dart';
import 'package:aanote/model/user.dart';
import 'package:aanote/repositpory/user_repository.dart';
import 'package:aanote/view_model/app_model.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  String userName = null;

  final Duration duration = Duration(milliseconds: 2500);

  bool _canType = false;

  String _displayText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initial data here to prevent side-effect of changing language
    _displayText = S.current.tell_name;
    _delayCanType();
  }

  Future _delayCanType() async {
    await Future.delayed(duration);
    //
    if (mounted) {
      setState(() {
        _canType = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appModel = Provider.of<AppModel>(context);
    return Scaffold(
        backgroundColor: const Color(0xff758a99),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 250.0,
                child: TyperAnimatedTextKit(
                  text: [_displayText],
                  textStyle: TextStyle(
                    fontSize: 30.0,
                  ),
                  duration: duration,
                  textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.center,
                  isRepeatingAnimation: false, // or Alignment.topLeft
                ),
              ),
              if (_canType)
                TextField(
                  autofocus: true,
                  onSubmitted: (value) async {
                    var ret = await _submit(value);
                    if (ret) {
                      appModel.loadHasMe();
                    }
                  },
                )
            ],
          ),
        ));
  }

  Future<bool> _submit(String value) async {
    if (value == null || value.isEmpty) {
      return false;
    }
    await UserRepository().add(User(name: value, isMe: true));
    return true;
  }
}
