import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.isRead = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class NotificationProvider extends ChangeNotifier {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: 'n1',
      title: 'Booking Berhasil! 🎉',
      message: 'Booking di Arena Futsal Semarang pada 28 Sep 2026, 19:00-21:00 telah dikonfirmasi.',
      type: 'booking',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      id: 'n2',
      title: 'Pembayaran Diterima ✅',
      message: 'Pembayaran sebesar Rp205.000 untuk booking LPG-260926-00125 telah berhasil.',
      type: 'payment',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      id: 'n3',
      title: 'Promo Spesial! 🔥',
      message: 'Gunakan kode LAPANGIN10 untuk diskon 10% di semua lapangan. Berlaku hingga 30 Sep 2026.',
      type: 'promo',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationItem(
      id: 'n4',
      title: 'Booking Akan Dimulai ⏰',
      message: 'Booking kamu di Galaxy Badminton Center akan dimulai dalam 1 jam. Jangan lupa bawa QR Code!',
      type: 'reminder',
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  List<NotificationItem> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = NotificationItem(
        id: _notifications[index].id,
        title: _notifications[index].title,
        message: _notifications[index].message,
        type: _notifications[index].type,
        isRead: true,
        createdAt: _notifications[index].createdAt,
      );
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = NotificationItem(
        id: _notifications[i].id,
        title: _notifications[i].title,
        message: _notifications[i].message,
        type: _notifications[i].type,
        isRead: true,
        createdAt: _notifications[i].createdAt,
      );
    }
    notifyListeners();
  }
}
