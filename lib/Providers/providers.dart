import 'package:SpacePortal/Network/APODNetwork.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final apodProvider = StreamProvider.autoDispose((ref) => APODData().getFSData());