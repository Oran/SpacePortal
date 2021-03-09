import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:SpacePortal/network/network.dart';

final apodProvider = StreamProvider.autoDispose((ref) => NasaPODData().getFSData());