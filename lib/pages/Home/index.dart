import 'package:flutter/material.dart';
import 'package:hm_shop/aip/home.dart';
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
  List<BannerItem> _bannerList = [
    // BannerItem(id: "1", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"),
    // BannerItem(id: "2", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.jpg"),
    // BannerItem(id: "3", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"),
  ];

  List<CategoryItem> _categoryList = []; // 分类列表

  SpecialOffersResult _specialOffersResult = SpecialOffersResult(
    id: "",
    title: "",
    subTypes: [],
  ); // 特惠推荐

  SpecialOffersResult _inVogueResult = SpecialOffersResult(
    id: "",
    title: "",
    subTypes: [],
  ); // 爆款推荐

  SpecialOffersResult _oneStopResult = SpecialOffersResult(
    id: "",
    title: "",
    subTypes: [],
  ); // 一站式推荐

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
        child: HmCategory(categoryList: _categoryList), // 分类组件
      ),

      SliverToBoxAdapter(child: SizedBox(height: 10.0,)),
      SliverToBoxAdapter(
        child: HmSuggestion(specialOffersResult: _specialOffersResult), // 分类组件
      ),

      SliverToBoxAdapter(child: SizedBox(height: 10.0,)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"), // 分类组件
              ),
              SizedBox(width: 10.0,),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"), // 分类组件
              ),
            ],
          ), // 分类组件
        ),
      ),

      SliverToBoxAdapter(child: SizedBox(height: 10.0,)),
      HmMoreList() // 无限滚动列表
    ];
  }

  void initState() {
    super.initState();
    // 初始化banner列表
    _getBannerList();
    // 初始化分类列表
    _getCategoryList();
    // 初始化特惠推荐
    _getSpecialOffers();
    // 初始化爆款推荐
    _getInVogue();
    // 初始化一站式推荐
    _getOneStop();
  }

  // 获取轮播图列表
  void _getBannerList() async {
    await getBannerListApi().then((value) {
      setState(() {
        _bannerList.addAll(value);
      });
    });
  }

  // 获取分类列表
  void _getCategoryList() async {
    await getCategoryListApi().then((value) {
      setState(() {
        _categoryList.addAll(value);
      });
    });
  }

  // 获取特惠推荐
  void _getSpecialOffers() async {
    await getSpecialOffersApi().then((value) {
      setState(() {
        _specialOffersResult = value;
      });
    });
  }

  // 获取爆款推荐
  void _getInVogue() async {
    await getInVogueApi().then((value) {
      setState(() {
        _inVogueResult = value;
      });
    });
  }

  // 获取一站式推荐
  void _getOneStop() async {
    await getOneStopApi().then((value) {
      setState(() {
        _oneStopResult = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView( slivers: _getScrollChildern(),); // sliver家族的内容
  }
}
