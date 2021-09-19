import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'pokemons.dart';

class API {
  Future<List<Pokemon>> getClass() async {
    final Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/");
    var pokemons = List<Pokemon>();
    final resp = await http.get(url);
    Map<String, dynamic> body;
    if (resp.statusCode == 200) {
      body = json.decode(resp.body);
    }
    print(body["results"]);
    for (var results in body["results"]) {
      pokemons.add(Pokemon.fromJson(results));
    }
    return pokemons;
  }

  Future getAbilities(String abilitesurl) async {
    final Uri url = Uri.parse(abilitesurl);

    final resp = await http.get(url);
    Map<String, dynamic> body;
    if (resp.statusCode == 200) {
      body = json.decode(resp.body);
    }
    var attack = [];
    for (int i = 0; i < 2; i++) {
      attack.add(body["abilities"][i]["ability"]);
    }
    print(attack[1]["name"]);

    return attack;
  }
}
