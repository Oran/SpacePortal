import 'package:spaceportal/models/apod_model.dart';
import 'package:spaceportal/network/apod_network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/network/articles_network.dart';
import 'package:spaceportal/network/launch_network.dart';
import 'package:spaceportal/utils/generate_blurhash.dart';

final apodProvider = Provider<CachedData>(
  (ref) => APODData().getDataFromCache(),
);

final articleProvider = Provider(
  (ref) => ArticleAPI().getDataFromCache(),
);

final launchProvider = Provider(
  (ref) => LaunchNetwork().getDataFromCache(),
);

final blurhashProvider = FutureProvider.family(
  (ref, url) => getDataFromCompute(url),
);
