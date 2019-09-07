import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: new MainPageWidget());
  }
}
class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget>{
  ///current selected index
  int _currentIndex=0;

  List<_AppBarItem> _barItems;

  @override
  void initState() {
    super.initState();
    _barItems=[
      _AppBarItem("Focusing",unselectedWidget:const Icon(Icons.adjust)),
      _AppBarItem("History",unselectedWidget:const Icon(Icons.history)),
      _AppBarItem("Tools",unselectedWidget:const Icon(Icons.build))
    ];
  }

  ///build navigation bar item
  List<BottomNavigationBarItem> _buildItems(){
      var ret=List<BottomNavigationBarItem>();
      var selectedTextStyle=TextStyle(fontSize: 14.0,color: const Color(0xff1296db));
      var unselectedTextStyle=TextStyle(fontSize: 14.0,color: const Color(0xff515151));
      for (int i = 0; i < _barItems.length; i++) {
        var bar=_barItems[i];
        ret.add(BottomNavigationBarItem(
          //todo locale text
            title: Text(bar.text,style:_currentIndex==i?selectedTextStyle:unselectedTextStyle),
            icon: bar.unselectedWidget,
            activeIcon: bar.selectedWidget));
      }
      return ret;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:_barItems[_currentIndex].page,
        bottomNavigationBar: BottomNavigationBar(
          items: _buildItems(),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          iconSize: 24.0,
          onTap: setIndex,
        ),
    );
  }

  ///set current index page
  void setIndex(int index){
    setState(() {
      _currentIndex=index%_barItems.length;
    });
  }

}

///app navigation bat item
class _AppBarItem {
  String unselectedImage;
  String selectedImage;
  String text;

  Widget page;
  Widget unselectedWidget;
  Widget selectedWidget;

  _AppBarItem(this.text,{this.unselectedImage,this.selectedImage,this.selectedWidget,this.unselectedWidget}){
    if(unselectedImage!=null&&unselectedWidget==null){
      unselectedWidget=Image.asset(unselectedImage);
    }
    if(selectedWidget==null){
      selectedWidget=unselectedWidget;
    }
    if(selectedImage!=null&&selectedWidget==null){
      selectedWidget=Image.asset(selectedImage);
    }
  }


}