import 'package:assets/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Asset extends Equatable {
  const Asset(this.path);

  /// Creates an [Image.asset] widget that displays an image from `path`.
  ///
  /// Arguments:
  /// * `path` - Path to the asset defined in [Assets]
  static Image image(
    String path,
  ) =>
      Image.asset(path);

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
