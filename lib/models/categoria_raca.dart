// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Categoria {
  final int id;

  final String categoria;
  Categoria({
    required this.id,
    required this.categoria,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoria': categoria,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'],
      categoria: map['attributes']['categoria'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source) as Map<String, dynamic>);
}
