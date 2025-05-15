import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/modles/catModel.dart';
import 'package:test/services/apiService.dart';

/// ========================for getting cat==========================
final categoryProvider = FutureProvider<List<CategoryModel>>((ref) {
  return ApiService().fetchCategories();
});
