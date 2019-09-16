
import 'dart:async';

import 'package:atlan_wan_android_flutter/entity/login_register_bean.dart';
import 'package:atlan_wan_android_flutter/entity/user_point_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/util/storage_utils.dart';

import 'bloc_provider.dart';

class LoginBloc implements BlocBase {

  StreamController<bool> _isRegisterController = StreamController<bool>.broadcast();
  Stream<bool> get isRegisterValue => _isRegisterController.stream;

  StreamController<LoginRegisterBean> _loginRegisterController = StreamController<LoginRegisterBean>.broadcast();
  Stream<LoginRegisterBean> get loginRegisterValue => _loginRegisterController.stream;

  UserPointBean _userPointBean;
  StreamController<UserPointBean> _userPointController = StreamController<UserPointBean>.broadcast();
  Stream<UserPointBean> get userPointValue => _userPointController.stream;

  void setIsRegister(bool register) {
    _isRegisterController.sink.add(register);
  }

  void setLoginRegisterBean(LoginRegisterBean bean) {
    _loginRegisterController.sink.add(bean);
  }

  void setUserPointBean(UserPointBean bean) {
    _userPointBean = bean;
    _userPointController.sink.add(bean);
  }

  Future login(String userName, String password) async {
    LoginRegisterBean bean = await Api.login(userName, password).catchError((e) {
      print("login, exception=$e");
    });
    print("login, bean=$bean");
    if (bean != null) {
      setIsRegister(false);
      setLoginRegisterBean(bean);
      StorageUtils.setUserInfo(bean);
      getUserPoint();
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

  Future getUserPoint() async {
    if (_userPointBean == null) {
      _userPointBean = await Api.getUserPoint().catchError((e) {
        print("getUserPoint, exception=$e");
      });
    }
    print("getUserPoint, bean=$_userPointBean");
    if (_userPointBean != null) {
      setUserPointBean(_userPointBean);
    }
    return _userPointBean;
  }

  @override
  void dispose() {
    _isRegisterController.close();
    _loginRegisterController.close();
    _userPointController.close();
  }

}
