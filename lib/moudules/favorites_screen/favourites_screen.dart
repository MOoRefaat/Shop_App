import 'package:flutter/material.dart';
import 'package:shop/models/favorites-model.dart';

import '../../componanets.dart';
import '../../cubitLayout/cubitLayout_screen.dart';
import '../../cubitLayout/statesLayout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesDataState,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavorites(
                    ShopCubit.get(context).favouriteModel!.data!.data![index],
                    context),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[900],
                    ),
                itemCount:
                    ShopCubit.get(context).favouriteModel!.data!.data!.length),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildFavorites(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image),
                    //'https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg'),

                    width: 120,
                    fit: BoxFit.fill,
                    height: 120,
                  ),
                  if (model.product!.discount != 0)
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
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      model.product!.name,
                      //model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          height: 1.2),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          model.product!.price.toString(),
                          // model.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            model.product!.oldPrice.toString(),
                            // model.oldPrice.toString(),
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
                                text: 'Removed From Your Fav Successfully',
                                state: ToastState.SUCCSES);
                            ShopCubit.get(context)
                                .changeFavourites(model.product!.id);
                            // print(model.id);
                            // print(model.inFavourite);
                            // print(model.name);
                            // print(model.inChart);
                          },
                          icon: CircleAvatar(
                            // backgroundColor:
                            // ShopCubit.get(context).favourite![model.id] !=
                            //  null
                            //? Colors.grey
                            //  : Colors.blue,
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
        ),
      );
}
