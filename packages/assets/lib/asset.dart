import 'package:assets/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Asset extends Equatable {
  const Asset(this.path);

  /// Path to the asset defined in [Assets]
  final String path;

  Image toImage() => Image.asset(path, package: Assets.package);

  ImageProvider toImageProvider() => AssetImage(path, package: Assets.package);

  AssetImage toAssetImage() => AssetImage(path, package: Assets.package);

  @override
  List<Object> get props => [path];

  @override
  bool get stringify => true;
}
