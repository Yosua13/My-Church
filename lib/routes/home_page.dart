import 'package:flutter/material.dart';
import 'package:proyek_akhir/data/famous_churches.dart';
import 'package:proyek_akhir/models/church_model.dart';
import 'package:proyek_akhir/routes/church_detail_page.dart';

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
        backgroundColor: const Color(0xFFFFE082),
        actions: [
          // Menambahkan AnimatedSwitcher untuk ikon transisi yang halus
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey<bool>(isGridView),
              icon: Icon(
                isGridView ? Icons.grid_view : Icons.list,
                size: 32,
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
          if (constraints.maxWidth <= 600) {
            return famousChurchesGridView(2);
          } else if (constraints.maxWidth <= 1200) {
            return famousChurchesGridView(4);
          } else {
            return famousChurchesGridView(6);
          }
        } else {
          return famousChurchesListView();
        }
      }),
    );
  }

  Widget famousChurchesListView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          // Tampilan grid untuk layar lebar (desktop)
          return GridView.builder(
            itemCount: searchResult.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 3.5,
            ),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (context, index) {
              final church = searchResult[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChurchDetailPage(
                          church: searchResult[index],
                        ),
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
        } else {
          // Tampilan list untuk layar lebih kecil (tablet dan ponsel)
          return ListView.builder(
            itemCount: searchResult.length,
            physics: const BouncingScrollPhysics(),
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
                        builder: (context) => ChurchDetailPage(
                          church: searchResult[index],
                        ),
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

