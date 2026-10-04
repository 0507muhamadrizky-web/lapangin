import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../models/venue_model.dart';
import '../mock_data.dart';
import '../../config/app_constants.dart';
import 'package:uuid/uuid.dart';

class BookingProvider extends ChangeNotifier {
  List<BookingModel> _bookings = [];
  BookingModel? _currentBooking;
  bool _isLoading = false;

  // Booking flow state
  DateTime? _selectedDate;
  List<ScheduleSlot> _selectedSlots = [];
  String? _selectedPaymentMethod;
  String? _voucherCode;
  double _discountAmount = 0;

  List<BookingModel> get bookings => _bookings;
  BookingModel? get currentBooking => _currentBooking;
  bool get isLoading => _isLoading;
  DateTime? get selectedDate => _selectedDate;
  List<ScheduleSlot> get selectedSlots => _selectedSlots;
  String? get selectedPaymentMethod => _selectedPaymentMethod;
  String? get voucherCode => _voucherCode;
  double get discountAmount => _discountAmount;

  int get totalDuration => _selectedSlots.length;
  double get subtotal => _selectedSlots.fold(0, (sum, s) => sum + s.price);
  double get serviceFee => AppConstants.serviceFee;
  double get totalPrice => subtotal + serviceFee - _discountAmount;

  List<BookingModel> get upcomingBookings => _bookings
      .where((b) => b.status == 'CONFIRMED' || b.status == 'PAYMENT_SUCCESS')
      .toList();

  List<BookingModel> get ongoingBookings => _bookings
      .where((b) => b.status == 'CHECKED_IN')
      .toList();

  List<BookingModel> get completedBookings => _bookings
      .where((b) => b.status == 'COMPLETED')
      .toList();

  List<BookingModel> get cancelledBookings => _bookings
      .where((b) => b.status == 'CANCELLED' || b.status == 'EXPIRED')
      .toList();

  Future<void> loadBookings() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _bookings = List.from(MockData.bookings);

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _selectedSlots.clear();
    notifyListeners();
  }

  void toggleSlot(ScheduleSlot slot) {
    if (!slot.isAvailable) return;

    if (_selectedSlots.any((s) => s.id == slot.id)) {
      _selectedSlots.removeWhere((s) => s.id == slot.id);
    } else {
      if (_selectedSlots.length < AppConstants.maxSlotsPerBooking) {
        _selectedSlots.add(slot);
      }
    }
    // Sort by start time
    _selectedSlots.sort((a, b) => a.startTime.compareTo(b.startTime));
    notifyListeners();
  }

  bool isSlotSelected(String slotId) {
    return _selectedSlots.any((s) => s.id == slotId);
  }

  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void applyVoucher(String code) {
    _voucherCode = code;
    // Mock voucher discount
    if (code.toUpperCase() == 'LAPANGIN10') {
      _discountAmount = subtotal * 0.1;
      if (_discountAmount > 20000) _discountAmount = 20000;
    } else {
      _discountAmount = 0;
    }
    notifyListeners();
  }

  void removeVoucher() {
    _voucherCode = null;
    _discountAmount = 0;
    notifyListeners();
  }

  Future<BookingModel> createBooking({
    required String userId,
    required String courtId,
    required String venueName,
    required String courtName,
    required String sportName,
    required String venueAddress,
    required String venueImage,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    final uuid = const Uuid();
    final bookingCode = 'LPG-${DateTime.now().day.toString().padLeft(2, '0')}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().year.toString().substring(2)}-${(_bookings.length + 1).toString().padLeft(5, '0')}';

    final booking = BookingModel(
      id: uuid.v4(),
      userId: userId,
      courtId: courtId,
      bookingCode: bookingCode,
      venueName: venueName,
      courtName: courtName,
      sportName: sportName,
      venueAddress: venueAddress,
      venueImage: venueImage,
      bookingDate: _selectedDate!,
      startTime: _selectedSlots.first.startTime,
      endTime: _selectedSlots.last.endTime,
      durationHours: totalDuration,
      pricePerHour: _selectedSlots.first.price,
      subtotal: subtotal,
      serviceFee: serviceFee,
      discount: _discountAmount,
      totalPrice: totalPrice,
      status: 'CONFIRMED',
      paymentStatus: 'PAID',
      paymentMethod: _selectedPaymentMethod,
      qrCode: bookingCode,
    );

    _bookings.insert(0, booking);
    _currentBooking = booking;

    // Reset booking flow
    _selectedSlots.clear();
    _selectedDate = null;
    _selectedPaymentMethod = null;
    _voucherCode = null;
    _discountAmount = 0;

    _isLoading = false;
    notifyListeners();
    return booking;
  }

  Future<void> cancelBooking(String bookingId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      final old = _bookings[index];
      _bookings[index] = BookingModel(
        id: old.id,
        userId: old.userId,
        courtId: old.courtId,
        bookingCode: old.bookingCode,
        venueName: old.venueName,
        courtName: old.courtName,
        sportName: old.sportName,
        venueAddress: old.venueAddress,
        venueImage: old.venueImage,
        bookingDate: old.bookingDate,
        startTime: old.startTime,
        endTime: old.endTime,
        durationHours: old.durationHours,
        pricePerHour: old.pricePerHour,
        subtotal: old.subtotal,
        serviceFee: old.serviceFee,
        discount: old.discount,
        totalPrice: old.totalPrice,
        status: 'CANCELLED',
        paymentStatus: old.paymentStatus,
        paymentMethod: old.paymentMethod,
        qrCode: old.qrCode,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearBookingFlow() {
    _selectedDate = null;
    _selectedSlots.clear();
    _selectedPaymentMethod = null;
    _voucherCode = null;
    _discountAmount = 0;
    notifyListeners();
  }
}
