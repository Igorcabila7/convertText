import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import  'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage( ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
     final String apiKey = 'AIzaSyBYZKzwGijqazZrSAJhUbMu4gqXAMK_rtg';

  Future<String> fetchData(String searchTerm) async {
    final url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$searchTerm&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Analise a resposta JSON para extrair o texto relevante dos resultados da pesquisa
      // (Você precisará lidar com a análise JSON com base no formato de resposta da API)
      return response.body; // Substitua pelo processamento real
    } else {
      throw Exception("Erro ao buscar dados: Status code ${response.statusCode}");
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Page'),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchData('Pesquise aqui'),
          builder: (context, snapshot){
            if (snapshot.hasData) {
                return Text(snapshot.data!);
            }else if(snapshot.hasError)
            {
              return Text('Error:${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
