import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorteador de Nomes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Sorteador de Nomes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _nomes = [
    "Ana", "Bruno", "Carlos", "Daniela", "Eduardo",
    "Fernanda", "Gabriel", "Helena", "Isabela", "João"
  ];
  List<String> _nomesHistorico = [];
  String _nomeSorteado = "Nenhum nome sorteado ainda";

  void _sortearNome() {
    final random = Random();
    setState(() {
      int index = random.nextInt(_nomes.length);
      _nomeSorteado = _nomes[index];
      _nomes.removeAt(index);
      _nomesHistorico.add(_nomeSorteado);
    });
  }

  void _resetSorteio() {
    setState(() {
      _nomeSorteado = "Nenhum nome sorteado ainda";
      _nomesHistorico.clear();
      _nomes = [
        "Ana", "Bruno", "Carlos", "Daniela", "Eduardo",
        "Fernanda", "Gabriel", "Helena", "Isabela", "João"
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Nome sorteado:'),
            Text(
              _nomeSorteado,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _resetSorteio,
                  tooltip: 'Resetar',
                  child: const Icon(Icons.refresh),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _sortearNome,
                  tooltip: 'Sortear Nome',
                  child: const Icon(Icons.shuffle),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _nomesHistorico.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_nomesHistorico[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}