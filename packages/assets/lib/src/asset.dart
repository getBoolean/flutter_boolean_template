import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../assets.dart';

class Asset extends Equatable {
  const Asset(this.path);

  /// Path to the asset defined in [Assets]
  final String path;

  Image toImage() => Image.asset(path);

  ImageProvider toImageProvider() => AssetImage(path);

  ImageProvider toAssetImage() => toImageProvider();

  @override
  List<Object> get props => [path];

  @override
  bool get stringify => true;
}
