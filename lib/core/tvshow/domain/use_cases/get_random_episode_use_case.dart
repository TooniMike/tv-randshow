import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/episode.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/core/tvshow/domain/services/random_service.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

@injectable
class GetRandomEpisodeUseCase {
  final IOnlineRepository _onlineRepository;
  final RandomService _randomService;

  const GetRandomEpisodeUseCase(this._onlineRepository, this._randomService);

  Future<TvshowResult> call({
    required int idTv,
    required int numberOfSeasons,
    List<StreamingDetail> streamings = const [],
  }) async {
    final int randomSeason =
        _randomService.getNumber(max: numberOfSeasons, min: 1);
    final TvshowSeasonsDetails seasonsDetails =
        await _onlineRepository.getDetailsTvSeasons(
      Helpers.getLocale(),
      idTv,
      randomSeason,
    );
    final Episode episode = seasonsDetails.episodes.elementAt(
      _randomService.getNumber(max: seasonsDetails.episodes.length),
    );
    assert(
      episode.seasonNumber > 0,
      'Random season number should be bigger than 0',
    );
    assert(
      episode.episodeNumber > 0,
      'Random episode number should be bigger than 0',
    );
    return TvshowResult(
      id: episode.id,
      name: episode.name,
      streamings: streamings,
      randomSeason: episode.seasonNumber,
      randomEpisode: episode.episodeNumber,
      episodeName: episode.name,
      episodeDescription: episode.overview,
    );
  }
}
