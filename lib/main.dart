import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Gamescreen(),
    );
  }
}

class Gamescreen extends StatelessWidget {
  const Gamescreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 300,
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
    );
  }
}

class Game extends StatefulWidget {
  const Game({Key? key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int L = 0;
  int chans = 0;
  List<String> listmo = [];
  String asteriks = "";
  String X = "Hello";
  List<String> mokache = [];
  String textinput = "";
  TextEditingController input = TextEditingController();

  void initState() {
    super.initState();
    L = X.length;
    asteriks = '*' * L;
    listmo = List.generate(L, (index) => "*");
    mokache = X.split('');
    chans = L;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Page"),
        actions: [
          Center(
            child: Text("il vous reste  : $chans chans"),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${listmo.join(' ')}."),
            Text("se yon mo yo itilize pou salye moun"),
            Container(
              width: 200,
              child: TextField(
                keyboardType:TextInputType.text,
                controller: input,
                decoration: InputDecoration(labelText: "taper ici"),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                mokachefonction();
                input.clear();
              },
              child: Text("submit"),
            )
          ],
        ),
      ),
    );
  }

  void mokachefonction() {
    setState(() {
      chans--;
      textinput = input.text;
      for (int i = 0; i < L; i++) {
        if (textinput[i] == X[i]) {
          listmo[i] = X[i];
        } else {
          listmo[i] = "*";
        }
      }
      if (listmo.join() == X) {
        runGame();
      } else if (listmo.join().contains("*")) {
        lostgame();
      }
    });
  }

  void runGame() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You win"),
            content: Text("Congratulations do you want to replay"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  },
                  child: Text("Restart Game")),
              // TextButton(
              //   onPressed: () {
              //     // Action pour quitter le jeu
              //     SystemNavigator.pop();
              //   },
              //   child: Text("Quitter"),
              // ),
            ],
          );
        });
  }

  void lostgame() {}
}
