import 'package:spaceportal/Models/FSData.dart';
import 'package:spaceportal/Network/APODNetwork.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/Network/ArticleNetwork.dart';
import 'package:spaceportal/Network/LaunchNetwork.dart';
import 'package:spaceportal/Utils/GenerateBlurhash.dart';

final apodProvider = Provider<CachedData>(
  (ref) => APODData().getDataFromCache(),
);

final articleProvider = FutureProvider(
  (ref) => ArticleAPI().getNewsData(),
);

final launchProvider = Provider(
  (ref) => LaunchNetwork().getDataFromCache(),
);

final blurhashProvider = FutureProvider.family(
  (ref, url) => getDataFromCompute(url),
);
