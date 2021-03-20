import 'package:flutter/material.dart';
import 'package:graduation_project/model/AppBarTitle.dart';
import 'package:graduation_project/routes/addTodo/index.dart';
import 'package:graduation_project/routes/detail/index.dart';
import 'package:graduation_project/routes/history/index.dart';
import 'package:graduation_project/routes/record/index.dart';
import 'package:graduation_project/routes/register/main.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/routes/login/index.dart';
import 'package:graduation_project/routes/home/index.dart';
import 'package:graduation_project/common/adaptive.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: '做了么',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(23, 144, 64, 1),
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: EntryPage(),
        ),
        routes: {
          "/register": (context) => RegisterPage(),
          "/login": (context) => LoginWidget(),
          "/home": (context) => HomePage(),
          '/recode': (context) => RecodePage(),
          "/add_todo": (context) => AddTodo(),
          '/joinHistory': (context) => HistoryList(),
          '/todoDetail': (context) => TodoDetail(),
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
    RecodePage(),
  ];

  final List<String> titles = ['首页', '我'];

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('记录'),
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
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    handleToken();
  }

  void handleToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token == '') {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeFit.init(context, width: 750, height: 1624);
    return Consumer<AppBarTitle>(
      builder: (context, AppBarTitle appBarTitle, child) {
        return Scaffold(
          body: pages[_currentIndex],
          bottomNavigationBar: child,
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color.fromRGBO(23, 144, 64, 1),
            onPressed: () {
              Navigator.of(context).pushNamed('/add_todo');
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
