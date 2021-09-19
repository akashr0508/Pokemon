import 'package:flutter/material.dart';
import 'apiservice.dart';

class Pokemonabilities extends StatefulWidget {
  String url;
  String name;
  Pokemonabilities(this.url, this.name);
  @override
  PokemonabilitiesState createState() =>
      PokemonabilitiesState(this.url, this.name);
}

class PokemonabilitiesState extends State<Pokemonabilities> {
  String url;
  String name;
  PokemonabilitiesState(this.url, this.name);
  var fetchabilities;
  @override
  void initState() {
    fetchabilities = API().getAbilities(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          backgroundColor: Color(0xff003a70),
        ),
        body: Container(
          color: Color(0xff3d7dca),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    width: 600,
                    child: Center(
                      child: Text(
                        "Abilities",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    )),
                Container(
                  child: FutureBuilder(
                    future: fetchabilities,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        return Expanded(
                            child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                height: 100,
                                padding: EdgeInsets.all(10),
                                child: RaisedButton(
                                  color: Color(0xffffcb05),
                                  child: Text(
                                    snapshot.data[index]["name"].toUpperCase(),
                                    style: TextStyle(
                                        color: Color(0xff003a70), fontSize: 24),
                                  ),
                                  onPressed: () => {},
                                ));
                          },
                        ));
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
