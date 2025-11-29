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

  CarouselSliderController _controller = CarouselSliderController(); // 控制轮播图跳转的控制器
  int _currentIndex = 0; // 当前轮播图索引
  // 返回轮播图插件
  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    // 返回轮播图插件
    // 根据数据渲染的不同的轮播选项
    return CarouselSlider(
      carouselController: _controller, // 绑定controller对象
      items: List.generate(widget.bannerList.length, 
                          (index) => Image.network(
                                                    widget.bannerList[index].imgUrl, 
                                                    fit: BoxFit.cover,
                                                    width: screenWidth,)), 
      options: CarouselOptions(viewportFraction: 1.0,
                                height: 300.0, 
                                autoPlay: true,
                                // autoPlayInterval: Duration(seconds: 5), // 自动播放时间间隔
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                }, // 监听轮播图切换事件
                                ),
    );
  }

  // 返回搜索框插件
  Widget _getSearch() {
    return Positioned(
      top: 10.0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 114, 91, 91).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Row(
            children: [
              SizedBox(width: 10.0,),
              Icon(Icons.search, color: Colors.white,),
              SizedBox(width: 10.0,),
              Text('搜索', style: TextStyle(color: Colors.white, fontSize: 16.0),),
            ],
          ),
        ),
      ),
    );
  }

  // 返回指示灯导航部件
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10.0,
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 主轴居中
          children: List.generate(widget.bannerList.length, (index) => GestureDetector(
            onTap: () => _controller.animateToPage(index),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300), // 动画时间
              height: 6.0,
              width: index == _currentIndex ? 40.0 : 20.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(index == widget.bannerList.indexOf(widget.bannerList.first) ? 0.9 : 0.4),
                color: index == _currentIndex ? Colors.white : Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          )),
        )
        ));
  }

  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(
      children: [_getSlider(), _getSearch(), _getDots()],
    );
    // return Container(
    //    height: 300.0,
    //    color: Colors.blue,
    //    alignment: Alignment.center,
    //    child: Text('轮播图', style: TextStyle(color: Colors.white, fontSize: 20.0),),
    // );
  }
}