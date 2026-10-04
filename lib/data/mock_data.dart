import 'models/venue_model.dart';
import 'models/booking_model.dart';
import 'models/user_model.dart';

class MockData {
  // Mock Users
  static final List<UserModel> users = [
    UserModel(
      id: 'u1',
      name: 'Andi Pratama',
      email: 'andi@email.com',
      phone: '081234567890',
      role: 'CUSTOMER',
    ),
    UserModel(
      id: 'u2',
      name: 'Budi Santoso',
      email: 'budi@email.com',
      phone: '081234567891',
      role: 'OWNER',
    ),
    UserModel(
      id: 'u3',
      name: 'Admin Lapangin',
      email: 'admin@lapangin.com',
      phone: '081234567892',
      role: 'ADMIN',
    ),
  ];

  // Mock Venues
  static final List<VenueModel> venues = [
    VenueModel(
      id: 'v1',
      ownerId: 'u2',
      name: 'Arena Futsal Semarang',
      description: 'Arena futsal terbaik di Semarang dengan fasilitas lengkap dan lapangan standar internasional. Tersedia 4 lapangan dengan rumput sintetis berkualitas tinggi.',
      address: 'Jl. Pemuda No. 45, Semarang Tengah',
      latitude: -6.9666,
      longitude: 110.4196,
      rating: 4.8,
      reviewCount: 256,
      imageUrl: 'https://images.unsplash.com/photo-1577223625816-7546f13df25d?w=800',
      images: [
        'https://images.unsplash.com/photo-1577223625816-7546f13df25d?w=800',
        'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800',
        'https://images.unsplash.com/photo-1551958219-acbc608c6377?w=800',
      ],
      facilities: ['Parkir', 'Toilet', 'Mushola', 'Kantin', 'WiFi', 'Shower', 'Locker'],
      openTime: '08:00',
      closeTime: '23:00',
      distance: 1.2,
      courts: [
        CourtModel(
          id: 'c1',
          venueId: 'v1',
          sportId: 's1',
          sportName: 'Futsal',
          name: 'Lapangan A',
          pricePerHour: 100000,
        ),
        CourtModel(
          id: 'c2',
          venueId: 'v1',
          sportId: 's1',
          sportName: 'Futsal',
          name: 'Lapangan B',
          pricePerHour: 120000,
        ),
      ],
    ),
    VenueModel(
      id: 'v2',
      ownerId: 'u2',
      name: 'Galaxy Badminton Center',
      description: 'Pusat badminton dengan 6 lapangan berstandar BWF. Dilengkapi dengan sistem pencahayaan profesional dan lantai kayu maple.',
      address: 'Jl. Pandanaran No. 88, Semarang',
      latitude: -6.9823,
      longitude: 110.4102,
      rating: 4.6,
      reviewCount: 189,
      imageUrl: 'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=800',
      images: [
        'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=800',
        'https://images.unsplash.com/photo-1613918431703-aa50889e3be5?w=800',
      ],
      facilities: ['Parkir', 'Toilet', 'Mushola', 'Kantin', 'WiFi', 'Ruang Tunggu'],
      openTime: '07:00',
      closeTime: '22:00',
      distance: 2.5,
      courts: [
        CourtModel(
          id: 'c3',
          venueId: 'v2',
          sportId: 's2',
          sportName: 'Badminton',
          name: 'Court 1',
          pricePerHour: 75000,
        ),
        CourtModel(
          id: 'c4',
          venueId: 'v2',
          sportId: 's2',
          sportName: 'Badminton',
          name: 'Court 2',
          pricePerHour: 75000,
        ),
        CourtModel(
          id: 'c5',
          venueId: 'v2',
          sportId: 's2',
          sportName: 'Badminton',
          name: 'Court VIP',
          pricePerHour: 100000,
        ),
      ],
    ),
    VenueModel(
      id: 'v3',
      ownerId: 'u2',
      name: 'Semarang Basketball Arena',
      description: 'Arena basket outdoor dan indoor dengan lapangan berstandar FIBA. Cocok untuk latihan tim maupun bermain santai.',
      address: 'Jl. Sisingamangaraja No. 12, Semarang',
      latitude: -6.9956,
      longitude: 110.4234,
      rating: 4.5,
      reviewCount: 120,
      imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
      images: [
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
        'https://images.unsplash.com/photo-1559692048-79a3f837883d?w=800',
      ],
      facilities: ['Parkir', 'Toilet', 'Kantin', 'WiFi'],
      openTime: '06:00',
      closeTime: '22:00',
      distance: 3.1,
      courts: [
        CourtModel(
          id: 'c6',
          venueId: 'v3',
          sportId: 's3',
          sportName: 'Basket',
          name: 'Full Court Indoor',
          pricePerHour: 150000,
        ),
        CourtModel(
          id: 'c7',
          venueId: 'v3',
          sportId: 's3',
          sportName: 'Basket',
          name: 'Half Court Outdoor',
          pricePerHour: 80000,
        ),
      ],
    ),
    VenueModel(
      id: 'v4',
      ownerId: 'u2',
      name: 'Tennis Club Semarang',
      description: 'Klub tenis premium dengan 3 lapangan keras dan 2 lapangan tanah liat. Tersedia pelatih profesional dan penyewaan raket.',
      address: 'Jl. Diponegoro No. 67, Semarang',
      latitude: -6.9789,
      longitude: 110.4301,
      rating: 4.9,
      reviewCount: 87,
      imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8?w=800',
      images: [
        'https://images.unsplash.com/photo-1554068865-24cecd4e34b8?w=800',
      ],
      facilities: ['Parkir', 'Toilet', 'Mushola', 'Shower', 'Locker', 'Ruang Tunggu'],
      openTime: '06:00',
      closeTime: '21:00',
      distance: 1.8,
      courts: [
        CourtModel(
          id: 'c8',
          venueId: 'v4',
          sportId: 's4',
          sportName: 'Tenis',
          name: 'Hard Court 1',
          pricePerHour: 120000,
        ),
      ],
    ),
    VenueModel(
      id: 'v5',
      ownerId: 'u2',
      name: 'Simpang Lima Soccer Field',
      description: 'Lapangan sepak bola rumput sintetis dengan ukuran standar FIFA. Cocok untuk pertandingan antar komunitas.',
      address: 'Jl. Ahmad Yani No. 100, Semarang',
      latitude: -6.9855,
      longitude: 110.4198,
      rating: 4.3,
      reviewCount: 65,
      imageUrl: 'https://images.unsplash.com/photo-1575361204480-aadea25e6e68?w=800',
      images: [
        'https://images.unsplash.com/photo-1575361204480-aadea25e6e68?w=800',
      ],
      facilities: ['Parkir', 'Toilet', 'Kantin', 'WiFi'],
      openTime: '06:00',
      closeTime: '22:00',
      distance: 4.0,
      courts: [
        CourtModel(
          id: 'c9',
          venueId: 'v5',
          sportId: 's5',
          sportName: 'Sepak Bola',
          name: 'Lapangan Utama',
          pricePerHour: 500000,
        ),
      ],
    ),
    VenueModel(
      id: 'v6',
      ownerId: 'u2',
      name: 'Voli Mania Center',
      description: 'Pusat olahraga voli dengan lapangan indoor berstandar PBVSI. Tersedia net dan bola voli.',
      address: 'Jl. Gajah Mada No. 23, Semarang',
      latitude: -6.9712,
      longitude: 110.4156,
      rating: 4.4,
      reviewCount: 42,
      imageUrl: 'https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?w=800',
      images: [
        'https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?w=800',
      ],
      facilities: ['Parkir', 'Toilet', 'Mushola', 'WiFi'],
      openTime: '07:00',
      closeTime: '22:00',
      distance: 2.0,
      courts: [
        CourtModel(
          id: 'c10',
          venueId: 'v6',
          sportId: 's6',
          sportName: 'Voli',
          name: 'Court Indoor',
          pricePerHour: 90000,
        ),
      ],
    ),
  ];

  // Mock Schedule Slots
  static List<ScheduleSlot> generateSlots(String courtId, DateTime date, double basePrice) {
    final slots = <ScheduleSlot>[];
    for (int hour = 8; hour < 23; hour++) {
      double price = basePrice;
      if (hour >= 16 && hour < 22) {
        price = basePrice * 1.5; // Peak hours
      } else if (hour >= 12 && hour < 16) {
        price = basePrice * 1.1;
      }

      String status = 'AVAILABLE';
      // Simulate some booked/blocked slots
      if (hour == 10 || hour == 14 || hour == 19) {
        status = 'BOOKED';
      }
      if (hour == 12) {
        status = 'BLOCKED';
      }

      slots.add(ScheduleSlot(
        id: '${courtId}_${date.toIso8601String()}_$hour',
        courtId: courtId,
        date: date,
        startTime: '${hour.toString().padLeft(2, '0')}:00',
        endTime: '${(hour + 1).toString().padLeft(2, '0')}:00',
        price: price,
        status: status,
      ));
    }
    return slots;
  }

  // Mock Bookings
  static final List<BookingModel> bookings = [
    BookingModel(
      id: 'b1',
      userId: 'u1',
      courtId: 'c1',
      bookingCode: 'LPG-260926-00125',
      venueName: 'Arena Futsal Semarang',
      courtName: 'Lapangan A',
      sportName: 'Futsal',
      venueAddress: 'Jl. Pemuda No. 45, Semarang Tengah',
      venueImage: 'https://images.unsplash.com/photo-1577223625816-7546f13df25d?w=800',
      bookingDate: DateTime.now().add(const Duration(days: 2)),
      startTime: '19:00',
      endTime: '21:00',
      durationHours: 2,
      pricePerHour: 100000,
      subtotal: 200000,
      serviceFee: 5000,
      totalPrice: 205000,
      status: 'CONFIRMED',
      paymentStatus: 'PAID',
      paymentMethod: 'QRIS',
      qrCode: 'LPG-260926-00125',
    ),
    BookingModel(
      id: 'b2',
      userId: 'u1',
      courtId: 'c3',
      bookingCode: 'LPG-260925-00124',
      venueName: 'Galaxy Badminton Center',
      courtName: 'Court 1',
      sportName: 'Badminton',
      venueAddress: 'Jl. Pandanaran No. 88, Semarang',
      venueImage: 'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=800',
      bookingDate: DateTime.now().subtract(const Duration(days: 1)),
      startTime: '17:00',
      endTime: '19:00',
      durationHours: 2,
      pricePerHour: 75000,
      subtotal: 150000,
      serviceFee: 5000,
      totalPrice: 155000,
      status: 'COMPLETED',
      paymentStatus: 'PAID',
      paymentMethod: 'GoPay',
      qrCode: 'LPG-260925-00124',
    ),
    BookingModel(
      id: 'b3',
      userId: 'u1',
      courtId: 'c6',
      bookingCode: 'LPG-260924-00123',
      venueName: 'Semarang Basketball Arena',
      courtName: 'Full Court Indoor',
      sportName: 'Basket',
      venueAddress: 'Jl. Sisingamangaraja No. 12, Semarang',
      venueImage: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
      bookingDate: DateTime.now().subtract(const Duration(days: 5)),
      startTime: '08:00',
      endTime: '10:00',
      durationHours: 2,
      pricePerHour: 150000,
      subtotal: 300000,
      serviceFee: 5000,
      totalPrice: 305000,
      status: 'COMPLETED',
      paymentStatus: 'PAID',
      paymentMethod: 'DANA',
      qrCode: 'LPG-260924-00123',
    ),
  ];

  // Mock Reviews
  static final List<ReviewModel> reviews = [
    ReviewModel(
      id: 'r1',
      bookingId: 'b2',
      userId: 'u1',
      userName: 'Andi Pratama',
      venueId: 'v2',
      rating: 5,
      comment: 'Lapangan sangat bersih dan terawat. Shuttle cock juga tersedia untuk dipinjam. Recommended!',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ReviewModel(
      id: 'r2',
      bookingId: 'b3',
      userId: 'u1',
      userName: 'Dewi Sartika',
      venueId: 'v1',
      rating: 4,
      comment: 'Lapangan bagus, tapi area parkir agak sempit kalau weekend.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ReviewModel(
      id: 'r3',
      bookingId: 'b3',
      userId: 'u1',
      userName: 'Rudi Hermawan',
      venueId: 'v1',
      rating: 5,
      comment: 'The best futsal arena in Semarang! Rumput sintetisnya nyaman banget.',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];
}
