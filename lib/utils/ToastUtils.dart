import 'package:flutter/material.dart';

class Toastutils {
  // 阀门控制
  static bool showLoading = false;
  static void showToast(BuildContext context, String? msg) {
    if (showLoading == true) {
      return;
    }
    showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      showLoading = false;
    });
    // 数据获取成功 刷新成功
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40)
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: Text(msg ?? "加载成功" ,textAlign: TextAlign.center,),)
      );
  }
}