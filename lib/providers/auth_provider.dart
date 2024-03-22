// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smartp/model/users_model.dart';
// import 'package:smartp/services/api_controller.dart';

// /// Provides access to the current user's authentication state.
// final authProvider = StateNotifierProvider<AuthNotifier, UsersModel?>((ref) {
//   return AuthNotifier(ApiService());
// });

// /// Manages authentication state and notifies listeners of changes.
// class AuthNotifier extends StateNotifier<UsersModel?> {
//   final ApiService _authService;

//   AuthNotifier(this._authService) : super(null);

//   /// Attempts to log the user in and updates the state accordingly.
//   Future<void> login(String email, String password) async {
//     final loggedIn = await _authService.login(email, password);
//     if (loggedIn) {
//       state = _authService.currentUser;
//     }
//   }

//   /// Logs the user out and updates the state to null.
//   void logout() {
//     _authService.logout();
//     state = null;
//   }
// }
