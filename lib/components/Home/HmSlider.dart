import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;

  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {

  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    // 返回轮播图插件
    // 根据数据渲染的不同的轮播选项
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, 
                          (index) => Image.network(
                                                    widget.bannerList[index].imgUrl, 
                                                    fit: BoxFit.cover,
                                                    width: screenWidth,)), 
      options: CarouselOptions(viewportFraction: 1.0,
                                height: 300.0, 
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 5),
                                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(
      children: [_getSlider()],
    );
    // return Container(
    //    height: 300.0,
    //    color: Colors.blue,
    //    alignment: Alignment.center,
    //    child: Text('轮播图', style: TextStyle(color: Colors.white, fontSize: 20.0),),
    // );
  }
}