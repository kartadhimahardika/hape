import 'dart:convert';
import 'package:hape/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hape/models/shop.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Shop>> data;

  Future<List<Shop>> fetchData() async {
    var url = 'https://kusumawardanastudio.com/api/uas/kelompok3/api_read.php';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map api = json.decode(response.body);
      List jsonResponse = api['data'];

      return jsonResponse.map((data) => Shop.fromJson(data)).toList();
    } else {
      throw Exception('gagal mendapatkan data API');
    }
  }

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Cuing Ped Phone Shop'),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Add your leading button functionality here
          },
        ),
      ),
      body: Column(
        children: [
          // Add a banner
          Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/banner.jpg'), // Replace with your banner image
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Daftar Produk",
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Shop>>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var shop = snapshot.data![index];
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Shop model = Shop(
                              id: shop.id,
                              title: shop.title,
                              description: shop.description,
                              image: shop.image,
                              harga: shop.harga,
                            );

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailPage(model: model),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  shop.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${shop.title}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${shop.description}',
                                      maxLines: 2,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${shop.harga}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreatePage(),
            ),
          );
        },
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}