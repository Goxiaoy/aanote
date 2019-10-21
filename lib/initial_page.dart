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

  final Duration duration = Duration(milliseconds: 2000);

  bool _canType = false;

  String _currentTyped;

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
        resizeToAvoidBottomPadding: false,
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TyperAnimatedTextKit(
                        text: [_displayText],
                        textStyle: TextStyle(
                          fontSize: 30.0,
                        ),
                        duration: duration,
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.center,
                        isRepeatingAnimation: false, // or Alignment.topLeft
                      ),
                      if (_canType)
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                onChanged: (value) {
                                  setState(() {
                                    _currentTyped = value;
                                  });
                                },
                                onSubmitted: (value) async {
                                  await _submit(appModel);
                                },
                              ),
                            ),
                            if (_currentTyped != null &&
                                _currentTyped.isNotEmpty)
                              IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () async {
                                  await _submit(appModel);
                                },
                              )
                          ],
                        ),
                    ],
                  ),
                )))));
  }

  Future<bool> _submit(AppModel appModel) async {
    var ret = false;
    var value = _currentTyped;
    if (value == null || value.isEmpty) {
    } else {
      await UserRepository().add(User(name: value, isMe: true));
      ret = true;
    }
    if (ret) {
      await appModel.loadHasMe();
    }
    return ret;
  }
}
