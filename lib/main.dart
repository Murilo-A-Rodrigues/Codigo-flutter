import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Argumentos para a tela de detalhes
class DetailArguments {
  final String title;
  final String message;
  final String caminho;
  DetailArguments(this.title, this.message, this.caminho);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Rotas Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/intermediariaNomeada': (context) => IntermediariaNomeadaScreen(),
        '/detailsNomeada': (context) => DetailScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detailsNomeada') {
          final args = settings.arguments as DetailArguments;
          return MaterialPageRoute(
            builder: (context) => DetailScreen(args: args),
          );
        }
        return null;
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Escolha um caminho:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Caminho PUSH'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IntermediariaPushScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Caminho ROTA NOMEADA'),
              onPressed: () {
                Navigator.pushNamed(context, '/intermediariaNomeada');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Caminho intermediário via push
class IntermediariaPushScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Intermediária (push)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Você chegou aqui usando PUSH!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Ir para Detalhes (push)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      args: DetailArguments(
                        'Detalhes via push',
                        'Chegou aqui usando apenas push!',
                        'Home > Intermediária (push) > Detalhes (push)',
                      ),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Voltar'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// Caminho intermediário via rota nomeada
class IntermediariaNomeadaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Intermediária (rota nomeada)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Você chegou aqui usando ROTA NOMEADA!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Ir para Detalhes (rota nomeada)'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/detailsNomeada',
                  arguments: DetailArguments(
                    'Detalhes via rota nomeada',
                    'Chegou aqui usando apenas rotas nomeadas!',
                    'Home > Intermediária (rota nomeada) > Detalhes (rota nomeada)',
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Voltar'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela de detalhes (usada para ambos os caminhos)
class DetailScreen extends StatelessWidget {
  final DetailArguments? args;
  const DetailScreen({Key? key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailArguments arguments =
        args ?? ModalRoute.of(context)!.settings.arguments as DetailArguments;

    return Scaffold(
      appBar: AppBar(title: Text(arguments.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(arguments.message, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Caminho: ${arguments.caminho}', style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Voltar'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Voltar para o início'),
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
            ),
          ],
        ),
      ),
    );
  }
}