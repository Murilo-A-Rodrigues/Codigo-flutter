# Navegação e Rotas no Flutter

Este projeto demonstra os fundamentos de navegação e rotas no Flutter, incluindo:

- **Navegação por push** (`Navigator.push`)
- **Navegação por rotas nomeadas** (`Navigator.pushNamed`)
- **Passagem de argumentos entre telas**
- **Boas práticas de navegação**

## Como funciona

Ao iniciar o app, você verá dois botões:

- **Caminho PUSH:**  
  Navega para telas intermediárias e de detalhes usando apenas `Navigator.push` e construtores diretos.

- **Caminho ROTA NOMEADA:**  
  Navega para telas intermediárias e de detalhes usando apenas rotas nomeadas (`Navigator.pushNamed`).

Na tela de detalhes, é exibido o caminho percorrido e o método de navegação utilizado.

## Como rodar

1. Certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
2. Clone ou baixe este repositório.
3. No terminal, navegue até a pasta do projeto e execute:
   ```sh
   flutter pub get
   flutter run
   ```
4. Escolha um dos caminhos na tela inicial para observar a diferença entre as formas de navegação.

## Sobre o código

- O arquivo principal é [`lib/main.dart`](lib/main.dart).
- O projeto utiliza três telas principais:
  - **HomeScreen:** Tela inicial com as opções de navegação.
  - **IntermediariaPushScreen:** Caminho intermediário via push.
  - **IntermediariaNomeadaScreen:** Caminho intermediário via rota nomeada.
  - **DetailScreen:** Tela de detalhes que mostra o método de navegação e o caminho percorrido.

## Intergrantes do grupo

- Murilo Andre Rodrigues
- Gustavo Finkler Haas
- Pablo Emanuel Cechim de Lima
- Tawan Vitor Silva de Oliveira

## Observação

A diferença entre push e rotas nomeadas está na forma como as telas são empilhadas e como os argumentos são passados.  
Rotas nomeadas facilitam a organização em projetos grandes, enquanto o push direto é mais flexível para casos simples.