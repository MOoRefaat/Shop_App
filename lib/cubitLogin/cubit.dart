import 'package:flutter/material.dart';
import 'package:shop/end_points.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/network/dio_hepler.dart';

import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppIntialState());
  static ShopAppCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopAppLoadinglState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      // print(value);
      loginModel = ShopLoginModel.fromJason(value.data!);
      // print(loginModel.status);
      //print(loginModel.message);
      //print(loginModel.data.token);
      emit(ShopAppSucesslState(loginModel));
    }).catchError((error) {
      // print(error.toString());
      emit(ShopAppErrorlState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePasswordVisibilitylState());
  }
}
