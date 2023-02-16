import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

@riverpod
String auth(AuthRef ref) {
  return 'auth';
}
