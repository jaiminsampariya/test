import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/modles/catModel.dart';
import 'package:test/modles/eventModel.dart';

class ApiService {
  ///==============for getting catagories======API call======================
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://allevents.s3.amazonaws.com/tests/categories.json'));
    final List data = jsonDecode(response.body);
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  ///==============for getting evenets======API call======================
  Future<EventModel> fetchEvents(String url) async {
    print("----------------calld-------------------------");
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    return EventModel.fromJson(data);
  }
}
