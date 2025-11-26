import 'package:flutter/material.dart';

class HmMoreList extends StatefulWidget {
  HmMoreList({Key? key}) : super(key: key);

  @override
  _HmMoreListState createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    // 必须是Sliver家族的组件
    return SliverGrid.builder(
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 网格是两列
        crossAxisCount: 2,
        // 主轴间距
        mainAxisSpacing: 10.0,
        // 交叉轴间距
        crossAxisSpacing: 10.0,
        // childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text('更多推荐$index', style: TextStyle(color: Colors.white),),
        );
      },
    );
  }
}