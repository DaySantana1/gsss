import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Basics',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedStatus; // Inicializado como null

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Temos apenas 1 OCEANO',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Image.asset(
              'images/baleia.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 3, 54),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const InfoContainer(
              imagePath: 'images/lixooceano.jpg',
              text:
                  'O aumento dos níveis de CO2 está a aumentar a temperatura do mar e resulta na acidificação dos oceanos. Ecossistemas frágeis como os recifes de coral são suscetíveis às menores alterações climáticas e poluição. ',
              route: SecondRoute(),
            ),
            const InfoContainer(
              imagePath: 'images/lixooceano1.jpg',
              text:
                  'Você sabia que atualmente permitimos que cerca de 8 milhões de toneladas de plástico cheguem aos nossos oceanos todos os anos?',
              route: SecondRoute(),
            ),
            const InfoContainer(
              imagePath: 'images/cardume.jpg',
              text:
                  'Você sabia que atualmente permitimos que cerca de 8 milhões de toneladas de plástico cheguem aos nossos oceanos todos os anos?',
              route: SecondRoute(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Os 8 Maiores Poluentes da Água',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: selectedStatus,
                      icon: Icon(
                          Icons.more_vert), // Ícone de três pontos verticais
                      items: <String>[
                        'InOperation',
                        'Harvesting',
                        'inMaintenance'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedStatus = newValue!;
                        });
                      },
                    ),
                    // Botão de limpar filtro
                    // Botão de limpar filtro
                    // IconButton(
                    //   icon: Icon(Icons.clear), // Ícone de limpar filtro
                    //   onPressed: () {
                    //     WidgetsBinding.instance!.addPostFrameCallback((_) {
                    //       setState(() {
                    //         selectedStatus = 'All'; // Limpa o filtro
                    //       });
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 400, // Ajuste a altura conforme necessário
              child: MyListView(selectedStatus: selectedStatus),
            ),
          ],
        ),
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  final String? selectedStatus;

  MyListView({required this.selectedStatus});

  final List<Map<String, dynamic>> items = [
    {'text': 'Item 1', 'status': 'InOperation'},
    {'text': 'Item 2', 'status': 'Harvesting'},
    {'text': 'Item 3', 'status': 'inMaintenance'},
    {'text': 'Item 4', 'status': 'InOperation'},
    {'text': 'Item 5', 'status': 'Harvesting'},
    {'text': 'Item 6', 'status': 'inMaintenance'},
    {'text': 'Item 7', 'status': 'InOperation'},
    {'text': 'Item 8', 'status': 'Harvesting'},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'InOperation':
        return Colors.green;
      case 'Harvesting':
        return Colors.blue;
      case 'inMaintenance':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedStatus == null
        ? items
        : items.where((item) => item['status'] == selectedStatus).toList();

    return ListView.builder(
  itemCount: filteredItems.length,
  itemBuilder: (context, index) {
    final item = filteredItems[index];
    return GestureDetector(
      onTap: () {
        if (SecondRoute != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute()!),
          );
        }
      },
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/chorume.png', // Altere conforme necessário
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 10), // Espaçamento entre a imagem e o texto
            Text('Image ${index + 1}'),
          ],
        ),
        title: Text(item['text']),
        trailing: Text(
          item['status'],
          style: TextStyle(
            color: _getStatusColor(item['status']),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  },
);

  }
}

class InfoContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  final Widget? route;

  const InfoContainer({
    required this.imagePath,
    required this.text,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('Saiba Mais'),
            onPressed: route != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => route!),
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  ThirdRoute()),
                );
              },
              child: const Text('Galeria'),
            ),
            const SizedBox(height: 10), // Adiciona espaçamento entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdRoute extends StatefulWidget {
  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  final List<String> imagePaths = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',
    'assets/image4.jpg',
    'assets/image5.jpg',
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Route Gallery'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: imagePaths.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imagePaths.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}