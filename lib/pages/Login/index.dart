import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/aip/user.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController(); // 账号控制器
  TextEditingController _codeController = TextEditingController(); // 密码控制器
  final UserController _userController = Get.find<UserController>(); // 寻找对象
  // 用户账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "请输入手机号";
        }
        // 校验账号是否为手机号
        if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
          return "请输入正确的手机号";
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ), // OutlineInputBorder
      ), // InputDecoration
    ); // TextFormField
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "请输入密码";
        }
        // 校验密码 6-16位数字，字母，或下划线或横线
        if (!RegExp(r'^[a-zA-Z0-9_ -]{6,16}$').hasMatch(value)) {
          return "请输入6-16位数字字母或下划线或横线";
        }
        return null;
      },
      controller: _codeController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ), // OutlineInputBorder
      ), // InputDecoration
    ); // TextFormField
  }

  _login() async {
    // 调用登录接口
    try {
      final res = await loginApi({
        "account": _phoneController.text,
        "password": _codeController.text,
      });
      // print(res); // 用户信息
      _userController.updateUserInfo(res);
      tokenManager.setToken(res.token);  // 写入持久化数据
      ToastUtils.showToast(context,"登录成功");
      Navigator.pop(context); //返回上个页面
    } catch (e) {
      print(e.toString());
      ToastUtils.showToast(context, (e as DioException).message);
    }
    // 登录成功，跳转到首页
    // http状态码200表示成功，业务状态码 业务执行成功 1
  }
  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if (_key.currentState!.validate() == true) {
            // 校验通过，执行登录操作
            if (_isChecked == true) {
              // 勾选了同意隐私条款和用户协议
              _login();
            } else {
              // 未勾选同意隐私条款和用户协议
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("提示"),
                    content: Text("请先同意隐私条款和用户协议"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("确定"),
                      ), // TextButton
                    ],
                  ); // AlertDialog
                },
              ); // showDialog
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ), // RoundedRectangleBorder
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ), // ElevatedButton
    ); // SizedBox
  }

  bool _isChecked = false;

  // 勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            // 处理勾选状态变化
            setState(() {
              _isChecked = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ), // RoundedRectangleBorder
          // 可选: 设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ), // Checkbox
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ), // TextSpan
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ), // TextSpan
            ],
          ), // TextSpan
        ), // Text.rich
      ],
    ); // Row
  }

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ), // Text
        ), // Padding
      ],
    ); // Row
  }

final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ), // AppBar
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ), // Column
        ), // Container
      ), // Form
    ); // Scaffold
  }
}
