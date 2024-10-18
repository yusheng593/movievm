class MoviesGenreModel {
  int? id;
  String? name;

  MoviesGenreModel({
    required this.id,
    required this.name,
  });

  factory MoviesGenreModel.fromJson(Map<String, dynamic> json) {
    return MoviesGenreModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'GenresModel(id: $id, name: $name)';
  }
}
