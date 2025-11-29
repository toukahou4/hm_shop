import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  
  final List<CategoryItem> categoryList; // 分类列表
  HmCategory({Key? key, required this.categoryList}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    // return ListView();
    // 返回一个横向滚动的组件--必须得设高度
    return SizedBox(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (context, index) {
          // 从分类列表中获取数据
          final CategoryItem categoryItem = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            width: 80.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 232, 234),
              borderRadius: BorderRadius.circular(40.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(categoryItem.picture, width: 40, height: 40),
                Text(categoryItem.name, style: TextStyle(color: Colors.black),),
              ],
            ),
          );
        },
      ),
    );

  }
}