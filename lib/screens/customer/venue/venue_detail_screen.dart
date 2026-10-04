import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/app_theme.dart';
import '../../../data/providers/venue_provider.dart';

class VenueDetailScreen extends StatelessWidget {
  final String venueId;

  const VenueDetailScreen({super.key, required this.venueId});

  @override
  Widget build(BuildContext context) {
    final venueProvider = context.watch<VenueProvider>();
    final venue = venueProvider.venues.firstWhere((v) => v.id == venueId, orElse: () => venueProvider.venues.first);
    final isFavorite = venueProvider.isFavorite(venue.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                venue.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? AppColors.error : AppColors.textPrimary,
                    size: 20,
                  ),
                ),
                onPressed: () => venueProvider.toggleFavorite(venue),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          venue.name,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: AppColors.warning, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${venue.rating}',
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w700,
                                color: AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          venue.address,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Facilities
                  Text(
                    'Fasilitas',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: venue.facilities.map((f) => _buildFacilityChip(f)).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Deskripsi',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    venue.description,
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Courts
                  Text(
                    'Pilih Lapangan',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...venue.courts.map((court) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      title: Text(
                        court.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        court.sportName,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          venueProvider.selectCourt(court);
                          context.push('/booking/${venue.id}');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: const Text('Booking'),
                      ),
                    ),
                  )).toList(),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityChip(String label) {
    IconData getIcon() {
      switch (label.toLowerCase()) {
        case 'parkir': return Icons.local_parking;
        case 'toilet': return Icons.wc;
        case 'mushola': return Icons.mosque;
        case 'kantin': return Icons.restaurant;
        case 'wifi': return Icons.wifi;
        case 'shower': return Icons.shower;
        default: return Icons.check_circle_outline;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(getIcon(), size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
