import 'dart:convert';
import 'package:flutter_application_1/models/categoria_raca.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user_model.dart';

class DropdownButtonCategorias extends StatefulWidget {
  const DropdownButtonCategorias({super.key});

  @override
  DropdownButtonCategoriasState createState() =>
      DropdownButtonCategoriasState();
}

class DropdownButtonCategoriasState extends State<DropdownButtonCategorias> {
  List<Categoria> items = [];
  Categoria? _selectedItem;

  Future<List> getCategorias() async {
    final response = await http.get(
        Uri.parse('https://adocao-production.up.railway.app/api/categorias'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body)['data'] as List;
      //return jsonList.map((e) => Categoria.fromMap(e)).toList();
      return jsonList;
    } else {
      throw Exception('Erro na Internet');
    }
  }

  @override
  void initState() {
    super.initState();
    getCategorias().then((categorias) {
      setState(() {
        items = categorias.map((e) => Categoria.fromMap(e)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      model.categoria = _selectedItem.toString();
      model.categoriaId = 1;
      return DropdownButton<Categoria>(
        value: _selectedItem,
        items: items.map((Categoria value) {
          return DropdownMenuItem<Categoria>(
            value: value,
            child: Text(value.categoria),
          );
        }).toList(),
        onChanged: (Categoria? selectedItem) {
          setState(() {
            _selectedItem = selectedItem;
            model.categoria = selectedItem!.categoria;
            model.categoriaId = selectedItem.id;
          });
        },
      );
    });
  }
}
