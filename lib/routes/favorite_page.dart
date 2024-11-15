import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_akhir_dicoding/models/church_model.dart';
import 'package:proyek_akhir_dicoding/routes/church_detail_page.dart';
import 'package:proyek_akhir_dicoding/provider/favorite_churches_provider.dart';
import 'package:proyek_akhir_dicoding/routes/home_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<ChurchModel> favoriteChurches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                            builder: (context) =>
                                ChurchDetailPage(church: famousChurches[index]),
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
