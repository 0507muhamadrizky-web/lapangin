import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../config/app_theme.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/providers/booking_provider.dart';

class BookingDetailScreen extends StatelessWidget {
  final String bookingId;

  const BookingDetailScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final booking = bookingProvider.bookings.firstWhere(
      (b) => b.id == bookingId,
      orElse: () => BookingModel(
        id: bookingId,
        userId: 'u1',
        courtId: 'c1',
        bookingCode: 'LPG-UNKNOWN',
        venueName: 'Lapangan Lapangin',
        courtName: 'Lapangan 1',
        sportName: 'Futsal',
        venueAddress: 'Jl. Pemuda No. 10, Jakarta Pusat',
        venueImage: 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800',
        bookingDate: DateTime.now(),
        startTime: '18:00',
        endTime: '20:00',
        durationHours: 2,
        pricePerHour: 150000,
        subtotal: 300000,
        serviceFee: 5000,
        discount: 0,
        totalPrice: 305000,
        status: 'CONFIRMED',
        paymentStatus: 'PAID',
        paymentMethod: 'QRIS',
        qrCode: 'LPG-UNKNOWN',
      ),
    );

    Color statusColor;
    String statusText;
    switch (booking.status) {
      case 'CONFIRMED':
      case 'PAYMENT_SUCCESS':
        statusColor = AppColors.success;
        statusText = 'Terkonfirmasi';
        break;
      case 'CHECKED_IN':
        statusColor = AppColors.info;
        statusText = 'Sedang Berjalan';
        break;
      case 'COMPLETED':
        statusColor = AppColors.textSecondary;
        statusText = 'Selesai';
        break;
      case 'CANCELLED':
      default:
        statusColor = AppColors.error;
        statusText = 'Dibatalkan';
        break;
    }

    final formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(booking.bookingDate);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Detail Pemesanan',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // E-Ticket Card with QR Code
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Upper Ticket Section (Venue Info & QR)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'E-TIKET LAPANGIN',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  booking.bookingCode,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                statusText,
                                style: GoogleFonts.plusJakartaSans(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // QR Code Container
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: QrImageView(
                            data: booking.bookingCode,
                            version: QrVersions.auto,
                            size: 180.0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tunjukkan QR ini ke petugas lapangan saat check-in',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Ticket Perforated Divider
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          border: Border.all(color: AppColors.border),
                        ),
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                (constraints.constrainWidth() / 10).floor(),
                                (_) => const SizedBox(
                                  width: 5,
                                  height: 1.5,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: AppColors.border),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 16,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          border: Border.all(color: AppColors.border),
                        ),
                      ),
                    ],
                  ),

                  // Lower Ticket Section (Booking Details)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailItem('Venue', booking.venueName, isBold: true),
                        const SizedBox(height: 14),
                        _buildDetailItem('Lapangan & Olahraga', '${booking.courtName} • ${booking.sportName}'),
                        const SizedBox(height: 14),
                        _buildDetailItem('Tanggal', formattedDate),
                        const SizedBox(height: 14),
                        _buildDetailItem('Waktu Main', '${booking.startTime} - ${booking.endTime} (${booking.durationHours} Jam)'),
                        const SizedBox(height: 14),
                        _buildDetailItem('Lokasi', booking.venueAddress),
                        const Divider(height: 28),
                        _buildDetailItem('Metode Pembayaran', booking.paymentMethod ?? 'QRIS'),
                        const SizedBox(height: 14),
                        _buildDetailItem(
                          'Total Biaya',
                          'Rp${booking.totalPrice.toInt()}',
                          isHighlight: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Actions
            if (booking.status == 'CONFIRMED' || booking.status == 'PAYMENT_SUCCESS')
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Batalkan Booking?'),
                        content: const Text(
                          'Apakah Anda yakin ingin membatalkan pemesanan ini? Pembatalan sesuai syarat & ketentuan yang berlaku.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Kembali'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                            onPressed: () async {
                              Navigator.pop(ctx);
                              await bookingProvider.cancelBooking(booking.id);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Pemesanan berhasil dibatalkan')),
                                );
                              }
                            },
                            child: const Text('Ya, Batalkan'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.cancel_outlined, color: AppColors.error),
                  label: const Text('Batalkan Booking', style: TextStyle(color: AppColors.error)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/home'),
                icon: const Icon(Icons.home),
                label: const Text('Kembali ke Beranda'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, {bool isBold = false, bool isHighlight = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isHighlight ? 16 : 14,
              fontWeight: isHighlight || isBold ? FontWeight.w800 : FontWeight.w600,
              color: isHighlight ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
