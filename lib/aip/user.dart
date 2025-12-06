// 登录接口API

import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> loginApi(Map<String, dynamic> data) async {
    final res = await dioRequest.post(HttpConstants.LOGIN, data: data);
    return UserInfo.fromJSON(res);
}

Future<UserInfo> getUserInfoApi() async {
    final res = await dioRequest.get(HttpConstants.USER_PROFILE);
    return UserInfo.fromJSON(res);
}
