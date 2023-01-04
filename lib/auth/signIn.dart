import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String? CodeInscription;

  final String baseUrl = "10.0.2.2:9090";

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S'authentifier"),
        backgroundColor: Colors.red,
      ),
      body: Form(
          key: keyForm,
          child: ListView(children: [
            Column(
              children: [
                Image.asset(
                    "assets/Premium_Vector___Motorcycle_vector_logo-removebg-preview.png"),
                Container(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "CodeInscription"),
                      onSaved: (String? value) {
                        CodeInscription = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Le CodeInscription ne doit pas etre vide";
                        } else if (value.length < 3) {
                          return "Le CodeInscription doit avoir au moins 5 caractères";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(80, 20, 10, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          CodeInscription = "";
                        },
                        child: const Text("Réinitialiser"),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          child: const Text("Login"),
                          onPressed: () {
                            if (keyForm.currentState!.validate()) {
                              keyForm.currentState!.save();
                              Map<String, String> headers = {
                                "Content-Type":
                                    "application/json; charset=utf-8"
                              };
                              Map body = {
                                "code": CodeInscription!,
                              };

                              http
                                  .post(Uri.http(baseUrl, "/api/users/login"),
                                      headers: headers, body: json.encode(body))
                                  .then((response) async {
                                if (response.statusCode == 200) {
                                  Map<String, dynamic> userData =
                                      json.decode(response.body);
                                  Navigator.pushReplacementNamed(
                                      context, "/home");
                                } else if (response.statusCode == 401) {
                                  showDialog(
                                      context: context,
                                      builder: (builder) {
                                        return const AlertDialog(
                                            title: Text("Erreur"),
                                            content: Text(
                                                "Mot de passe ou CodeInscription invalides"));
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (builder) {
                                        return const AlertDialog(
                                            title: Text("Erreur"),
                                            content: Text("Erreur Serveur"));
                                      });
                                }
                              });
                            }
                          },
                        )),
                  ],
                ),
              ],
            ),
          ])),
    );
  }
}
