import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/modles/eventModel.dart';
import 'package:test/services/apiService.dart';

///=====================for getting event list================================
final selectedCategoryUrlProvider = StateProvider<String?>((ref) => null);

final eventListProvider = FutureProvider<EventModel>((ref) async {
  final selectedUrl = ref.watch(selectedCategoryUrlProvider);
  final url = selectedUrl ?? DEFAULT_EVENT_URL;
  return ApiService().fetchEvents(url);
});

///=====================for handling list to grid toggle================================
final viewToggleProvider =
    StateProvider<bool>((ref) => true); // true = List, false = Grid

///=====================for handling date ================================
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

///=====================for handling searchbar================================
final searchQueryProvider = StateProvider<String>((ref) => '');

///=====================for handling price================================
final selectedPriceRangeProvider = StateProvider<RangeValues?>((ref) => null);

///=====================modifying events with any applied filter or search================================
final filteredEventsProvider = Provider<EventModel>((ref) {
  final data = ref.watch(eventListProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final selectedDate = ref.watch(selectedDateProvider);
  final priceRange = ref.watch(selectedPriceRangeProvider);

  return data.maybeWhen(
    data: (events) {
      var filteredItems = events.item ?? [];

      if (searchQuery.isNotEmpty) {
        filteredItems = filteredItems
            .where((e) =>
                e.eventname
                    ?.toLowerCase()
                    .contains(searchQuery.toLowerCase()) ??
                false)
            .toList();
      }

      if (selectedDate != null) {
        final selectedDateStart =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
                    .millisecondsSinceEpoch ~/
                1000;
        final selectedDateEnd = selectedDateStart + 86400;
        filteredItems = filteredItems
            .where((e) =>
                e.startTime != null &&
                e.startTime! >= selectedDateStart &&
                e.startTime! < selectedDateEnd)
            .toList();
      }

      if (priceRange != null) {
        filteredItems = filteredItems.where((e) {
          final price = e.tickets?.mnumicketPrice;
          return price != null &&
              price >= priceRange.start &&
              price <= priceRange.end;
        }).toList();
      }

      return events.copyWith(item: filteredItems);
    },
    orElse: () => EventModel(item: []),
  );
});

const DEFAULT_EVENT_URL = 'https://yourapi.com/events';
