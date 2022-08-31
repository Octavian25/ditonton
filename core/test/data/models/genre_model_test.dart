import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenre = Genre(id: 1, name: "name");
  const genreModel = GenreModel(id: 1, name: "name");

  test("should return Genre from response given", () {
    final result = genreModel.toEntity();
    expect(tGenre, result);
  });

  test("expect valid model from json given", () {
    final response = GenreModel.fromJson(const {"id": 1, "name": "name"});
    expect(genreModel, response);
  });

  test("expect Json Map from Model Given", () {
    final response = genreModel.toJson();
    expect({
      "id": 1,
      "name": "name",
    }, response);
  });
}
