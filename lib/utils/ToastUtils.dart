import 'package:flutter/material.dart';

class Toastutils {
  static void showToast(BuildContext context, String? msg) {
    // 数据获取成功 刷新成功
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40)
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        content: Text(msg ?? "加载成功" ,textAlign: TextAlign.center,),)
      );
  }
}