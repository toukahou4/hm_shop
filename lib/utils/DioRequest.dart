// 基于Dio进行二次封装

import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio();
  // 基础地址拦截器
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    // 拦截器
    _addInterceptor();
  }

  // 添加拦截器
  void _addInterceptor(){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 在发送请求之前做一些事情
        return handler.next(options); // 继续发送请求
      },
      onResponse: (response, handler) {
        // 在响应成功时做一些事情
        if(response.statusCode! >= 200 && response.statusCode! < 300){
          // 对响应数据进行处理
          return handler.next(response); // 继续处理响应
        }
        return handler.reject(DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: '响应状态码错误：${response.statusCode}',
        )); // 继续处理响应
      },
      onError: (error, handler) {
        // 在响应错误时做一些事情
        return handler.reject(error); // 继续处理错误
      },
    ));
  }

  // get请求
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return  _handleResponse(_dio.get(url, queryParameters: params)); 
  }
  // 近一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>; // data才是我们真实的接口返回的数据
      if(data['code'] == GlobalConstants.SUCCESS_CODE){
        // 业务状态码等于1 说明请求成功。才认定 http状态和业务状态均正常 就可以正常放行通过
        return data['result']; // 只要result结果
      }
      // 抛出异常
      throw Exception(data['msg'] ?? '请求失败');
    } catch (e) {
      throw Exception(e);
    }
  } 
}

// 单类对象
final dioRequest = DioRequest();

// dio请求工具发出请求，返回的数据 Response<dynamic>.data
// 把所有的接口的data解构出来，拿到真正的数据 要判断业务状态码是不是等于1
