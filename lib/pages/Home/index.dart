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
      HmMoreList(recommendList: _recommendList) // 无限滚动列表
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
    // 初始化推荐列表
    _getRecommendList();
    // 注册事件
    _registerEvent();
    // WidgetsBinding.instance.addPostFrameCallback((_) { print(_scrollController.hasClients); });
  }

  void _registerEvent() {
    // 监听滚动事件
    _scrollController.addListener(() {

      // 监听滚动到底部的事件
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent -50) {
        // 加载更多数据
        _getRecommendList();
      }
    });
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

  // 获取推荐列表
  List<GoodDetailItem> _recommendList = [];
  // 页码
  int _page = 1;
  // 同时只能加载一个请求
  bool _isLoading = false; // 当前正在加载状态
  bool _hasMore = true; // 是否还有更多数据
  // 获取推荐列表
  void _getRecommendList() async {
    // 当已经有请求正在加载 或者已经没有下一页了 就放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true; // 占在加载状态
    int requestLimit = _page * 10;
    await getRecommendListApi({
      // "pageNum": 1,
      // "pageSize": 10,
      "limit": requestLimit,
    }).then((value) {
      setState(() {
        // 当请求的数量大于等于10时 说明还有下一页数据
        if (value.length >= 10) {
          _page++;
        }
        _recommendList.addAll(value);
        _isLoading = false;
        _hasMore = value.length == 10;
      });
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView( 
      controller: _scrollController, // 绑定控制器
      slivers: _getScrollChildern(),
    ); // sliver家族的内容
  }
}
