import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/aip/user.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进行渲染4个导航
  // 一般应用程序的导航是固定的
  final List<Map<String, dynamic>> _tabList = [
    {
      'text': '首页',
      'icon': 'lib/assets/ic_public_home_normal.png', // 正常状态的图标
      'active_icon': 'lib/assets/ic_public_home_active.png', // 激活状态的图标
    },
    {
      'text': '分类',
      'icon': 'lib/assets/ic_public_pro_normal.png', // 正常状态的图标
      'active_icon': 'lib/assets/ic_public_pro_active.png', // 激活状态的图标
    },
    {
      'text': '购物车',
      'icon': 'lib/assets/ic_public_cart_normal.png', // 正常状态的图标
      'active_icon': 'lib/assets/ic_public_cart_active.png', // 激活状态的图标
    },
    {
      'text': '我的',
      'icon': 'lib/assets/ic_public_my_normal.png', // 正常状态的图标
      'active_icon': 'lib/assets/ic_public_my_active.png', // 激活状态的图标
    },
  ];

  int _currentIndex = 0;

  // 返回底部渲染的四个分类
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]['icon'], width: 30, height: 30),
        activeIcon: Image.asset(_tabList[index]['active_icon'], width: 30, height: 30),
        label: _tabList[index]['text'],
      );
    }).toList();
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  void initState() {
    super.initState();
    // 初始化token
    _initUser();
  }

  // 初始化用户信息
  final UserController _userController = Get.put(UserController());
  Future<void> _initUser() async {
    await tokenManager.init(); // 初始化token
    // 从本地存储中获取token
    if(tokenManager.getToken().isNotEmpty) {
      // 如果token不为空，添加到请求头
      // request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${tokenManager.getToken()}';
      _userController.updateUserInfo(await getUserInfoApi());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //避开安全区组件
      body: SafeArea(
         child: IndexedStack(
          index: _currentIndex,
          children: _getChildren(),
         ),
       ),
       bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget()),
    );
  }
}