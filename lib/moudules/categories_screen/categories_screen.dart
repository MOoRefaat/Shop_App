import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop/cubitLayout/cubitLayout_screen.dart';
import 'package:shop/cubitLayout/statesLayout.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => categoriesBuilder(
                ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[900],
                ),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data.data.length);
      },
    );
  }

  Widget categoriesBuilder(DataModel model) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              model.name,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  fontFamily: 'JoseifSans'),
            ),
            Spacer(),
            Icon(Icons.arrow_forward)
          ],
        ),
      );
}
