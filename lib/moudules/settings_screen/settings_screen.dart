import 'package:flutter/material.dart';
import 'package:shop/cubitLayout/statesLayout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../componanets.dart';
import '../../cubitLayout/cubitLayout_screen.dart';
import '../../cubitLogin/cubit.dart';
import '../../network/cashe_helper.dart';
import '../login_screen/login_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  // const SettingsScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        final formKey = GlobalKey<FormState>();
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
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
                        return 'Please Enter phone';
                      }
                    },
                    controller: phoneController,
                    onChanged: (x) {
                      print(x);
                    },
                    decoration: InputDecoration(
                      //fillColor: HexColor('#536DFE'),
                      // hoverColor: HexColor('#536DFE'),
                      labelText: 'phone',
                      prefixIcon: Icon(Icons.phone),
                      //  suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.black,
                    //   borderRadius: BorderRadiusDirectional.circular(40),
                    // ),
                    width: double.infinity,
                    color: Colors.blue,
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).UpdateData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text);
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.black,
                    //   borderRadius: BorderRadiusDirectional.circular(40),
                    // ),
                    width: double.infinity,
                    color: Colors.red,
                    child: TextButton(
                        onPressed: () {
                          CasheHelper.removeData(key: 'token').then((value) {
                            if (value) {
                              navigateToAndErase(context, LoginScreen());
                            }
                          });
                        },
                        child: Text(
                          'LOG OUT',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
