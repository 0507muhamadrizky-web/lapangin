import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/customer/customer_main_screen.dart';
import '../screens/customer/home/home_screen.dart';
import '../screens/customer/search/search_screen.dart';
import '../screens/customer/venue/venue_detail_screen.dart';
import '../screens/customer/booking/booking_screen.dart';
import '../screens/customer/booking/checkout_screen.dart';
import '../screens/customer/booking/payment_screen.dart';
import '../screens/customer/booking/booking_success_screen.dart';
import '../screens/customer/booking/my_bookings_screen.dart';
import '../screens/customer/booking/booking_detail_screen.dart';
import '../screens/customer/favorite/favorite_screen.dart';
import '../screens/customer/profile/profile_screen.dart';
import '../screens/owner/owner_main_screen.dart';
import '../screens/owner/dashboard/owner_dashboard_screen.dart';
import '../screens/owner/courts/manage_courts_screen.dart';
import '../screens/owner/courts/add_court_screen.dart';
import '../screens/owner/bookings/owner_bookings_screen.dart';
import '../screens/owner/revenue/revenue_screen.dart';
import '../screens/owner/profile/owner_profile_screen.dart';
import '../screens/admin/admin_main_screen.dart';
import '../screens/admin/dashboard/admin_dashboard_screen.dart';
import '../screens/admin/users/manage_users_screen.dart';
import '../screens/admin/owners/manage_owners_screen.dart';
import '../screens/admin/venues/manage_venues_screen.dart';
import '../screens/admin/bookings/admin_bookings_screen.dart';
import '../screens/admin/transactions/admin_transactions_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Customer Routes
      ShellRoute(
        builder: (context, state, child) => CustomerMainScreen(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/my-bookings',
            builder: (context, state) => const MyBookingsScreen(),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoriteScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/venue/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return VenueDetailScreen(venueId: id);
        },
      ),
      GoRoute(
        path: '/booking/:venueId',
        builder: (context, state) {
          final venueId = state.pathParameters['venueId']!;
          return BookingScreen(venueId: venueId);
        },
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: '/booking-success',
        builder: (context, state) => const BookingSuccessScreen(),
      ),
      GoRoute(
        path: '/booking-detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BookingDetailScreen(bookingId: id);
        },
      ),

      // Owner Routes
      ShellRoute(
        builder: (context, state, child) => OwnerMainScreen(child: child),
        routes: [
          GoRoute(
            path: '/owner/dashboard',
            builder: (context, state) => const OwnerDashboardScreen(),
          ),
          GoRoute(
            path: '/owner/bookings',
            builder: (context, state) => const OwnerBookingsScreen(),
          ),
          GoRoute(
            path: '/owner/courts',
            builder: (context, state) => const ManageCourtsScreen(),
          ),
          GoRoute(
            path: '/owner/revenue',
            builder: (context, state) => const RevenueScreen(),
          ),
          GoRoute(
            path: '/owner/profile',
            builder: (context, state) => const OwnerProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/owner/courts/add',
        builder: (context, state) => const AddCourtScreen(),
      ),

      // Admin Routes
      ShellRoute(
        builder: (context, state, child) => AdminMainScreen(child: child),
        routes: [
          GoRoute(
            path: '/admin/dashboard',
            builder: (context, state) => const AdminDashboardScreen(),
          ),
          GoRoute(
            path: '/admin/users',
            builder: (context, state) => const ManageUsersScreen(),
          ),
          GoRoute(
            path: '/admin/owners',
            builder: (context, state) => const ManageOwnersScreen(),
          ),
          GoRoute(
            path: '/admin/venues',
            builder: (context, state) => const ManageVenuesScreen(),
          ),
          GoRoute(
            path: '/admin/bookings',
            builder: (context, state) => const AdminBookingsScreen(),
          ),
          GoRoute(
            path: '/admin/transactions',
            builder: (context, state) => const AdminTransactionsScreen(),
          ),
        ],
      ),
    ],
  );
}
