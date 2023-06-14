import 'package:riverpod/riverpod.dart';

class VeryGoodDartPackageRepository {
  // TODO: Implement methods for this repository here
}

final veryGoodDartPackageRepositoryProvider = Provider<VeryGoodDartPackageRepository>((ref) {
  final veryGoodDartPackageRepository = VeryGoodDartPackageRepository();
  return veryGoodDartPackageRepository;
});
