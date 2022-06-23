class ChnageFavouritesModel {
  late bool? status;
  late String? message;

  ChnageFavouritesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
