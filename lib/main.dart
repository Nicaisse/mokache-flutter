import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jeu du Mot Caché'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 150,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Description du jeu :\n\n'
                  "Le game du 'MOT CACHE' consiste à deviner un mot en proposant des lettres. Chaque lettre correcte est révélée dans le mot, sinon le joueur perd des vies. L'objectif est de deviner le mot complet avant d'épuiser toutes les vies",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Game()),
                  );
                },
                child: const Text("Commencer le jeu"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Game extends StatefulWidget {
  const Game({Key? key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  // Ajoutez ici l'état que vous souhaitez gérer
  int numberOfLives = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Contenu de la page du jeu"),
            Text("Nombre de vies restantes : $numberOfLives"),
          ],
        ),
      ),
    );
  }
}
