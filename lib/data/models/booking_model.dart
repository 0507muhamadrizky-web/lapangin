class BookingModel {
  final String id;
  final String userId;
  final String courtId;
  final String bookingCode;
  final String venueName;
  final String courtName;
  final String sportName;
  final String venueAddress;
  final String venueImage;
  final DateTime bookingDate;
  final String startTime;
  final String endTime;
  final int durationHours;
  final double pricePerHour;
  final double subtotal;
  final double serviceFee;
  final double discount;
  final double totalPrice;
  final String status;
  final String paymentStatus;
  final String? paymentMethod;
  final String? qrCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.courtId,
    required this.bookingCode,
    required this.venueName,
    required this.courtName,
    required this.sportName,
    required this.venueAddress,
    required this.venueImage,
    required this.bookingDate,
    required this.startTime,
    required this.endTime,
    required this.durationHours,
    required this.pricePerHour,
    required this.subtotal,
    this.serviceFee = 5000,
    this.discount = 0,
    required this.totalPrice,
    this.status = 'PENDING_PAYMENT',
    this.paymentStatus = 'PENDING',
    this.paymentMethod,
    this.qrCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  bool get isUpcoming =>
      status == 'CONFIRMED' && bookingDate.isAfter(DateTime.now());
  bool get isOngoing =>
      status == 'CHECKED_IN';
  bool get isCompleted => status == 'COMPLETED';
  bool get isCancelled => status == 'CANCELLED';
}

class PaymentModel {
  final String id;
  final String bookingId;
  final String paymentMethod;
  final String transactionId;
  final double amount;
  final String status;
  final DateTime? paidAt;

  PaymentModel({
    required this.id,
    required this.bookingId,
    required this.paymentMethod,
    required this.transactionId,
    required this.amount,
    this.status = 'PENDING',
    this.paidAt,
  });
}

class ReviewModel {
  final String id;
  final String bookingId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String venueId;
  final double rating;
  final String comment;
  final List<String> photos;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.venueId,
    required this.rating,
    required this.comment,
    this.photos = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
