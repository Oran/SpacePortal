import 'package:spaceportal/Models/FSData.dart';
import 'package:spaceportal/Network/APODNetwork.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apodProvider = Provider<CachedData>(
  (ref) => APODData().getDataFromCache(),
);