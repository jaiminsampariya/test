import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:test/controllers/catController.dart';
import 'package:test/controllers/eventListControllert.dart';
import 'package:test/services/auth.dart';
import 'package:test/utility/ScalingUtility.dart';
import 'package:test/widget/eventGridtile.dart';
import 'package:test/widget/eventListTile.dart';
import 'package:test/widget/loading.dart';

class EventListScreen extends ConsumerWidget {
  String? url;
  final String category;

  EventListScreen({super.key, this.url, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("wid build");
    final scale = ScalingUtility(context: context)..setCurrentDeviceSize();

    var isListView = ref.watch(viewToggleProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: scale.getPadding(top: 30, bottom: 10, left: 10, right: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Events in Ahmedabad",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        isListView ? Icons.grid_view : Icons.list,
                        color: Colors.white,
                      ),
                      onPressed: () => ref
                          .read(viewToggleProvider.notifier)
                          .state = !isListView,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Authentication().signOut(context: context);
                        }),
                  ],
                ),
                SizedBox(height: scale.getScaledHeight(10)),
                TextField(
                  onChanged: (value) =>
                      ref.read(searchQueryProvider.notifier).state = value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "What do you feel like doing?",
                    prefixIcon: const Icon(Icons.search),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: scale.getScaledHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButton(scale, "Categories", () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => SizedBox(
                      height: scale.getScaledHeight(250),
                      child: Column(
                        children: [
                          SizedBox(
                            height: scale.getScaledHeight(8),
                          ),
                          Text(
                            "Select Category",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: scale.getScaledFont(19)),
                          ),
                          Consumer(builder: (context, ref, child) {
                            final categoryState = ref.watch(categoryProvider);
                            return Expanded(
                              child: categoryState.when(
                                data: (categories) => ListView.builder(
                                  padding: const EdgeInsets.all(12),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final cat = categories[index];
                                    return GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(selectedCategoryUrlProvider
                                                .notifier)
                                            .state = cat.data;
                                        Navigator.pop(context);
                                        ref.invalidate(searchQueryProvider);
                                        ref.invalidate(selectedDateProvider);
                                        ref.invalidate(
                                            selectedPriceRangeProvider);
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            child: Lottie.asset(
                                                'assets/loading.json'),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            cat.category ?? "",
                                            style: TextStyle(
                                                fontSize:
                                                    scale.getScaledFont(15)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                loading: () => loadingWidget(),
                                error: (err, stack) =>
                                    Center(child: Text(err.toString())),
                              ),
                            );
                          })
                        ],
                      )),
                );
              }, null),
              Consumer(builder: (context, ref, child) {
                final selectedDate = ref.watch(selectedDateProvider);
                return customButton(
                    scale,
                    selectedDate != null
                        ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
                        : "Date", () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    ref.read(selectedDateProvider.notifier).state = pickedDate;
                  }
                },
                    selectedDate != null
                        ? () {
                            ref.read(selectedDateProvider.notifier).state =
                                null;
                          }
                        : null);
              }),
              Consumer(builder: (context, ref, child) {
                final priceRange = ref.watch(selectedPriceRangeProvider);
                return customButton(
                  scale,
                  priceRange != null
                      ? "₹${priceRange.start.round()} - ₹${priceRange.end.round()}"
                      : "Price",
                  () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        RangeValues tempRange =
                            priceRange ?? const RangeValues(0, 1000);
                        return StatefulBuilder(
                          builder: (context, setState) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Select Price Range",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),

                                /// ================dont know about range so randomly chose max as 1000 ........ we can modify
                                RangeSlider(
                                  min: 0,
                                  max: 1000,
                                  values: tempRange,
                                  divisions: 100,
                                  labels: RangeLabels(
                                    "₹${tempRange.start.round()}",
                                    "₹${tempRange.end.round()}",
                                  ),
                                  onChanged: (range) =>
                                      setState(() => tempRange = range),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("₹${tempRange.start.round()}"),
                                    Text("₹${tempRange.end.round()}"),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        ref
                                            .read(selectedPriceRangeProvider
                                                .notifier)
                                            .state = null;
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Clear"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(selectedPriceRangeProvider
                                                .notifier)
                                            .state = tempRange;
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Apply"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  priceRange != null
                      ? () => ref
                          .read(selectedPriceRangeProvider.notifier)
                          .state = null
                      : null,
                );
              }),
            ],
          ),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final eventState = ref.watch(eventListProvider);
              var filteredEvents = ref.watch(filteredEventsProvider);
              return Padding(
                padding: scale.getPadding(all: 8),
                child: eventState.when(
                  data: (_) {
                    final events = filteredEvents.item ?? [];
                    return isListView
                        ? Container(
                            child: events.isNotEmpty
                                ? ListView.builder(
                                    itemCount: events.length,
                                    itemBuilder: (context, index) {
                                      final event = events[index];
                                      return InkWell(
                                        onTap: () {
                                          final encodedUrl =
                                              Uri.encodeComponent(
                                                  event.eventUrl ?? '');
                                          final encodedTitle =
                                              Uri.encodeComponent(
                                                  event.eventname ?? "");
                                          if (event.eventUrl != null) {
                                            context.push(
                                                '/webview?url=$encodedUrl&title=$encodedTitle');
                                          }
                                        },
                                        child: EventListTile(
                                          imageUrl: event.thumbUrl ?? "",
                                          title: event.eventname ?? "",
                                          location: event.location ?? "",
                                          date: event.startTimeDisplay ?? "",
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LottieBuilder.asset("assets/nd.json"),
                                      Text("No Evenet Found !")
                                    ],
                                  )),
                          )
                        : Container(
                            child: events.isNotEmpty
                                ? GridView.builder(
                                    itemCount: events.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 3 / 2.3,
                                    ),
                                    itemBuilder: (context, index) {
                                      final event = events[index];
                                      return InkWell(
                                        onTap: () {
                                          final encodedUrl =
                                              Uri.encodeComponent(
                                                  event.eventUrl ?? '');
                                          final encodedTitle =
                                              Uri.encodeComponent(
                                                  event.eventname ?? "");
                                          if (event.eventUrl != null) {
                                            context.push(
                                                '/webview?url=$encodedUrl&title=$encodedTitle');
                                          }
                                        },
                                        child: eventGridTile(
                                          imageUrl: event.thumbUrl ?? "",
                                          venue: event.location ?? "",
                                          title: event.eventname ?? "",
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LottieBuilder.asset("assets/nd.json"),
                                      Text("No Evenet Found !")
                                    ],
                                  )),
                          );
                  },
                  loading: () => const loadingWidget(),
                  error: (err, stack) => Center(child: Text(err.toString())),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget customButton(
    ScalingUtility scale,
    String label,
    Function()? ontap,
    Function()? onClear,
  ) {
    return Expanded(
      child: Container(
        margin: scale.getMargin(horizontal: 2),
        padding: scale.getPadding(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(scale.getScaledFont(20))),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                    color: const Color.fromARGB(255, 90, 88, 88),
                    fontSize: scale.getScaledFont(12)),
              ),
              SizedBox(
                width: scale.getScaledWidth(8),
              ),
              if (onClear != null)
                GestureDetector(
                  onTap: onClear,
                  child: Icon(Icons.close, size: scale.getScaledFont(18)),
                )
              else
                InkWell(
                    onTap: () {
                      if (ontap != null) {
                        ontap();
                      }
                    },
                    child: Icon(Icons.keyboard_arrow_down,
                        size: scale.getScaledFont(20)))
            ],
          ),
        ),
      ),
    );
  }
}
