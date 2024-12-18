import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_akhir/models/church_model.dart';
import 'package:proyek_akhir/provider/favorite_churches_provider.dart';
// import 'package:url_launcher/url_launcher.dart';

class DetailsWebAndTabletPage extends StatefulWidget {
  final ChurchModel church;

  const DetailsWebAndTabletPage({super.key, required this.church});

  @override
  State<DetailsWebAndTabletPage> createState() =>
      DetailsWebAndTabletPageState();
}

class DetailsWebAndTabletPageState extends State<DetailsWebAndTabletPage> {
  late bool isFavorite;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE082),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsif: Ubah layout berdasarkan ukuran layar
          final isWideScreen = constraints.maxWidth > 1200;
          final isTablet =
              constraints.maxWidth > 600 && constraints.maxWidth <= 1200;

          double fontSizeTitle = isWideScreen ? 32 : (isTablet ? 28 : 24);
          double fontSizeContent = isWideScreen ? 18 : (isTablet ? 16 : 14);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isWideScreen ? 5 : 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                church.mainImageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height:
                                    isWideScreen ? 400 : (isTablet ? 300 : 200),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              church.name,
                              style: TextStyle(
                                fontSize: fontSizeTitle,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            cardData(
                              dataModel: church.locationDetails,
                              hintText: 'Location',
                              fontSize: fontSizeContent,
                            ),
                            cardData(
                              dataModel: church.address,
                              hintText: 'Address',
                              fontSize: fontSizeContent,
                            ),
                            const SizedBox(height: 16),
                            _buildGPSLink(context, church, fontSizeContent),
                            const SizedBox(height: 16),
                            cardData(
                              dataModel: church.history,
                              hintText: 'History',
                              fontSize: fontSizeContent,
                            ),
                            cardData(
                              dataModel: church.openingHours,
                              hintText: 'Opening Hours',
                              fontSize: fontSizeContent,
                            ),
                            cardData(
                              dataModel: church.ticketPrice,
                              hintText: 'Ticket Price',
                              fontSize: fontSizeContent,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Rating: ${church.rating}⭐',
                              style: TextStyle(
                                fontSize: fontSizeContent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isWideScreen) const SizedBox(width: 32),
                      if (isWideScreen)
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gallery:',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildGallery(church, isWideScreen, isTablet),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (!isWideScreen) ...[
                    const SizedBox(height: 32),
                    const Text(
                      'Gallery:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildGallery(church, isWideScreen, isTablet),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cardData({
    required String dataModel,
    required String hintText,
    required double fontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$hintText:",
              style: TextStyle(
                fontSize: fontSize,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              dataModel,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGPSLink(
      BuildContext context, ChurchModel church, double fontSize) {
    return GestureDetector(
      onTap: () async {
        // final Uri uri = Uri.parse(church.gpsLink);
        // if (await canLaunchUrl(uri)) {
        //   await launchUrl(
        //     uri,
        //     mode: LaunchMode.externalApplication,
        //   );
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text('Cannot open link: ${church.gpsLink}'),
        //     ),
        //   );
        // }
      },
      child: Text(
        church.gpsLink,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildGallery(ChurchModel church, bool isWideScreen, bool isTablet) {
    final crossAxisCount = isWideScreen ? 4 : (isTablet ? 3 : 2);
    return SizedBox(
      height: 200.0,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: church.galleryImages.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              church.galleryImages[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
