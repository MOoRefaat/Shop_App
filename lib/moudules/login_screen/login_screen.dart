import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/componanets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/moudules/shop_layout_screen.dart';
import 'package:shop/network/cashe_helper.dart';

import '../../cubitLogin/cubit.dart';
import '../../cubitLogin/states.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Object? tokeen = CasheHelper.getData(key: 'token');

  // Icon eyeShow = Icon(Icons.remove_red_eye);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopAppCubit(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
          if (state is ShopAppSucesslState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);

              CasheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                tokeen = state.loginModel.data?.token;

                navigateToAndErase(context, ShopLayoutScreen());
              });
              // showToast(
              //     text: state.loginModel.message, state: ToastState.SUCCSES);
            } else // if (state.loginModel.status = true)
            {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message!, state: ToastState.ERORR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Container(
              padding: EdgeInsetsDirectional.all(20),
              width: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/loginPicc.png')),
                        Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50.0,
                              color: HexColor('#536DFE'),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter An Email Address';
                            }
                          },
                          controller: emailController,
                          // obscureText: true,
                          onChanged: (x) {
                            print(x);
                          },
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Adress',
                            prefixIcon: Icon(Icons.email),
                            //suffixIcon: Icon(Icons.remove_red_eye),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          // keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            }
                          },
                          controller: passwordController,
                          obscureText: ShopAppCubit.get(context).isPassword,
                          onChanged: (x) {
                            print(x);
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopAppCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                              print(emailController.text);
                              print(passwordController.text);
                            }
                          },
                          decoration: InputDecoration(
                            //fillColor: HexColor('#536DFE'),
                            // hoverColor: HexColor('#536DFE'),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopAppCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(ShopAppCubit.get(context).suffixIcon),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            //  suffixIcon: Icon(Icons.remove_red_eye),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopAppLoadinglState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              //color: HexColor('#536DFE'),
                              borderRadius:
                                  BorderRadiusDirectional.circular(40),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopAppCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  print(emailController.text);
                                  print(passwordController.text);
                                }
                              },
                              child: Text('LOGIN',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white)),
                              color: HexColor('#536DFE'),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t Have An Account !',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text('Register Now',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor('#536DFE'))))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
