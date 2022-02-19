class Space {
  int id;
  String name;
  String imageUrl;
  int price;
  String city;
  String country;
  int rating;
  String address;
  String phone;
  String mapUrl;
  List photos;
  int numberOfKitchens;
  int numberOfBedrooms;
  int numberOfCupboards;

  Space({
    required this.city,
    required this.country,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.address,
    required this.mapUrl,
    required this.numberOfBedrooms,
    required this.numberOfCupboards,
    required this.numberOfKitchens,
    required this.phone,
    required this.photos,
  });

  factory Space.fromJson(json) => Space(
      city: json['city'],
      country: json['country'],
      id: json['id'],
      imageUrl: json['image_url'],
      name: json['name'],
      price: json['price'],
      rating: json['rating'],
      address: json['address'],
      mapUrl: json['map_url'],
      numberOfBedrooms: json['number_of_cupboards'],
      numberOfCupboards: json['number_of_cupboards'],
      numberOfKitchens: json['number_of_kitchens'],
      phone: json['phone'],
      photos: json['photos'],
  );

}