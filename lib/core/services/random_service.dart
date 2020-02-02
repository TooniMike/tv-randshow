import 'dart:math';

import 'package:meta/meta.dart';
import 'package:tv_randshow/core/models/episode.dart';
import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/models/tvshow_result.dart';
import 'package:tv_randshow/core/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/core/utils/constants.dart';

import 'api_service.dart';
import 'log_service.dart';
import 'secure_storage_service.dart';

class RandomService {
  RandomService({
    @required ApiService apiService,
    @required SecureStorageService secureStorageService,
  })  : _apiService = apiService,
        _secureStorageService = secureStorageService;
  final ApiService _apiService;
  final SecureStorageService _secureStorageService;
  final LogService _logger = LogService.instance;

  Future<TvshowResult> randomEpisode(
      TvshowDetails tvshowDetails, String language) async {
    final Query query = Query(
      apiKey: await _secureStorageService.readStorage(KeyStore.API_KEY),
      language: language,
    );
    final int randomSeason =
        _getRandomNumber(tvshowDetails.numberOfSeasons, true);
    final TvshowSeasonsDetails _seasonsDetails =
        await _apiService.getDetailsTvSeasons(
      query,
      tvshowDetails.id,
      randomSeason,
    );
    if (_seasonsDetails != null) {
      final Episode episode = _seasonsDetails.episodes.elementAt(
        _getRandomNumber(_seasonsDetails.episodes.length, false),
      );
      final TvshowResult tvshowResult = TvshowResult(
        tvshowDetails: tvshowDetails,
        randomSeason: episode.seasonNumber,
        randomEpisode: episode.episodeNumber,
        episodeName: episode.name,
        episodeDescription: episode.overview,
      );
      return tvshowResult;
    } else {
      return null;
    }
  }

  /// If total is a number from 1, add + 1 to result.
  /// If else a length of list, get normal random
  int _getRandomNumber(int total, bool isSeason) {
    final Random random = Random();
    final int randomNumber = random.nextInt(total);
    _logger.logger.i(
      'Random ${isSeason ? 'season' : 'episode'} nº: ${isSeason ? randomNumber + 1 : randomNumber + 1}',
    );
    return isSeason ? randomNumber + 1 : randomNumber;
  }
}
