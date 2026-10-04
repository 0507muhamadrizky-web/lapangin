import 'package:flutter/material.dart';

class BookingDetailScreen extends StatelessWidget {
  final String bookingId;
  const BookingDetailScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesanan')),
      body: Center(child: Text('Detail Booking $bookingId (Dalam Pengembangan)')),
    );
  }
}
