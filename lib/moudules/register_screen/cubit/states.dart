abstract class ShopRegisterStates {}

class ShopRegisterIntialState extends ShopRegisterStates {}

class ShopRegisterLoadinglState extends ShopRegisterStates {}

class ShopRegisterSucesslState extends ShopRegisterStates {}

class ShopRegisterErrorlState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorlState(this.error);
}

class ShopChangePasswordVisibilitylRegisterState extends ShopRegisterStates {}
