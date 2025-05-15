import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:test/controllers/eventListControllert.dart';
import 'package:test/utility/ScalingUtility.dart';
import 'package:test/widget/loading.dart';

import '../controllers/catController.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    final categoryState = ref.watch(categoryProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 243, 243, 243),
          title: const Text("Select Category")),
      body: categoryState.when(
        data: (categories) => GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final cat = categories[index];
            return GestureDetector(
              onTap: () {
                ref.read(selectedCategoryUrlProvider.notifier).state = cat.data;
                context.push(
                  '/eventList?url=${Uri.encodeComponent(cat.data ?? "")}&category=${Uri.encodeComponent(cat.category ?? "")}',
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Lottie.asset('assets/loading.json'),
                  ),
                  const SizedBox(height: 8),
                  Text(cat.category ?? ""),
                ],
              ),
            );
          },
        ),
        loading: () => loadingWidget(),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}
