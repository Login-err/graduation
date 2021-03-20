import 'package:flutter/material.dart';
import 'package:graduation_project/model/getTodoRsp.dart';
import 'package:graduation_project/routes/detail/index.dart';
import 'package:graduation_project/util/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryList extends StatefulWidget {
  HistoryList({Key key}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  Future _loaded;
  List<TodoInfo> list = [];
  _getUid() async {
    SharedPreferences.getInstance();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('uid');
  }

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    _getUid().then((uid) {
      _loaded = Future.value(uid);
      // 查看已完成的
      Http().getTodo(uid, 1).then(
        (res) {
          if (res == null) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
            return;
          }
          if (res?.data?.list != null) {
            setState(() {
              list = res.data.list ?? [];
            });
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            '已完成待办',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _loaded,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return list.length == 0
                ? Container(
                    child: Center(
                      child: Text(
                        '暂无数据',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return TodoDetail(todoId: list[index].uid);
                          }));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          color: Colors.grey[100],
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[index].title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(list[index].time),
                                  )
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }
          return Container();
        },
      ),
    );
  }
}
