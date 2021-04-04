class Launches {
  List launchData;
  int length;
  Launches({required this.launchData, required this.length});

  factory Launches.fromList(List list) {
    return Launches(
      launchData:
          list.map((launchEvent) => LaunchData.fromMap(launchEvent)).toList(),
      length: list.length,
    );
  }
}

class LaunchData {
  String id;
  String url;
  String slug;
  String name;
  Status status;
  String lastUpdated;
  String net;
  String windowEnd;
  String windowStart;
  var probability;
  String holdReason;
  String failReason;
  var hashtag;
  LaunchSP launchSP;
  Rocket rocket;
  Mission mission;
  Pad pad;
  bool webcastLive;
  String image;
  var infographic;
  List program;

  LaunchData({
    required this.id,
    required this.url,
    required this.slug,
    required this.name,
    required this.status,
    required this.lastUpdated,
    required this.net,
    required this.windowEnd,
    required this.windowStart,
    required this.failReason,
    required this.hashtag,
    required this.holdReason,
    required this.image,
    required this.infographic,
    required this.launchSP,
    required this.mission,
    required this.pad,
    required this.probability,
    required this.program,
    required this.rocket,
    required this.webcastLive,
  });

  factory LaunchData.fromMap(Map map) {
    return LaunchData(
      id: map['id'] ?? 'null',
      url: map['url'] ?? 'null',
      slug: map['slug'] ?? 'null',
      name: map['name'] ?? 'null',
      status: Status.fromMap(map['status'] ?? {}),
      lastUpdated: map['last_updated'] ?? 'null',
      net: map['net'] ?? 'null',
      windowEnd: map['window_end'] ?? 'null',
      windowStart: map['window_start'] ?? 'null',
      probability: map['probability'] ?? 'null',
      holdReason: map['holdreason'] ?? 'null',
      failReason: map['failreason'] ?? 'null',
      hashtag: map['hashtag'] ?? 'null',
      launchSP: LaunchSP.fromMap(map['launch_service_provider'] ?? {}),
      rocket: Rocket.fromMap(map['rocket']['configuration'] ?? {}),
      mission: Mission.fromMap(map['mission'] ?? {}),
      pad: Pad.fromMap(map['pad'] ?? {}),
      webcastLive: map['webcast_live'] ?? false,
      image: map['image'] ?? 'null',
      infographic: map['infographic'] ?? 'null',
      program: map['program'] ?? [],
    );
  }
}

class LaunchSP {
  int id;
  String url;
  String name;
  String type;

  LaunchSP({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
  });

  factory LaunchSP.fromMap(Map map) {
    return LaunchSP(
      id: map['id'] ?? 0,
      name: map['name'] ?? 'null',
      type: map['type'] ?? 'null',
      url: map['url'] ?? 'null',
    );
  }
}

class Pad {
  int id;
  String url;
  int agencyId;
  String name;
  String infoUrl;
  String wikiUrl;
  String mapUrl;
  String latitude;
  String longitude;
  Map location;
  String mapImage;
  int totalLaunchCount;

  Pad({
    required this.agencyId,
    required this.id,
    required this.infoUrl,
    required this.latitude,
    required this.location,
    required this.longitude,
    required this.mapImage,
    required this.mapUrl,
    required this.name,
    required this.totalLaunchCount,
    required this.url,
    required this.wikiUrl,
  });

  factory Pad.fromMap(Map map) {
    return Pad(
      id: map['id'] ?? 0,
      url: map['url'] ?? 'null',
      agencyId: map['agency_id'] ?? 0,
      name: map['name'] ?? 'null',
      infoUrl: map['info_url'] ?? 'null',
      wikiUrl: map['wiki_url'] ?? 'null',
      mapUrl: map['map_url'] ?? 'null',
      latitude: map['latitude'] ?? 'null',
      longitude: map['longitude'] ?? 'null',
      location: map['location'] ?? {},
      mapImage: map['map_image'] ?? 'null',
      totalLaunchCount: map['total_launch_count'] ?? 0,
    );
  }
}

class Rocket {
  String url;
  String name;
  String family;
  String fullName;
  String variant;

  Rocket({
    required this.family,
    required this.fullName,
    required this.name,
    required this.url,
    required this.variant,
  });

  factory Rocket.fromMap(Map map) {
    return Rocket(
      url: map['url'] ?? 'null',
      name: map['name'] ?? 'null',
      family: map['family'] ?? 'null',
      fullName: map['full_name'] ?? 'null',
      variant: map['variant'] ?? 'null',
    );
  }
}

class Status {
  int id;
  String name;
  String abbrev;
  String description;

  Status({
    required this.abbrev,
    required this.description,
    required this.id,
    required this.name,
  });

  factory Status.fromMap(Map map) {
    return Status(
      id: map['id'] ?? 0,
      name: map['name'] ?? 'null',
      abbrev: map['abbrev'] ?? 'null',
      description: map['description'] ?? 'null',
    );
  }
}

class Mission {
  String name;
  String description;
  String type;
  Orbit orbit;

  Mission({
    required this.name,
    required this.description,
    required this.orbit,
    required this.type,
  });
  factory Mission.fromMap(Map map) {
    return Mission(
      name: map['name'] ?? 'null',
      description: map['description'] ?? 'null',
      type: map['type'] ?? 'null',
      orbit: Orbit.fromMap(map['orbit'] ?? {}),
    );
  }
}

class Orbit {
  int id;
  String name;
  String abbrev;

  Orbit({
    required this.abbrev,
    required this.id,
    required this.name,
  });

  factory Orbit.fromMap(Map map) {
    return Orbit(
      id: map['id'] ?? 00,
      name: map['name'] ?? 'null',
      abbrev: map['abbrev'] ?? 'null',
    );
  }
}
