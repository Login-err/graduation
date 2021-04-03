import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:graduation_project/components/lineLinear.dart';
import 'package:graduation_project/components/panel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graduation_project/util/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecodePage extends StatefulWidget {
  RecodePage({Key key}) : super(key: key);

  @override
  _RecodePageState createState() => _RecodePageState();
}

class _RecodePageState extends State<RecodePage> {
  int doneTotal = 0;
  int unDoneTotal = 0;
  _getUid() async {
    SharedPreferences.getInstance();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('uid');
  }

  List<charts.Series<LinearSales, int>> seriesList;
  List<charts.Series<dynamic, DateTime>> _createSampleData;
  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }

    _getUid().then((uid) {
      Http().getTodo(uid, 1).then((res) {
        Http().getTodo(uid, 0).then((value) {
          if (res == null || value == null) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
            return;
          }
          if (res?.data?.list != null && value?.data?.list != null) {
            final panel = [
              new LinearSales(0, res.data.list.length),
              new LinearSales(1, value.data.list.length),
            ];

            setState(() {
              doneTotal = res.data.list.length;
              unDoneTotal = value.data.list.length;
              seriesList = [
                new charts.Series<LinearSales, int>(
                  id: 'Sales',
                  domainFn: (LinearSales sales, _) => sales.year,
                  measureFn: (LinearSales sales, _) => sales.sales,
                  data: panel,
                )
              ];
            });
          }
        });
      });
      Http().getListByDay(uid).then((res) {
        if (res == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
          return;
        }
        if (res.data.list.length > 0) {
          final linear = res.data.list
              .map((item) =>
                  TimeSeriesSales(DateTime.parse(item.timer), item.count))
              .toList();
          setState(() {
            _createSampleData = [
              charts.Series<TimeSeriesSales, DateTime>(
                id: 'Sales',
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (TimeSeriesSales sales, _) => sales.time,
                measureFn: (TimeSeriesSales sales, _) => sales.sales,
                data: linear,
              ),
            ];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      // 设计尺寸
      designSize: Size(750, 1624),
      allowFontScaling: false,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Todo数据',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            seriesList == null
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                    ),
                    height: 200,
                    child: SimplePieChart(
                      seriesList,
                    ),
                  ),
            _createSampleData == null
                ? Container()
                : Expanded(
                    child: Container(
                      color: Colors.green[200],
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: SimpleTimeSeriesChart(_createSampleData),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
