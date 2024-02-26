import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String X = "Hello".toLowerCase();
  List<String> mokache = [];
  String textinput = "";
  List<String> guessedLetters = [];
  TextEditingController input = TextEditingController();

  @override
  void initState() {
    super.initState();
    L = X.length;
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
            Text("${listmo.join(' ')}"),
            Text("se yon mo yo itilize pou salye moun"),
            Container(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: input,
                decoration: InputDecoration(labelText: "taper ici"),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                if (input.text.length != L) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('error'),
                          content: Text(
                              "il doit etre de la meme longueur que le mot cache"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"))
                          ],
                        );
                      });
                  input.clear();
                  textinput = "";
                  chans--;
                } else {
                  mokachefonction();
                  input.clear();
                  textinput = "";
                }
              },
              child: Text("submit"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                children: List.generate(26, (index) {
                  String klavye =
                      String.fromCharCode('a'.codeUnitAt(0) + index);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        onLetterPressed(klavye);
                      },
                      child: Text(klavye.toUpperCase()),
                    ),
                  );
                }),
              ),
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
      } else if (chans == 0) {
        lostgame();
      }
    });
  }

  void onLetterPressed(String klavye) {
    setState(() {
      textinput += klavye; // Ajoute la lettre tapée au texte existant
      input.text = textinput;
      guessedLetters.add(klavye);
      // Met à jour le texte du TextField
    });
  }

  void runGame() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You win"),
          content: Text("Congratulations! Do you want to replay?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              child: Text("Restart Game"),
            ),
            TextButton(
              onPressed: () {
                // Action pour quitter le jeu
              },
              child: Text("Quitter"),
            ),
          ],
        );
      },
    );
  }

  void lostgame() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You Lost"),
          content: Text("You lost! Do you want to replay?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              child: Text("Restart"),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
               
              },
              child: Text("Exit Game"),
            ),
          ],
        );
      },
    );
  }
}
