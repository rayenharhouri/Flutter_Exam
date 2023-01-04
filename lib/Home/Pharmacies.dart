import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pharmacies extends StatefulWidget {
  const Pharmacies({super.key});

  @override
  State<Pharmacies> createState() => _PharmaciesState();
}

class _PharmaciesState extends State<Pharmacies> {
  List<Pharmacie> games = [];
  late Future<bool> fetchedGames;
  final String baseUrl = "10.0.2.2:9090";
  Future<bool> fetchGames() async {
    http.Response response =
        await http.get(Uri.http(baseUrl, "/api/pharmacies/list"));
    List<dynamic> gamesFromServer = json.decode(response.body);
    gamesFromServer.forEach((game) {
      games.add(Pharmacie(
        title: game["title"],
        image: game["image"],
        address: game["address"],
      ));
    });
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedGames = fetchGames();
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
                      child: Column(
                        children: [
                          Image.network(
                              "http://$baseUrl/img/${games[index].image}"),
                          Text(
                            "Titre :" + games[index].title,
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                          Text("Adress : " + games[index].address),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class Pharmacie {
  final String title;
  final String address;
  final String image;

  Pharmacie({
    required this.title,
    required this.address,
    required this.image,
  });
}
