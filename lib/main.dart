import 'package:flutter/material.dart';
import 'package:graduation_project/model/AppBarTitle.dart';
import 'package:graduation_project/routes/edit_article/index.dart';
import 'package:graduation_project/routes/mine/index.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/routes/login/index.dart';
import 'package:graduation_project/routes/home/index.dart';
import 'package:graduation_project/common/adaptive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AppBarTitle())],
      child: MaterialApp(
        title: 'bbs',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(23, 144, 64, 1),
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: EntryPage(),
        ),
        routes: {
          "login": (context) => LoginWidget(),
          "home": (context) => HomePage(),
          'mine': (context) => MineWidget(),
          "edit_article": (context) => EditArticelState(),
        },
      ),
    );
  }
}

class EntryPage extends StatefulWidget {
  EntryPage({Key key}) : super(key: key);
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  int _currentIndex = 0;
  final List<Widget> pages = [
    HomePage(),
    MineWidget(),
  ];

  final List<String> titles = ['首页', '我'];

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我'),
    )
  ];

  void _changePage(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeFit.init(context, width: 750, height: 1624);
    return Consumer<AppBarTitle>(
      builder: (context, AppBarTitle appBarTitle, child) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              child: Text("${appBarTitle.title}"),
              alignment: Alignment.center,
            ),
          ),
          body: pages[_currentIndex],
          bottomNavigationBar: child,
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            backgroundColor: Color.fromRGBO(23, 144, 64, 1),
            onPressed: () {
              Navigator.of(context).pushNamed('edit_article');
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
      child: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _currentIndex,
        onTap: (index) {
          Provider.of<AppBarTitle>(context, listen: false)
              .setTitle(titles[index]);
          _changePage(index);
        },
      ),
    );
  }
}
