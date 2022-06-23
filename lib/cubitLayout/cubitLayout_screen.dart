import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/cubitLayout/statesLayout.dart';
import 'package:shop/end_points.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/changeFavourites.dart';
import 'package:shop/models/favorites-model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/moudules/categories_screen/categories_screen.dart';
import 'package:shop/moudules/favorites_screen/favourites_screen.dart';
import 'package:shop/moudules/products_screen/products_screen.dart';
import 'package:shop/moudules/settings_screen/settings_screen.dart';
import 'package:shop/network/cashe_helper.dart';
import 'package:shop/network/dio_hepler.dart';

import '../cubitLogin/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
    // SettingsScreen(),
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool>? favourite = {};

  void getHomeData() {
    emit(ShopHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: tokeen).then((value) {
      homeModel = HomeModel.formJson(value.data);

      for (var element in homeModel!.data.products) {
        favourite!.addAll({element.id: element.inFavourite});
      }
      print(favourite.toString());

      //   print(inFavourite.toString());
      // print(homeModel!.data.banners[2].image);
      // print(homeModel!.status);
      // print(homeModel!.data.products[0].discount);
      emit(ShopHomeDataSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeDataErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCatigoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.formJson(value.data);
      emit(ShopCategoriesDataSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesDataErrorState());
    });
  }

  String? tokeen = CasheHelper.getData(key: 'token') as String?;
  ChnageFavouritesModel? chnageFavourite;
  void changeFavourites(int productID) {
    DioHelper.postData(
            url: FAVOURITES, data: {'product_id': productID}, token: tokeen)
        .then((value) {
      chnageFavourite = ChnageFavouritesModel.fromjson(value.data);
      //  print(value.data);
      getFavoritesData();
      emit(ShopChangeFavouritesDataSucsessState());
    }).catchError((error) {
      ShopChangeFavouritesDataErrorState();
    });
  }

  FavouriteModel? favouriteModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesDataState());

    DioHelper.getData(url: FAVOURITES, token: tokeen).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      // print(value.data.toString());
      emit(ShopGetFavoritesDataSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesDataErrorState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: tokeen).then((value) {
      userModel = ShopLoginModel.fromJason(value.data);
      print(userModel!.data!.name);
      emit(ShopUserDataSucsessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserDataErrorState());
    });
  }

  void UpdateData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopLoadingUserDataUpdateState());

    DioHelper.putData(
        url: PROFILE,
        token: tokeen,
        data: {'name': name, 'phone': phone, 'email': email}).then((value) {
      userModel = ShopLoginModel.fromJason(value.data);
      // print(userModel!.data!.name);
      emit(ShopUserDataUpdateSucsessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserDataUpdateErrorState());
    });
  }

// List<dynamic> busniess = [];
  // List<dynamic> health = [];
  // List<dynamic> sports = [];
  // List<dynamic> technology = [];
}
