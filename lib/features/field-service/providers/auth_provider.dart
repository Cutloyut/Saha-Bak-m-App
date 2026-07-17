import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saha_bakim/features/field-service/models/app_user_model.dart';

class AuthProvider extends ChangeNotifier {
  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  bool get isTechnician => _currentUser?.role == UserRole.technician;
  bool get isTeamLoad => _currentUser?.role == UserRole.teamlead;

  void login(UserRole role, String name, BuildContext context) {
    int id = DateTime.now().microsecondsSinceEpoch;
    if (role == UserRole.technician) {
      _currentUser = AppUser(id: id, name: name, role: UserRole.technician);
    } else {
      _currentUser = AppUser(id: id, name: name, role: UserRole.teamlead);
    }
    context.go('/work-order-list-screen');
    log("Giriş Yapıldı Seçilen Rol $role", name: "Login Log");
  }
}
