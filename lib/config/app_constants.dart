class AppConstants {
  static const String appName = 'Lapangin';
  static const String appTagline = 'Sewa Lapangan Jadi Mudah';
  static const String appVersion = '1.0.0';

  // Currency
  static const String currency = 'Rp';
  static const String currencyCode = 'IDR';

  // Service Fee
  static const double serviceFee = 5000;

  // Booking
  static const int holdDurationMinutes = 15;
  static const int maxSlotsPerBooking = 5;

  // Cancellation Policy
  static const int fullRefundHours = 24;
  static const int halfRefundHours = 12;

  // Pagination
  static const int pageSize = 10;

  // Image
  static const String defaultAvatar = 'https://ui-avatars.com/api/?background=2563EB&color=fff&name=';
  static const String defaultVenueImage = 'https://images.unsplash.com/photo-1575361204480-aadea25e6e68?w=800';

  // Sports
  static const List<String> sportTypes = [
    'Futsal',
    'Badminton',
    'Basket',
    'Tenis',
    'Sepak Bola',
    'Voli',
  ];

  // Sport Icons (using Material Icons codepoints)
  static const Map<String, int> sportIcons = {
    'Futsal': 0xe559,      // sports_soccer
    'Badminton': 0xf05b5,  // sports
    'Basket': 0xe558,      // sports_basketball
    'Tenis': 0xe55c,       // sports_tennis
    'Sepak Bola': 0xe559,  // sports_soccer
    'Voli': 0xe55d,        // sports_volleyball
  };

  // Facilities
  static const List<String> facilityTypes = [
    'Parkir',
    'Toilet',
    'Mushola',
    'Kantin',
    'WiFi',
    'Shower',
    'Locker',
    'Ruang Tunggu',
  ];

  // Booking Status
  static const String statusPendingPayment = 'PENDING_PAYMENT';
  static const String statusPaymentSuccess = 'PAYMENT_SUCCESS';
  static const String statusConfirmed = 'CONFIRMED';
  static const String statusCheckedIn = 'CHECKED_IN';
  static const String statusCompleted = 'COMPLETED';
  static const String statusCancelled = 'CANCELLED';
  static const String statusExpired = 'EXPIRED';
  static const String statusRefunded = 'REFUNDED';

  // Schedule Status
  static const String slotAvailable = 'AVAILABLE';
  static const String slotBooked = 'BOOKED';
  static const String slotBlocked = 'BLOCKED';
  static const String slotHold = 'HOLD';

  // Payment Status
  static const String paymentPending = 'PENDING';
  static const String paymentPaid = 'PAID';
  static const String paymentFailed = 'FAILED';
  static const String paymentExpired = 'EXPIRED';
  static const String paymentRefunded = 'REFUNDED';

  // Venue Status
  static const String venuePending = 'PENDING';
  static const String venueActive = 'ACTIVE';
  static const String venueInactive = 'INACTIVE';
  static const String venueRejected = 'REJECTED';

  // User Roles
  static const String roleCustomer = 'CUSTOMER';
  static const String roleOwner = 'OWNER';
  static const String roleAdmin = 'ADMIN';

  // Payment Methods
  static const List<String> paymentMethods = [
    'QRIS',
    'Virtual Account',
    'GoPay',
    'OVO',
    'DANA',
    'ShopeePay',
  ];
}
