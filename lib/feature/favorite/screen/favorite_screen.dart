import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nawy_real_state/config/theme/app_color.dart';
import 'package:nawy_real_state/core/constant/widget/empty_list_widget.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_data_model.dart';

import '../../../core/service/property_hive_store.dart';
import '../../explore/presentation/widget/search_result_tile.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<PropertyItem>? items;

  @override
  Widget build(BuildContext context) {
    final store = PropertyHiveStore();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        title: const Text('Favorite'),
        actions: [
          IconButton(
            tooltip: 'Clear',
            onPressed: () async {
              await store.clear();
              setState(() {});
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),

      body: ValueListenableBuilder(
        valueListenable: Hive.box(PropertyHiveStore.boxName).listenable(),
        builder: (context, Box box, _) {
          final store = PropertyHiveStore();
          final favorites = store.getAll();
          if (favorites.isEmpty) {
            return EmptyResults();
          } else {
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final property = favorites[index];
                return SearchResultTile(property: property);
              },
            );
          }
        },
      ),
    );
  }
}
