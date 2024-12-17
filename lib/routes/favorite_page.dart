import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_akhir/models/church_model.dart';
import 'package:proyek_akhir/provider/favorite_churches_provider.dart';
import 'package:proyek_akhir/routes/church_detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<ChurchModel> _favoriteChurches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE082),
        title: const Text('My Favorite Churches'),
      ),
      body: Consumer<FavoriteChurchesProvider>(
        builder: (context, provider, child) {
          final favoriteChurches = provider.favoriteChurches;

          return favoriteChurches.isEmpty
              ? const Center(child: Text('No favorite churches'))
              : ListView.builder(
                  itemCount: favoriteChurches.length,
                  itemBuilder: (context, index) {
                    final church = favoriteChurches[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChurchDetailPage(
                                church: favoriteChurches[index]),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.asset(
                          church.mainImageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(church.name),
                        subtitle: Text('${church.city}, ${church.country}'),
                        trailing: const Icon(Icons.favorite, color: Colors.red),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
