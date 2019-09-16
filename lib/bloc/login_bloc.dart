

import 'dart:async';

import 'package:atlan_wan_android_flutter/entity/login_register_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';

import 'bloc_provider.dart';

class LoginBloc implements BlocBase {

  StreamController<bool> _isRegisterController = StreamController<bool>.broadcast();
  Stream<bool> get isRegisterValue => _isRegisterController.stream;

  StreamController<LoginRegisterBean> _loginRegisterBeanController = StreamController<LoginRegisterBean>();
  Stream<LoginRegisterBean> get loginBeanValue => _loginRegisterBeanController.stream;


  void setIsRegister(bool register) {
    _isRegisterController.sink.add(register);
  }

  Future login(String userName, String password) async {
    LoginRegisterBean bean = await Api.login(userName, password).catchError((e) {
      print("login, exception=$e");
    });
    print("login, bean=$bean");
    if (bean != null) {
      setIsRegister(false);
      _loginRegisterBeanController.sink.add(bean);


    }
    return bean;
  }

  Future register(String userName, String password, String repassword) async {
    LoginRegisterBean bean = await Api.register(userName, password, repassword).catchError((e) {
      print("register, exception=$e");
    });
    print("register, bean=$bean");
    if (bean != null) {
      setIsRegister(false);
    }
    return bean;
  }

  @override
  void dispose() {
    _isRegisterController.close();
    _loginRegisterBeanController.close();
  }

}
