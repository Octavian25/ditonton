import 'package:core/domain/entities/network.dart';
import 'package:equatable/equatable.dart';

class NetworkResponse extends Equatable {
  const NetworkResponse({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  final int id;
  final String name;
  final String logoPath;
  final String originCountry;

  factory NetworkResponse.fromJson(Map<String, dynamic> json) =>
      NetworkResponse(
        id: json["id"],
        name: json["name"],
        logoPath: json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo_path": logoPath,
        "origin_country": originCountry,
      };

  Network toEntity() => Network(
      id: id, name: name, logoPath: logoPath, originCountry: originCountry);

  @override
  List<Object?> get props => [id, name, logoPath, originCountry];
}
