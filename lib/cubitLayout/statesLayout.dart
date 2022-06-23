import 'package:shop/models/login_model.dart';

abstract class ShopStates {}

class ShopIntialState extends ShopStates {}

class ShopBottomNavState extends ShopStates {}

class ShopHomeDataLoadingState extends ShopStates {}

class ShopHomeDataSucsessState extends ShopStates {}

class ShopHomeDataErrorState extends ShopStates {}

class ShopCategoriesDataSucsessState extends ShopStates {}

class ShopCategoriesDataErrorState extends ShopStates {}

class ShopChangeFavouritesDataSucsessState extends ShopStates {}

class ShopChangeFavouritesDataErrorState extends ShopStates {}

class ShopLoadingGetFavoritesDataState extends ShopStates {}

class ShopGetFavoritesDataSucsessState extends ShopStates {}

class ShopGetFavoritesDataErrorState extends ShopStates {}

class ShopUserDataSucsessState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopUserDataSucsessState(this.loginModel);
}

class ShopUserDataErrorState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopUserDataUpdateSucsessState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopUserDataUpdateSucsessState(this.loginModel);
}

class ShopUserDataUpdateErrorState extends ShopStates {}

class ShopLoadingUserDataUpdateState extends ShopStates {}
