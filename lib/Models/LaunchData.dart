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
  // Map status;
  String lastUpdated;
  String net;
  String windowEnd;
  String windowStart;
  // var probability;
  String holdReason;
  String failReason;
  // var hashtag;
  // Map launchServiceProvider;
  // Map rocket;
  // Map mission;
  // Map pad;
  bool webcastLive;
  String image;
  var infographic;
  // List program;

  LaunchData({
    required this.id,
    required this.url,
    required this.slug,
    required this.name,
    // required this.status,
    required this.lastUpdated,
    required this.net,
    required this.windowEnd,
    required this.windowStart,
    required this.failReason,
    // required this.hashtag,
    required this.holdReason,
    required this.image,
    required this.infographic,
    // required this.launchServiceProvider,
    // required this.mission,
    // required this.pad,
    // required this.probability,
    // required this.program,
    // required this.rocket,
    required this.webcastLive,
  });

  factory LaunchData.fromMap(Map map) {
    return LaunchData(
      id: map['id'],
      url: map['url'],
      slug: map['slug'],
      name: map['name'],
      // status: map['status'],
      lastUpdated: map['last_updated'],
      net: map['net'],
      windowEnd: map['window_end'],
      windowStart: map['window_start'],
      // probability: map['probability'],
      holdReason: map['holdreason'],
      failReason: map['failreason'],
      // hashtag: map['hashtag'],
      // launchServiceProvider: map['launch_service_provider'],
      // rocket: map['rocket'],
      // mission: map['mission'],
      // pad: map['pad'],
      webcastLive: map['webcast_live'],
      image: map['image'],
      infographic: map['infographic'],
      // program: map['program'],
    );
  }
}
