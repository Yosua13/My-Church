import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_akhir_dicoding/models/church_model.dart';
import 'package:proyek_akhir_dicoding/provider/favorite_churches_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChurchDetailPage extends StatefulWidget {
  final ChurchModel church;

  const ChurchDetailPage({super.key, required this.church});

  @override
  State<ChurchDetailPage> createState() => _ChurchDetailPageState();
}

class _ChurchDetailPageState extends State<ChurchDetailPage> {
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = context
        .read<FavoriteChurchesProvider>()
        .favoriteChurches
        .contains(widget.church);
  }

  @override
  Widget build(BuildContext context) {
    final church = widget.church;
    final Uri uri = Uri.parse(church.gpsLink);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Church'),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: () {
              if (isFavorite) {
                context.read<FavoriteChurchesProvider>().removeFavorite(church);
              } else {
                context.read<FavoriteChurchesProvider>().addFavorite(church);
              }
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display main image of the church
            Image.asset(church.mainImageUrl),

            // Church name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                church.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            // Location Details (City, Province, Country)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${church.city}, ${church.province}, ${church.country}',
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

            // Address
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Address:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    church.address,
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

            // GPS link
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'GPS Link:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Tidak dapat membuka link: $church.gpsLink'),
                      ),
                    );
                  }
                },
                child: Text(
                  church.gpsLink,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            // History Section
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'History:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                church.history,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            // Opening Hours
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Opening Hours:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                church.openingHours,
                style: const TextStyle(fontSize: 18),
              ),
            ),

            // Ticket Price
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Ticket Price:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                church.ticketPrice,
                style: const TextStyle(fontSize: 18),
              ),
            ),

            // Rating
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Rating:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${church.rating} ⭐',
                style: const TextStyle(fontSize: 18),
              ),
            ),

            // Image Gallery
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Gallery:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: church.galleryImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(church.galleryImages[index]),
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
