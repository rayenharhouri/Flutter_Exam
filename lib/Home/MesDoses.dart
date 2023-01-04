import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Doses extends StatefulWidget {
  const Doses({super.key});

  @override
  State<Doses> createState() => _DosesState();
}

class _DosesState extends State<Doses> {
  List<GameData> games = [];
  late Future<bool> fetchedGames;
  final String baseUrl = "10.0.2.2:9090";
  Future<bool> fetchGames() async {
    http.Response response = await http.get(Uri.http(baseUrl,
        "/api/pharmacies/rendez_vous/liste/" "63b5c100520784307aa84806"));
    List<dynamic> gamesFromServer = json.decode(response.body);
    gamesFromServer.forEach((game) {
      games.add(GameData(type: game["type"], date: game["date"]));
    });
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchedGames = fetchGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedGames,
        builder: (context, snapshot) {
         
          if (snapshot.hasData && games.isEmpty == false) {
            return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: Card(
                      child: Row(
                        children: [
                          Text(games[index].type),
                          Text(games[index].date),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("Vous n'avez pris aucune dose"),
            );
          }
        });
  }
}

class GameData {
  final String type;
  final String date;

  GameData({
    required this.type,
    required this.date,
  });
}
