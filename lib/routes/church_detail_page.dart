import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_akhir_dicoding/models/church_model.dart';
import 'package:proyek_akhir_dicoding/provider/favorite_churches_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChurchDetailPage extends StatefulWidget {
  final ChurchModel church;

  const ChurchDetailPage({super.key, required this.church});

  @override
  State<ChurchDetailPage> createState() => ChurchDetailPageState();
}

class ChurchDetailPageState extends State<ChurchDetailPage> {
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
        backgroundColor: Color(0xFFFFE082),
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

            cardData(
              dataModel: church.locationDetails,
              hintText: 'Location',
              fontWeight: FontWeight.bold,
            ),

            cardData(
              dataModel: church.address,
              hintText: 'Address',
              fontWeight: FontWeight.bold,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'GPS Link',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      onTap: () async {
                        final Uri uri = Uri.parse(church.gpsLink);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode
                                .externalApplication, // Buka di aplikasi eksternal
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Tidak dapat membuka link: ${church.gpsLink}',
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        church.gpsLink,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          decoration: TextDecoration
                              .underline, // Menambahkan garis bawah
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            cardData(
              dataModel: church.history,
              hintText: 'History',
              fontWeight: FontWeight.bold,
            ),

            cardData(
              dataModel: church.openingHours,
              hintText: 'Opening Hours',
              fontWeight: FontWeight.bold,
            ),

            cardData(
              dataModel: church.ticketPrice,
              hintText: 'Ticket Price',
              fontWeight: FontWeight.bold,
            ),

            cardData(
              dataModel: church.address,
              hintText: 'Address',
              fontWeight: FontWeight.bold,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Expanded(
                    flex: 3,
                    child: Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      ': ${church.rating}⭐',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        church.galleryImages[index],
                        fit: BoxFit.fill,
                        width: 250,
                        height: 100,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardData(
      {String? dataModel,
      String? hintText,
      double? fontSize = 16,
      FontWeight? fontWeight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              "$hintText",
              style: TextStyle(
                fontSize: fontSize,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              ': $dataModel',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
