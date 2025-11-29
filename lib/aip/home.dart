// 封装一个api 目的时返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  // 发送get请求
   return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List)
      .map((item) => BannerItem.fromJson(item as Map<String, dynamic>))
      .toList();

}