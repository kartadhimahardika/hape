import 'package:flutter/material.dart';
import 'package:hape/models/shop.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.model});

  final Shop model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        title: Text('Detail'),
        elevation: 0, // Remove the shadow under the app bar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add a hero animation to the image
            Hero(
              tag: model.image,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(model.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ), // Add rounded corners to the image
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${model.title}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Rp. ${model.harga}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                Spacer(), // Add a spacer to push the button to the right
                ElevatedButton(
                  onPressed: () {
                    // Add to cart logic here
                  },
                  child: Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '${model.description}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
