import 'package:shop/models/login_model.dart';

abstract class ShopAppStates {}

class ShopAppIntialState extends ShopAppStates {}

class ShopAppLoadinglState extends ShopAppStates {}

class ShopAppSucesslState extends ShopAppStates {
  final ShopLoginModel loginModel;

  ShopAppSucesslState(this.loginModel);
}

class ShopAppErrorlState extends ShopAppStates {
  final String error;

  ShopAppErrorlState(this.error);
}

class ShopChangePasswordVisibilitylState extends ShopAppStates {}
