import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/result.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/search_tvshow_use_case.dart';
import 'package:tv_randshow/ui/states/pagination_notifier.dart';

final paginationProvider = AsyncNotifierProvider.family<
    PaginationNotifier<Result, String>, List<Result>, String>(
  () {
    return PaginationNotifier(
      itemsByPage: 20,
      getNextPage: (page, input) async {
        final SearchTvShowUseCase searchTvShowUseCase =
            locator<SearchTvShowUseCase>();

        return (await searchTvShowUseCase(
          page: page,
          text: input,
        ))
            .results;
      },
    );
  },
);

class SearchTvshowsNotifier extends AutoDisposeNotifier<String> {
  Timer? _timer;

  @override
  String build() {
    ref.onDispose(() {
      if (_timer != null && (_timer?.isActive ?? false)) _timer!.cancel();
    });
    return '';
  }

  void update(String text) => state = text;

  void searchAutomatic(String text, VoidCallback function) {
    if (text.isEmpty || text == state) return;

    if (_timer != null && (_timer?.isActive ?? false)) _timer!.cancel();

    _timer = Timer(const Duration(seconds: 3), () {
      state = text;
      function();
    });
  }
}

final searchProvider =
    AutoDisposeNotifierProvider<SearchTvshowsNotifier, String>(
  SearchTvshowsNotifier.new,
);
