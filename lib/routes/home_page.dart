import 'package:flutter/material.dart';
import 'package:proyek_akhir_dicoding/models/church_model.dart';
import 'package:proyek_akhir_dicoding/routes/church_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  List<ChurchModel> searchResult = [];
  bool isGridView = false;

  void searchChurches(String query) {
    final results = famousChurches
        .where(
            (church) => church.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      searchQuery = query;
      searchResult = results;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchResult = famousChurches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFE082),
        actions: [
          // Menambahkan AnimatedSwitcher untuk ikon transisi yang halus
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey<bool>(isGridView),
              icon: Icon(
                isGridView ? Icons.grid_view : Icons.list,
                size: 28,
                color: Colors.black, // Warna ikon putih
              ),
              onPressed: () {
                setState(() {
                  isGridView = !isGridView; // Mengubah tampilan
                });
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: TextField(
              onChanged: searchChurches,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                hintText: 'Search by name',
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.amber),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 18,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (isGridView == false) {
          return famousChurchesGridView(2);
        } else {
          return famousChurchesListView();
        }
      }),
    );
  }

  Widget famousChurchesListView() {
    return ListView.builder(
      itemCount: searchResult.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final church = searchResult[index];
        return Card(
          margin: const EdgeInsets.all(12.0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChurchDetailPage(church: searchResult[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Gambar gereja
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      church.mainImageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Informasi gereja
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          church.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Fontserrat',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${church.city}, ${church.country}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Rating
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${church.rating} / 5',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget famousChurchesGridView(int gridCount) {
    return GridView.builder(
      itemCount: searchResult.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            gridCount, // Menggunakan gridCount untuk menentukan jumlah kolom
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        final church = searchResult[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChurchDetailPage(church: searchResult[index]),
              ),
            );
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12), // Border radius untuk card
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(12), // Border radius untuk gambar
              child: GridTile(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      church.mainImageUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black
                          .withOpacity(0.4), // Overlay gelap di gambar
                    ),
                    // Teks di atas gambar
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            church.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${church.city}, ${church.country}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${church.rating} / 5',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

final List<ChurchModel> famousChurches = [
  ChurchModel(
    name: 'St. Peter\'s Basilica',
    city: 'Vatican City',
    province: '',
    country: 'Vatican City',
    description:
        'St. Peter\'s Basilica is one of the largest churches in the world, known for its Renaissance architecture and as a major site of Christian pilgrimage.',
    mainImageUrl: 'assets/images/St. Peter Basilica 1.jpg',
    galleryImages: [
      'assets/images/St. Peter Basilica 2.jpg',
      'assets/images/St. Peter Basilica 3.jpg',
      'assets/images/St. Peter Basilica 4.jpg'
    ],
    locationDetails: 'Vatican City, Vatican City',
    address: 'Piazza San Pietro, 00120 Vatican City',
    gpsLink: 'https://goo.gl/maps/R8oZpSfYFNUiXRYm7',
    history:
        'Built in the 16th century, St. Peter\'s Basilica was designed by Donato Bramante, Michelangelo, Carlo Maderno, and Gian Lorenzo Bernini. It\'s regarded as one of the holiest Catholic shrines and one of the largest churches in the world.',
    publicFacilities: ['Toilet', 'Souvenir Shop', 'Cafe'],
    openingHours: '7:00 AM - 7:00 PM',
    ticketPrice: 'Free (dome access: €10)',
    rating: 4.8,
    interestingFacts:
        'It is believed to be the burial site of Saint Peter, one of Jesus\' apostles and the first Pope.',
  ),
  ChurchModel(
    name: 'Sagrada Familia',
    city: 'Barcelona',
    province: 'Catalonia',
    country: 'Spain',
    description:
        'The Sagrada Familia is a large unfinished Roman Catholic church designed by Antoni Gaudí, a symbol of Barcelona and renowned for its unique architecture.',
    mainImageUrl: 'assets/images/Sagrada Familia 1.jpg',
    galleryImages: [
      'assets/images/Sagrada Familia 2.jpeg',
      'assets/images/Sagrada Familia 3.jpg',
      'assets/images/Sagrada Familia 4.jpg'
    ],
    locationDetails: 'Barcelona, Catalonia, Spain',
    address: 'Carrer de Mallorca, 401, 08013 Barcelona, Spain',
    gpsLink: 'https://goo.gl/maps/8D5MfWEDwBm',
    history:
        'Construction began in 1882 under architect Francisco de Paula del Villar, but Gaudí took over a year later. Still under construction, the Sagrada Familia remains an icon of architectural ingenuity.',
    publicFacilities: ['Toilet', 'Cafe', 'Audio Guides'],
    openingHours: '9:00 AM - 8:00 PM',
    ticketPrice: '€26 for adults, €20 for students',
    rating: 4.7,
    interestingFacts:
        'Gaudí worked on the Sagrada Familia until his death in 1926, dedicating the last 15 years of his life exclusively to its construction.',
  ),
  ChurchModel(
    name: 'Notre-Dame Cathedral',
    city: 'Paris',
    province: 'Île-de-France',
    country: 'France',
    description:
        'Notre-Dame Cathedral is a famous Gothic cathedral on the Île de la Cité in Paris, known for its sculptures, stained glass, and historical significance.',
    mainImageUrl: 'assets/images/Notre-Dame Cathedral 1.jpg',
    galleryImages: [
      'assets/images/Notre-Dame Cathedral 2.jpg',
      'assets/images/Notre-Dame Cathedral 3.jpg',
      'assets/images/Notre-Dame Cathedral 4.jpg'
    ],
    locationDetails: 'Paris, Île-de-France, France',
    address: '6 Parvis Notre-Dame - Pl. Jean-Paul II, 75004 Paris, France',
    gpsLink: 'https://goo.gl/maps/T5D1m84RJrH2',
    history:
        'Construction began in 1163 and was largely completed by 1260. Over the centuries, it has witnessed numerous historical events, including the coronation of Napoleon.',
    publicFacilities: ['Gift Shop', 'Restrooms'],
    openingHours: '8:00 AM - 6:45 PM',
    ticketPrice: 'Free entry (tower access: €10)',
    rating: 4.6,
    interestingFacts:
        'The cathedral is known for its role in Victor Hugo\'s novel *The Hunchback of Notre-Dame*, which helped raise awareness for its preservation.',
  ),
  ChurchModel(
    name: 'Westminster Abbey',
    city: 'London',
    province: 'England',
    country: 'United Kingdom',
    description:
        'Westminster Abbey is a Gothic abbey church in London, the traditional site for the coronation of British monarchs and famous for its architecture.',
    mainImageUrl: 'assets/images/Westminster Abbey 1.jpg',
    galleryImages: [
      'assets/images/Westminster Abbey 2.jpg',
      'assets/images/Westminster Abbey 3.jpg',
      'assets/images/Westminster Abbey 4.jpg'
    ],
    locationDetails: 'London, England, United Kingdom',
    address: '20 Deans Yd, London SW1P 3PA, United Kingdom',
    gpsLink: 'https://goo.gl/maps/Uv2QxR29syE2',
    history:
        'Founded in 960, it has served as the site of every British coronation since William the Conqueror in 1066.',
    publicFacilities: ['Cafe', 'Gift Shop', 'Restrooms'],
    openingHours: '9:30 AM - 3:30 PM',
    ticketPrice: '£24 for adults',
    rating: 4.7,
    interestingFacts:
        'Westminster Abbey has over 3,000 tombs and monuments, including those of famous poets, scientists, and British royalty.',
  ),
  ChurchModel(
    name: 'St. Basil\'s Cathedral',
    city: 'Moscow',
    province: '',
    country: 'Russia',
    description:
        'St. Basil\'s Cathedral is an iconic church in Moscow known for its colorful, onion-shaped domes and unique architecture.',
    mainImageUrl: 'assets/images/St. Basil Cathedral 1.jpg',
    galleryImages: [
      'assets/images/St. Basil Cathedral 2.jpg',
      'assets/images/St. Basil Cathedral 3.jpg',
      'assets/images/St. Basil Cathedral 4.jpg'
    ],
    locationDetails: 'Moscow, Russia',
    address: 'Red Square, Moscow, Russia, 109012',
    gpsLink: 'https://goo.gl/maps/Ds7m45XJ7FE2',
    history:
        'Completed in 1561 by Tsar Ivan the Terrible to commemorate his military victories, it is a symbol of Russia and Orthodox Christianity.',
    publicFacilities: ['Gift Shop', 'Restrooms'],
    openingHours: '10:00 AM - 6:00 PM',
    ticketPrice: '700 RUB',
    rating: 4.8,
    interestingFacts:
        'The cathedral\'s colorful design is unique and does not follow any particular architectural style found elsewhere in the world.',
  ),
  ChurchModel(
    name: 'Milan Cathedral',
    city: 'Milan',
    province: 'Lombardy',
    country: 'Italy',
    description:
        'The Milan Cathedral, or Duomo di Milano, is a Gothic cathedral famous for its intricate marble facade and spires.',
    mainImageUrl: 'assets/images/Milan Cathedral 1.jpg',
    galleryImages: [
      'assets/images/Milan Cathedral 2.jpg',
      'assets/images/Milan Cathedral 3.jpg',
      'assets/images/Milan Cathedral 4.jpg'
    ],
    locationDetails: 'Milan, Lombardy, Italy',
    address: 'Piazza del Duomo, 20122 Milano MI, Italy',
    gpsLink: 'https://goo.gl/maps/dXPz8pj1K5r',
    history:
        'Started in 1386 and took nearly six centuries to complete, it reflects Gothic, Renaissance, and Baroque styles.',
    publicFacilities: ['Toilet', 'Gift Shop', 'Cafe'],
    openingHours: '8:00 AM - 7:00 PM',
    ticketPrice: '€3 entry (roof access: €13)',
    rating: 4.8,
    interestingFacts:
        'With over 3,400 statues, it is one of the most decorated buildings in the world.',
  ),
  ChurchModel(
    name: 'Church of the Holy Sepulchre',
    city: 'Jerusalem',
    province: '',
    country: 'Israel',
    description:
        'The Church of the Holy Sepulchre is located in the Christian Quarter of Jerusalem and is believed to contain the site of Jesus\'s crucifixion and burial.',
    mainImageUrl: 'assets/images/Church of the Holy Sepulchre 1.jpg',
    galleryImages: [
      'assets/images/Church of the Holy Sepulchre 2.jpg',
      'assets/images/Church of the Holy Sepulchre 3.jpg',
      'assets/images/Church of the Holy Sepulchre 4.jpg'
    ],
    locationDetails: 'Jerusalem, Israel',
    address: 'Christian Quarter, Jerusalem, Israel',
    gpsLink: 'https://goo.gl/maps/fE3JnK5qrrR2',
    history:
        'Built in the 4th century by Emperor Constantine, the church is one of the holiest sites in Christianity.',
    publicFacilities: ['Restrooms'],
    openingHours: '4:00 AM - 8:00 PM',
    ticketPrice: 'Free',
    rating: 4.8,
    interestingFacts:
        'It is a major pilgrimage destination and is divided among various Christian denominations.',
  ),
  ChurchModel(
    name: 'La Catedral de Sevilla',
    city: 'Seville',
    province: 'Andalusia',
    country: 'Spain',
    description:
        'The Seville Cathedral, also known as the Cathedral of Saint Mary of the See, is a UNESCO World Heritage Site and the largest Gothic cathedral in the world.',
    mainImageUrl: 'assets/images/Katedral Sevilla 1.jpg',
    galleryImages: [
      'assets/images/Katedral Sevilla 2.JPG',
      'assets/images/Katedral Sevilla 3.jpg',
      'assets/images/Katedral Sevilla 4.JPG'
    ],
    locationDetails: 'Seville, Andalusia, Spain',
    address: 'Av. de la Constitución, s/n, 41004 Sevilla, Spain',
    gpsLink: 'https://goo.gl/maps/9yX7BdntdZL2',
    history:
        'Constructed from 1401 to 1506, it was built to demonstrate the wealth of the city after the Reconquista.',
    publicFacilities: ['Gift Shop', 'Restrooms'],
    openingHours: '8:00 AM - 2:00 PM',
    ticketPrice: '€10',
    rating: 4.7,
    interestingFacts: 'It houses the tomb of Christopher Columbus.',
  ),
  ChurchModel(
    name: 'Saint Mark\'s Basilica',
    city: 'Venice',
    province: 'Veneto',
    country: 'Italy',
    description:
        'Saint Mark\'s Basilica in Venice is known for its opulent design, gold mosaics, and as a symbol of Venetian wealth and power.',
    mainImageUrl: 'assets/images/Saint Mark Basilica 1.jpg',
    galleryImages: [
      'assets/images/Saint Mark Basilica 2.jpg',
      'assets/images/Saint Mark Basilica 3.jpg',
      'assets/images/Saint Mark Basilica 4.jpg'
    ],
    locationDetails: 'Venice, Veneto, Italy',
    address: 'Piazza San Marco, 328, 30100 Venezia VE, Italy',
    gpsLink: 'https://goo.gl/maps/F3BoB3oh5N32',
    history:
        'Built in 1094, it served as the Doge\'s private chapel until it became the city\'s cathedral in 1807.',
    publicFacilities: ['Toilet', 'Gift Shop', 'Audio Guides'],
    openingHours: '9:30 AM - 5:00 PM',
    ticketPrice: 'Free entry (museum: €5)',
    rating: 4.8,
    interestingFacts:
        'The basilica houses the relics of Saint Mark the Evangelist.',
  ),
  ChurchModel(
    name: 'St. Patrick\'s Cathedral',
    city: 'New York City',
    province: 'New York',
    country: 'United States',
    description:
        'St. Patrick\'s Cathedral is a Neo-Gothic Roman Catholic cathedral in Manhattan, known for its grandeur and central location on Fifth Avenue.',
    mainImageUrl: 'assets/images/St. Patrick Cathedral 1.jpg',
    galleryImages: [
      'assets/images/St. Patrick Cathedral 2.jpg',
      'assets/images/St. Patrick Cathedral 3.jpg',
      'assets/images/St. Patrick Cathedral 4.jpg'
    ],
    locationDetails: 'New York City, New York, United States',
    address: '5th Ave, New York, NY 10022, United States',
    gpsLink: 'https://goo.gl/maps/sM9Xv9yY1kL2',
    history:
        'Construction of St. Patrick\'s Cathedral began in 1858 and was completed in 1878. It serves as the largest Catholic cathedral in the United States and is one of New York\'s most prominent landmarks. The cathedral is known for its grandeur and impressive Neo-Gothic architecture.',
    publicFacilities: ['Restrooms', 'Gift Shop', 'Cafe', 'Tour Guides'],
    openingHours: '6:30 AM - 8:00 PM (Open every day)',
    ticketPrice: 'Free entry (donations accepted)',
    rating: 4.7,
    interestingFacts:
        'St. Patrick\'s Cathedral is located across from Rockefeller Center and is a popular spot for tourists and worshippers alike. The cathedral underwent a \$177 million restoration that was completed in 2015.',
  ),
];
