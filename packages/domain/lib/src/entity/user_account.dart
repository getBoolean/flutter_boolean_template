import 'package:riverpod/riverpod.dart';

import '../value/email.dart';
import '../value/name.dart';

class UserAccountNotifier extends StateNotifier<UserAccount?> {
  UserAccountNotifier() : super(null);

  set value(UserAccount? userAccount) {
    state = userAccount;
  }

  UserAccount? get value => state;
}

class UserAccount {
  final String id;
  final Name name;
  final Email email;

  UserAccount({
    required this.id,
    required this.name,
    required this.email,
  });
}
