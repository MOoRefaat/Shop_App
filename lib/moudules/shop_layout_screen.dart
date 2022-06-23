import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/componanets.dart';
import 'package:shop/cubitLayout/cubitLayout_screen.dart';
import 'package:shop/cubitLayout/statesLayout.dart';
import 'package:shop/cubitLogin/cubit.dart';
import 'package:shop/moudules/login_screen/login_screen.dart';
import 'package:shop/moudules/register_screen/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/moudules/search_screen/search_Screen.dart';
import 'package:shop/moudules/shop_layout_screen.dart';
import 'package:shop/network/cashe_helper.dart';

class ShopLayoutScreen extends StatelessWidget {
  //const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ShopCubit cubit = ShopCubit.get(context);
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCatigoriesData()
        ..getFavoritesData()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ShopCubit cubit = ShopCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: HexColor('6c63ff'),
                title: Text('Welcome To SALLA', style: TextStyle(fontSize: 20)),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                  ),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: HexColor('6c63ff'),
                elevation: 5,
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  // color: HexColor('6c63ff')
                ),
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: cubit.bottomItems,
              ),
            );
          }),
    );
  }
}
