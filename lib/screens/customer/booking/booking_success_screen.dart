import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/app_theme.dart';
import '../../../data/providers/booking_provider.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.read<BookingProvider>().currentBooking;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 80,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Booking Berhasil!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Pembayaran telah diterima dan booking Anda di ${booking?.venueName ?? "Lapangan"} telah dikonfirmasi.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking ID',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          booking?.bookingCode ?? '-',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.copy, color: AppColors.primary, size: 20),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/my-bookings');
                  },
                  child: const Text('Lihat Tiket & QR Code'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  child: const Text('Kembali ke Beranda'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
