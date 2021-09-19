import 'package:api_learning/pokemons.dart';
import 'package:flutter/material.dart';
import 'apiservice.dart';
import 'package:api_learning/pokemon_abilities.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon',
      home: MyHomePage(title: 'Pokemons'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fetchPokemon;
  @override
  void initState() {
    fetchPokemon = API().getClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Color(0xff003a70),
        ),
        body: Container(
          color: Color(0xff3d7dca),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: FutureBuilder<List<Pokemon>>(
                        future: fetchPokemon,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                                child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 100,
                                  padding: EdgeInsets.all(10),
                                  child: RaisedButton(
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Pokemonabilities(
                                                      snapshot.data[index].url
                                                          .toString(),
                                                      snapshot.data[index].name
                                                          .toUpperCase())))
                                    },
                                    color: Color(0xffffcb05),
                                    child: Text(
                                      snapshot.data[index].name.toUpperCase(),
                                      style: TextStyle(
                                          color: Color(0xff003a70),
                                          fontSize: 24),
                                    ),
                                  ),
                                );
                              },
                            ));
                          } else {
                            return CircularProgressIndicator();
                          }
                        }))
              ],
            ),
          ),
        ));
  }
}
