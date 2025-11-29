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

// 获取分类列表
Future<List<CategoryItem>> getCategoryListApi() async {
  // 发送get请求
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List)
      .map((item) => CategoryItem.fromJson(item as Map<String, dynamic>))
      .toList();
}

// 获取特惠推荐
Future<SpecialOffersResult> getSpecialOffersApi() async {
  // 发送get请求
  return SpecialOffersResult.fromJson(await dioRequest.get(HttpConstants.PRODUCT_LIST));
}

// 获取爆款推荐
Future<SpecialOffersResult> getInVogueApi() async {
  // 发送get请求
  return SpecialOffersResult.fromJson(await dioRequest.get(HttpConstants.IN_VOGUE_LIST));
}

// 获取一站式推荐
Future<SpecialOffersResult> getOneStopApi() async {
  // 发送get请求
  return SpecialOffersResult.fromJson(await dioRequest.get(HttpConstants.ONE_STOP_LIST));
}