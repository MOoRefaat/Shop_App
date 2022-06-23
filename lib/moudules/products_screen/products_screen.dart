// import 'dart:js';
//
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop/cubitLayout/cubitLayout_screen.dart';
import 'package:shop/cubitLayout/statesLayout.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../componanets.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //  HomeModel homeModel;
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productBuilder(
                  ShopCubit.get(context).homeModel,
                  ShopCubit.get(context).categoriesModel,
                  context),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }

  Widget productBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: model?.data.banners
                      .map((e) => Image(
                            image: NetworkImage('${e.image}'),
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ))
                      .toList(),
                  options: CarouselOptions(
                      height: 160,
                      autoPlay: true,
                      viewportFraction: 1,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal)),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categories',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          //  color: Colors.white
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildCategories(
                              categoriesModel!.data.data[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 10,
                              ),
                          itemCount: categoriesModel!.data.data.length),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'New Products',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey[400],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1 / 1.56,
                  children: List.generate(
                      model!.data.products.length,
                      (index) => buildGridProduct(
                          model.data.products[index], context)),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildCategories(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(.8),
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          )
        ],
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  // fit: BoxFit.fill,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    color: Colors.red,
                    child: Text(
                      'Discount',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w900, height: 1.2),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'EPG',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          showToast(
                            text: 'Added To Your Fav Successfully',
                            state: ToastState.SUCCSES,
                          );
                          ShopCubit.get(context).changeFavourites(model.id);
                          //  print(model.id);
                          //print(model.inFavourite);
                          //print(model.name);
                          //print(model.inChart);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favourite![model.id] !=
                                      null
                                  ? Colors.grey
                                  : Colors.blue,
                          child: Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
