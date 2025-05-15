class CategoryModel {
  String? category;
  String? data;

  CategoryModel({this.category, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    data = json['data'];
  }
}
