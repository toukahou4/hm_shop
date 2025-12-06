
import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {

    // 返回持久化对象的实例对象
    Future<SharedPreferences> _getInstance() {
      return  SharedPreferences.getInstance();
    }

  // 初始化token
  String _token = '';
  Future<void> init () async {
    // 1.获取持久化实例
    final prefs = await _getInstance();
    // 2.获取token
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 设置token
  Future<void> setToken(String val) async{
    // 1.获取持久化实例
    final prefs = await _getInstance();
    // 2.设置token
    prefs.setString(GlobalConstants.TOKEN_KEY, val); // token写入到持久化 磁盘
    _token = val;
  }

  // 获取token
  String getToken() {
    return _token;
  }

  // 移除token
  Future<void> removeToken() async {
    // 1.获取持久化实例
    final prefs = await _getInstance();
    // 2.移除token
    prefs.remove(GlobalConstants.TOKEN_KEY); // 磁盘
    _token = ''; // 内存
  }

}
final tokenManager = TokenManager();