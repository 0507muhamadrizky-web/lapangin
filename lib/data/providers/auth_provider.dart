import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../mock_data.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isLoggedIn = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String get userRole => _currentUser?.role ?? '';

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock login: check email to determine role
    if (email.contains('admin')) {
      _currentUser = MockData.users[2]; // Admin
    } else if (email.contains('owner') || email.contains('budi')) {
      _currentUser = MockData.users[1]; // Owner
    } else {
      _currentUser = MockData.users[0]; // Customer
    }

    _isLoggedIn = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _currentUser = UserModel(
      id: 'u_new',
      name: name,
      email: email,
      phone: phone,
      role: 'CUSTOMER',
    );
    _isLoggedIn = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _isLoading = false;
    notifyListeners();
  }
}
