class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.formJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.formJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.formJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.formJson(element));
    });
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavourite;
  late bool inChart;

  ProductModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourite = json['in_favorites'];
    inChart = json['in_cart'];
  }
}
