import 'package:flutter/material.dart';
import '../models/venue_model.dart';
import '../mock_data.dart';

class VenueProvider extends ChangeNotifier {
  List<VenueModel> _venues = [];
  List<VenueModel> _searchResults = [];
  List<VenueModel> _favorites = [];
  VenueModel? _selectedVenue;
  CourtModel? _selectedCourt;
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedSport = '';

  List<VenueModel> get venues => _venues;
  List<VenueModel> get searchResults => _searchResults;
  List<VenueModel> get favorites => _favorites;
  VenueModel? get selectedVenue => _selectedVenue;
  CourtModel? get selectedCourt => _selectedCourt;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get selectedSport => _selectedSport;

  List<VenueModel> get popularVenues {
    final sorted = List<VenueModel>.from(_venues);
    sorted.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    return sorted.take(5).toList();
  }

  List<VenueModel> get nearbyVenues {
    final sorted = List<VenueModel>.from(_venues);
    sorted.sort((a, b) => a.distance.compareTo(b.distance));
    return sorted.take(5).toList();
  }

  Future<void> loadVenues() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));
    _venues = MockData.venues;

    _isLoading = false;
    notifyListeners();
  }

  void searchVenues(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _searchResults = _venues;
    } else {
      _searchResults = _venues.where((v) {
        return v.name.toLowerCase().contains(query.toLowerCase()) ||
            v.address.toLowerCase().contains(query.toLowerCase()) ||
            v.courts.any((c) =>
                c.sportName.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    }
    notifyListeners();
  }

  void filterBySport(String sport) {
    _selectedSport = sport;
    if (sport.isEmpty) {
      _searchResults = _venues;
    } else {
      _searchResults = _venues.where((v) {
        return v.courts.any(
            (c) => c.sportName.toLowerCase() == sport.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void selectVenue(String venueId) {
    _selectedVenue = _venues.firstWhere((v) => v.id == venueId);
    notifyListeners();
  }

  void selectCourt(CourtModel court) {
    _selectedCourt = court;
    notifyListeners();
  }

  void toggleFavorite(VenueModel venue) {
    if (_favorites.any((v) => v.id == venue.id)) {
      _favorites.removeWhere((v) => v.id == venue.id);
    } else {
      _favorites.add(venue);
    }
    notifyListeners();
  }

  bool isFavorite(String venueId) {
    return _favorites.any((v) => v.id == venueId);
  }

  List<ScheduleSlot> getScheduleSlots(String courtId, DateTime date) {
    final court = _venues
        .expand((v) => v.courts)
        .firstWhere((c) => c.id == courtId);
    return MockData.generateSlots(courtId, date, court.pricePerHour);
  }
}
