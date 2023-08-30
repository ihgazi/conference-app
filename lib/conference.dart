class Conference {
  final int id;
  final String title;
  final String description;
  final String bannerImage;
  final String dateTime;
  final String organiserName;
  final String organiserIcon;
  final String venueName;
  final String venueCity;
  final String venueCountry;

  Conference({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.dateTime,
    required this.organiserName,
    required this.organiserIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  // Create Conference class using data from json file
  factory Conference.fromJson(Map<String, dynamic> json) {
    return Conference(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      bannerImage: json['banner_image'],
      dateTime: json['date_time'],
      organiserName: json['organiser_name'],
      organiserIcon: json['organiser_icon'],
      venueName: json['venue_name'],
      venueCity: json['venue_city'],
      venueCountry: json['venue_country'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "bannerImage": bannerImage,
    "date_Time": dateTime,
    "organiser_name": organiserName,
    "organiser_icon": organiserIcon,
    "venue_name": venueName,
    "venue_city": venueCity,
    "venue_country": venueCountry
  };
}
