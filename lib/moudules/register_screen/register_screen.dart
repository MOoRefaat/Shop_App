import 'package:flutter/material.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/cashe_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  // const RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Object? tokeen = CasheHelper.getData(key: 'token');
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          // if (state is ShopRegisterSucesslState) {
          //   if (state.loginModel.status!) {
          //     print(state.loginModel.message);
          //     print(state.loginModel.data?.token);
          //
          //     CasheHelper.saveData(
          //             key: 'token', value: state.loginModel.data?.token)
          //         .then((value) {
          //       tokeen = state.loginModel.data?.token;
          //
          //       navigateToAndErase(context, ShopLayoutScreen());
          //     });
          //     // showToast(
          //     //     text: state.loginModel.message, state: ToastState.SUCCSES);
          //   } else // if (state.loginModel.status = true)
          //   {
          //     print(state.loginModel.message);
          //     showToast(
          //         text: state.loginModel.message!, state: ToastState.ERORR);
          //   }
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(backgroundColor: HexColor('#536DFE')),
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
                          'Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'lobster',
                              fontSize: 50.0,
                              color: HexColor('#536DFE'),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                          },
                          controller: nameController,
                          // obscureText: true,
                          onChanged: (x) {
                            print(x);
                          },
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person_add),
                            //suffixIcon: Icon(Icons.remove_red_eye),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
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
                          obscureText:
                              SocialRegisterCubit.get(context).isPassword,
                          onChanged: (x) {
                            print(x);
                          },
                          onFieldSubmitted: (value) {
                            // if (formKey.currentState!.validate()) {
                            //   ShopRegisterCubit.get(context).userLogin(
                            //       name: nameController.text,
                            //       phone: phoneController.text,
                            //       email: emailController.text,
                            //       password: passwordController.text);
                            //   print(emailController.text);
                            //   print(passwordController.text);
                            // }
                          },
                          decoration: InputDecoration(
                            //fillColor: HexColor('#536DFE'),
                            // hoverColor: HexColor('#536DFE'),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                SocialRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(
                                  SocialRegisterCubit.get(context).suffixIcon),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            //  suffixIcon: Icon(Icons.remove_red_eye),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                          },
                          controller: phoneController,
                          // obscureText: true,
                          onChanged: (x) {
                            print(x);
                          },
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadinglState,
                          //state is! ShopAppLoadinglState,
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
                                // if (formKey.currentState!.validate()) {
                                //   ShopRegisterCubit.get(context).userLogin(
                                //       name: nameController.text,
                                //       phone: phoneController.text,
                                //       email: emailController.text,
                                //       password: passwordController.text);
                                //   print(emailController.text);
                                //   print(passwordController.text);
                                // }
                              },
                              child: Text('Register',
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
