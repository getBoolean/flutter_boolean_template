import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_model.freezed.dart';
part 'package_model.g.dart';

// TODO: Run `flutter packages pub run build_runner build --delete-conflicting-outputs` to generate code after modifying model
@freezed
class PackageModel with _$PackageModel {

  factory PackageModel() = _PackageModel;

  factory PackageModel.fromJson(Map<String, dynamic> json) => _$PackageModelFromJson(json);
}
