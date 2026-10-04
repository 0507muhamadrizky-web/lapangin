import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../data/providers/venue_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final venueProvider = context.watch<VenueProvider>();
    final results = venueProvider.searchResults;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Lapangan'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => venueProvider.searchVenues(value),
                  decoration: InputDecoration(
                    hintText: 'Nama lapangan, lokasi, atau olahraga...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              venueProvider.searchVenues('');
                            },
                          )
                        : null,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    _buildFilterChip(
                      'Semua',
                      venueProvider.selectedSport.isEmpty,
                      () => venueProvider.filterBySport(''),
                    ),
                    ...AppConstants.sportTypes.map((sport) => _buildFilterChip(
                          sport,
                          venueProvider.selectedSport == sport,
                          () => venueProvider.filterBySport(sport),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: results.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: AppColors.textTertiary),
                  const SizedBox(height: 16),
                  Text(
                    'Lapangan tidak ditemukan',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final venue = results[index];
                return GestureDetector(
                  onTap: () {
                    venueProvider.selectVenue(venue.id);
                    context.push('/venue/${venue.id}');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            venue.imageUrl,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      venue.name,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: AppColors.warning, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        venue.rating.toString(),
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16, color: AppColors.textTertiary),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      '${venue.distance} km • ${venue.address}',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textSecondary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    spacing: 8,
                                    children: venue.courts
                                        .map((c) => c.sportName)
                                        .toSet()
                                        .take(2)
                                        .map((sport) => Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: AppColors.primarySurface,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                sport,
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 12,
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  Text(
                                    'Mulai Rp${venue.courts.first.pricePerHour.toInt()}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
