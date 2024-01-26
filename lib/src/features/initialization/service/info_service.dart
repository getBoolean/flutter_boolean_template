import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'info_service.g.dart';

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(PackageInfoRef ref) async {
  return await PackageInfo.fromPlatform();
}
