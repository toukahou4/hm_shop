import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/Hmslider.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BannerItem> _bannerList = [
    BannerItem(id: "1", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"),
    BannerItem(id: "2", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.jpg"),
    BannerItem(id: "3", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"),
  ];

  // 获取滚动容器的内容
  List<Widget> _getScrollChildern() {
    return [

      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter( 
        child: HmSlider(bannerList: _bannerList), // 轮播图组件
      ),

      // 放置分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0,)),
      // SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(
        child: HmCategory(), // 分类组件
      ),

      SliverToBoxAdapter(child: SizedBox(height: 10.0,)),
      SliverToBoxAdapter(
        child: HmSuggestion(), // 分类组件
      ),

      SliverToBoxAdapter(child: SizedBox(height: 10.0,)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(), // 分类组件
              ),
              SizedBox(width: 10.0,),
              Expanded(
                child: HmHot(), // 分类组件
              ),
            ],
          ), // 分类组件
        ),
      ),

      SliverToBoxAdapter(child: SizedBox(height: 10.0,)),
      HmMoreList() // 无限滚动列表
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView( slivers: _getScrollChildern(),); // sliver家族的内容
  }
}