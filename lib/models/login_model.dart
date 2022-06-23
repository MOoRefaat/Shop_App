class ShopLoginModel {
  bool? status;
  String? message;
  UserModel? data;

  ShopLoginModel.fromJason(Map<String, dynamic> jason) {
    status = jason['status'];
    message = jason['message'];
    data = (jason['data'] != null ? UserModel.fromJason(jason['data']) : null);
  }
}

class UserModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
//  late int points;
  // late int credits;
  late String token;

  UserModel.fromJason(Map<String, dynamic> jason) {
    id = jason['id'];
    name = jason['name'];
    email = jason['email'];
    phone = jason['phone'];
    image = jason['image'];
    //points = jason['points'];
    //credits = jason['credits'];
    token = jason['token'];
  }
}
