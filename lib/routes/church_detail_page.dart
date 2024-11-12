import 'package:flutter/material.dart';
import 'package:proyek_akhir_dicoding/models/church_model.dart';

class ChurchDetailPage extends StatefulWidget {
  final ChurchModel church;

  ChurchDetailPage({required this.church});

  @override
  _ChurchDetailPageState createState() => _ChurchDetailPageState();
}

class _ChurchDetailPageState extends State<ChurchDetailPage> {
  @override
  Widget build(BuildContext context) {
    final church = widget.church;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Church'),
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
                church.name ?? 'Unknown',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            // Location Details (City, Province, Country)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${church.city ?? 'Unknown City'}, ${church.province ?? 'Unknown Province'}, ${church.country ?? 'Unknown Country'}',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
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
                  Text(
                    'Address:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${church.address ?? 'Unknown Address'}',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

            // GPS link
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'GPS Link:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (church.gpsLink != null) {
                    // Open GPS Link in browser
                    // Use url_launcher or open the link directly (for simplicity here, using print)
                    print('Opening GPS Link: ${church.gpsLink}');
                  }
                },
                child: Text(
                  church.gpsLink ?? 'No link available',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),

            // History Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'History:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                church.history ?? 'No history available',
                style: TextStyle(fontSize: 16),
              ),
            ),

            // Opening Hours
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Opening Hours:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                church.openingHours ?? 'No opening hours available',
                style: TextStyle(fontSize: 18),
              ),
            ),

            // Ticket Price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ticket Price:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                church.ticketPrice ?? 'Free',
                style: TextStyle(fontSize: 18),
              ),
            ),

            // Rating
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Rating:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${church.rating ?? 'No rating available'} ⭐',
                style: TextStyle(fontSize: 18),
              ),
            ),

            // Image Gallery
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                    child: Image.asset(church.galleryImages[index] ??
                        'assets/images/default.jpg'),
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
