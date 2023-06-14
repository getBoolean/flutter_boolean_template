import 'package:riverpod/riverpod.dart';

class VeryGoodDartPackageService {
  VeryGoodDartPackageService(this.ref);
  final Ref ref;

  // TODO: Add your service methods that interacts with repositories in data layer here
}

final veryGoodDartPackageServiceProvider=Provider<VeryGoodDartPackageService>((ref) {
  return VeryGoodDartPackageService(ref);
});
