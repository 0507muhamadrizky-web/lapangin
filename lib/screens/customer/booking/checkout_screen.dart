import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../config/app_theme.dart';
import '../../../data/providers/booking_provider.dart';
import '../../../data/providers/venue_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _voucherController = TextEditingController();

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final venue = context.read<VenueProvider>().selectedVenue!;
    final court = context.read<VenueProvider>().selectedCourt!;
    
    if (bookingProvider.selectedSlots.isEmpty) {
      return const Scaffold(body: Center(child: Text('Tidak ada jadwal dipilih')));
    }

    final date = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(bookingProvider.selectedDate!);
    final startTime = bookingProvider.selectedSlots.first.startTime;
    final endTime = bookingProvider.selectedSlots.last.endTime;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Venue Details Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          venue.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venue.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              court.name,
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(Icons.calendar_today, 'Tanggal', date),
                  const SizedBox(height: 12),
                  _buildDetailRow(Icons.access_time, 'Waktu', '$startTime - $endTime (${bookingProvider.totalDuration} Jam)'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Voucher Section
            Text(
              'Gunakan Voucher',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _voucherController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan kode voucher',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    bookingProvider.applyVoucher(_voucherController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Voucher diterapkan!')),
                    );
                  },
                  child: const Text('Terapkan'),
                ),
              ],
            ),
            if (bookingProvider.voucherCode != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.success, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Voucher ${bookingProvider.voucherCode} berhasil digunakan',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.success,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _voucherController.clear();
                        bookingProvider.removeVoucher();
                      },
                      child: Text(
                        'Hapus',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.error,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),

            // Payment Summary
            Text(
              'Ringkasan Pembayaran',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Harga (${bookingProvider.totalDuration} Jam)', bookingProvider.subtotal),
            const SizedBox(height: 12),
            _buildSummaryRow('Biaya Layanan', bookingProvider.serviceFee),
            if (bookingProvider.discountAmount > 0) ...[
              const SizedBox(height: 12),
              _buildSummaryRow('Diskon', -bookingProvider.discountAmount, isDiscount: true),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Pembayaran',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Rp${bookingProvider.totalPrice.toInt()}',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/payment');
                },
                child: const Text('Pilih Metode Pembayaran'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: isDiscount ? AppColors.success : AppColors.textSecondary,
          ),
        ),
        Text(
          '${isDiscount ? "-" : ""}Rp${amount.abs().toInt()}',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            color: isDiscount ? AppColors.success : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
