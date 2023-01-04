import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Certificats.dart';
import 'MesDoses.dart';
import 'Pharmacies.dart';

class NavigationTab extends StatelessWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: const Text("Pharmacie"),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.health_and_safety),
                    text: "Mes Does",
                  ),
                  Tab(
                    icon: Icon(Icons.local_pharmacy),
                    text: "Pharmacies",
                  ),
                  Tab(
                    icon: Icon(Icons.qr_code),
                    text: "Certificates",
                  )
                ],
              ),
            ),
            body: const TabBarView(
                children: [Doses(), Pharmacies(), Certificats()]),
            drawer: Drawer(
              child: Column(
                children: [
                  AppBar(
                    automaticallyImplyLeading: true,
                    leading: const Icon(Icons.arrow_forward_ios),
                    backgroundColor: Colors.red,
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, "/home"),
                    title: Row(
                      children: const [
                        Icon(Icons.history),
                        SizedBox(width: 10),
                        Text("Historique"),
                        SizedBox(width: 140),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      Navigator.pushReplacementNamed(context, "/");
                    },
                    title: Row(
                      children: const [
                        Icon(Icons.power_settings_new),
                        SizedBox(width: 10),
                        Text("Se deconnecter"),
                        SizedBox(width: 110),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
