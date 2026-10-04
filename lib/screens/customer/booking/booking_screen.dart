import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../config/app_theme.dart';
import '../../../data/providers/venue_provider.dart';
import '../../../data/providers/booking_provider.dart';

class BookingScreen extends StatefulWidget {
  final String venueId;

  const BookingScreen({super.key, required this.venueId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().setSelectedDate(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final venueProvider = context.watch<VenueProvider>();
    final bookingProvider = context.watch<BookingProvider>();
    final court = venueProvider.selectedCourt;
    
    if (court == null) return const Scaffold(body: Center(child: Text('Error: Lapangan tidak dipilih')));

    final slots = venueProvider.getScheduleSlots(court.id, _selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Pilih Jadwal'),
            Text(
              court.name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Date Selector
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 14, // Next 14 days
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  final isSelected = date.day == _selectedDate.day && 
                                   date.month == _selectedDate.month;

                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedDate = date);
                      bookingProvider.setSelectedDate(date);
                    },
                    child: Container(
                      width: 64,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(date).toUpperCase(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date.day.toString(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Legends
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem(AppColors.surface, 'Tersedia', true),
                _buildLegendItem(AppColors.primary, 'Dipilih', false),
                _buildLegendItem(AppColors.divider, 'Penuh', false),
              ],
            ),
          ),

          // Time Slots
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: slots.length,
              itemBuilder: (context, index) {
                final slot = slots[index];
                final isSelected = bookingProvider.isSlotSelected(slot.id);
                
                Color bgColor = AppColors.surface;
                Color textColor = AppColors.textPrimary;
                Color borderColor = AppColors.border;
                
                if (!slot.isAvailable) {
                  bgColor = AppColors.background;
                  textColor = AppColors.textTertiary;
                  borderColor = AppColors.divider;
                } else if (isSelected) {
                  bgColor = AppColors.primary;
                  textColor = Colors.white;
                  borderColor = AppColors.primary;
                }

                return GestureDetector(
                  onTap: () => bookingProvider.toggleSlot(slot),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: borderColor),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${slot.startTime} - ${slot.endTime}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                        decoration: !slot.isAvailable ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Bar
          if (bookingProvider.selectedSlots.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total (${bookingProvider.totalDuration} Jam)',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Rp${bookingProvider.subtotal.toInt()}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/checkout');
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, bool hasBorder) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: hasBorder ? Border.all(color: AppColors.border) : null,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
