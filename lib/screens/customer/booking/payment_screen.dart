import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/providers/booking_provider.dart';
import '../../../data/providers/venue_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  void _processPayment() async {
    final bookingProvider = context.read<BookingProvider>();
    final venueProvider = context.read<VenueProvider>();
    final authProvider = context.read<AuthProvider>();

    if (bookingProvider.selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih metode pembayaran terlebih dahulu')),
      );
      return;
    }

    final venue = venueProvider.selectedVenue!;
    final court = venueProvider.selectedCourt!;

    await bookingProvider.createBooking(
      userId: authProvider.currentUser!.id,
      courtId: court.id,
      venueName: venue.name,
      courtName: court.name,
      sportName: court.sportName,
      venueAddress: venue.address,
      venueImage: venue.imageUrl,
    );

    if (mounted) {
      context.go('/booking-success');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: bookingProvider.isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Memproses Pembayaran...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: AppColors.heroGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total Pembayaran',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rp${bookingProvider.totalPrice.toInt()}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Pilih Metode Pembayaran',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...AppConstants.paymentMethods.map((method) {
                    final isSelected = bookingProvider.selectedPaymentMethod == method;
                    return GestureDetector(
                      onTap: () => bookingProvider.setPaymentMethod(method),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              method == 'QRIS'
                                  ? Icons.qr_code_2
                                  : method.contains('Virtual')
                                      ? Icons.account_balance
                                      : Icons.account_balance_wallet,
                              color: isSelected ? AppColors.primary : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              method,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              const Icon(Icons.check_circle, color: AppColors.primary),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _processPayment,
                      child: const Text('Bayar Sekarang'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
