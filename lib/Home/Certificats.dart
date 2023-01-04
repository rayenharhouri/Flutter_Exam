import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Certificats extends StatefulWidget {
  const Certificats({super.key});

  @override
  State<Certificats> createState() => _CertificatsState();
}

class _CertificatsState extends State<Certificats> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedGames = fetchGames();
  }

  final String baseUrl = "10.0.2.2:9090";
  List<User> games = [];
  late Future<bool> fetchedGames;
  Future<bool> fetchGames() async {
    // http.Response response = await http.get(Uri.http(baseUrl, "/api/certificate/" "63b5c100520784307aa84807"));
    //List<dynamic> userFromServer = json.decode(response.body);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedGames,
      builder: (context, snapshot) {
        if (snapshot.hasData && games.isEmpty == true) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Votre Nom est : ",
                ),
                Text("Votre Prenom est : "),
                Text("Votre Code est : "),
                Text("Votre Email est : "),
                Text("Etat : "),
                Image.network("http://$baseUrl/img/qr_code.png"),
              ]);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class User {
  final String etat;
  final String nom;
  final String qr_code;
  final String Prenom;
  final String email;
  final int code;

  User({
    required this.etat,
    required this.nom,
    required this.qr_code,
    required this.Prenom,
    required this.email,
    required this.code,
  });
}
