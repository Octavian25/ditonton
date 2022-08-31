import 'package:core/data/models/network_model.dart';
import 'package:core/domain/entities/network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tNetworkResponse = NetworkResponse(
      id: 1,
      name: "name",
      logoPath: "logoPath",
      originCountry: "originCountry");
  const networkResponse = Network(
      id: 1,
      name: "name",
      logoPath: "logoPath",
      originCountry: "originCountry");

  test("should return Network Model from response given", () {
    final result = tNetworkResponse.toEntity();
    expect(networkResponse, result);
  });

  test("expect valid model from json given", () {
    final response = Network.fromJson(const {
      "id": 1,
      "name": "name",
      "logo_path": "logoPath",
      "origin_country": "originCountry"
    });
    expect(networkResponse, response);
  });

  test("expect Json Map from Model Given", () {
    final response = networkResponse.toJson();
    expect({
      "id": 1,
      "name": "name",
      "logo_path": "logoPath",
      "origin_country": "originCountry"
    }, response);
  });

  test("expect JSONMAP from model", () {
    final response = const NetworkResponse(
            id: 1,
            name: "name",
            logoPath: "logoPath",
            originCountry: "originCountry")
        .toJson();
    expect({
      "id": 1,
      "name": "name",
      "logo_path": "logoPath",
      "origin_country": "originCountry",
    }, response);
  });
}
