import 'package:flutter/material.dart';
import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class SocialRegisterCubit extends Cubit<ShopRegisterStates> {
  SocialRegisterCubit() : super(ShopRegisterIntialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // late SocialLoginModel loginModel;

  // void userLogin({
  //   required String email,
  //   required String password,
  //   required String phone,
  //   required String name,
  // }) {
  //   emit(ShopRegisterLoadinglState());
  //   DioHelper.postData(url: REGISTER, data: {
  //     'email': email,
  //     'password': password,
  //     'name': name,
  //     'phone': phone
  //   }).then((value) {
  //     // print(value);
  //     loginModel = SocialLoginModel.fromJason(value.data!);
  //     // print(loginModel.status);
  //     //print(loginModel.message);
  //     //print(loginModel.data.token);
  //     emit(ShopRegisterSucesslState(loginModel));
  //   }).catchError((error) {
  //     // print(error.toString());
  //     emit(ShopRegisterErrorlState(error.toString()));
  //   });
  // }

  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePasswordVisibilitylRegisterState());
  }
}
