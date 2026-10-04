class VenueModel {
  final String id;
  final String ownerId;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final String status;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final List<String> images;
  final List<String> facilities;
  final List<CourtModel> courts;
  final String openTime;
  final String closeTime;
  final double distance;
  final DateTime createdAt;

  VenueModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.address,
    this.latitude = 0,
    this.longitude = 0,
    this.status = 'ACTIVE',
    this.rating = 0,
    this.reviewCount = 0,
    required this.imageUrl,
    this.images = const [],
    this.facilities = const [],
    this.courts = const [],
    this.openTime = '08:00',
    this.closeTime = '22:00',
    this.distance = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class CourtModel {
  final String id;
  final String venueId;
  final String sportId;
  final String sportName;
  final String name;
  final double pricePerHour;
  final String status;
  final String? imageUrl;

  CourtModel({
    required this.id,
    required this.venueId,
    required this.sportId,
    required this.sportName,
    required this.name,
    required this.pricePerHour,
    this.status = 'ACTIVE',
    this.imageUrl,
  });
}

class ScheduleSlot {
  final String id;
  final String courtId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final double price;
  final String status;

  ScheduleSlot({
    required this.id,
    required this.courtId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.price,
    this.status = 'AVAILABLE',
  });

  bool get isAvailable => status == 'AVAILABLE';
  bool get isBooked => status == 'BOOKED';
  bool get isBlocked => status == 'BLOCKED';
  bool get isHold => status == 'HOLD';
}
