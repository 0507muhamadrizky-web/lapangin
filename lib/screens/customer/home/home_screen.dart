import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/providers/venue_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VenueProvider>().loadVenues();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final venueProvider = context.watch<VenueProvider>();

    return Scaffold(
      body: SafeArea(
        child: venueProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(user?.name ?? 'Guest'),
                    _buildSearchBar(context),
                    _buildCategories(),
                    _buildSectionTitle('Populer di Semarang', () {
                      context.go('/search');
                    }),
                    _buildHorizontalVenueList(venueProvider.popularVenues),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Terdekat dari Lokasimu', () {
                      context.go('/search');
                    }),
                    _buildVerticalVenueList(venueProvider.nearbyVenues),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader(String name) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, $name 👋',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    'Semarang, Jawa Tengah',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(AppConstants.defaultAvatar + name),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: () {
          context.go('/search');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: AppColors.textTertiary),
              const SizedBox(width: 12),
              Text(
                'Cari "Futsal Semarang"',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textTertiary,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.tune, color: AppColors.primary, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Kategori Olahraga',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.sportTypes.length,
              itemBuilder: (context, index) {
                final sport = AppConstants.sportTypes[index];
                return _buildCategoryItem(
                  sport,
                  IconData(AppConstants.sportIcons[sport]!, fontFamily: 'MaterialIcons'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          // Navigasi ke search dengan filter
          context.read<VenueProvider>().filterBySport(title);
          context.go('/search');
        },
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'Lihat Semua',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalVenueList(List venues) {
    if (venues.isEmpty) return const SizedBox();
    
    return SizedBox(
      height: 260,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                context.read<VenueProvider>().selectVenue(venue.id);
                context.push('/venue/${venue.id}');
              },
              child: Container(
                width: 240,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(
                        venue.imageUrl,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.warning, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${venue.rating} (${venue.reviewCount})',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            venue.name,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rp${venue.courts.first.pricePerHour.toInt()} / Jam',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalVenueList(List venues) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: venues.length,
      itemBuilder: (context, index) {
        final venue = venues[index];
        return GestureDetector(
          onTap: () {
            context.read<VenueProvider>().selectVenue(venue.id);
            context.push('/venue/${venue.id}');
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    venue.imageUrl,
                    width: 100,
                    height: 100,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: AppColors.textTertiary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${venue.distance} km • ${venue.address}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: AppColors.textTertiary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.warning, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${venue.rating}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Mulai Rp${venue.courts.first.pricePerHour.toInt()}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
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
    );
  }
}
