class ChurchModel {
  final String name;
  final String city;
  final String province;
  final String country;
  final String description;
  final String mainImageUrl;
  final List<String> galleryImages;
  final String locationDetails;
  final String address;
  final String gpsLink;
  final String history;
  final List<String> publicFacilities;
  final String openingHours;
  final String ticketPrice;
  final double rating;
  final String interestingFacts;

  ChurchModel({
    required this.name,
    required this.city,
    required this.province,
    required this.country,
    required this.description,
    required this.mainImageUrl,
    required this.galleryImages,
    required this.locationDetails,
    required this.address,
    required this.gpsLink,
    required this.history,
    required this.publicFacilities,
    required this.openingHours,
    required this.ticketPrice,
    required this.rating,
    required this.interestingFacts,
  });
}
