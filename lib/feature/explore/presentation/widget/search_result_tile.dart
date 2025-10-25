import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:nawy_real_state/config/theme/app_text_style.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../core/service/property_hive_store.dart';
import '../../../../generated_files/assets.gen.dart';
import '../../data/model/property_data_model.dart';

class SearchResultTile extends StatelessWidget {
  final bool hover;
  final PropertyItem? property;

  const SearchResultTile({
    super.key,
    required this.property,
    this.hover = false,
  });

  String formatEGP(num value, {String locale = 'en_EG'}) {
    final formatter = NumberFormat('#,##0', locale); // no decimals
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(PropertyHiveStore.boxName); // untyped
    final store = PropertyHiveStore();

    return Card(
      color: AppColors.whiteColor,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                property!.image!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.broken_image),
                      Text('Image failed: $error', textAlign: TextAlign.center),
                    ],
                  );
                },
              ),

              Positioned(
                top: 0,
                right: 16.w,
                child: Container(
                  height: 64.h,
                  width: 65.w,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                  child: Image.network(
                    property!.developer.logoPath!,

                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 12,
                right: 12,
                child: ValueListenableBuilder(
                  // Rebuild when ONLY this id changes
                  valueListenable: box.listenable(keys: [property!.id]),
                  builder: (context, Box b, _) {
                    final isFavorite = b.containsKey(property!.id);

                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      onPressed: () async {
                        if (isFavorite) {
                          await store.deleteById(property!.id);
                        } else {
                          await box.put(
                            property!.id,
                            Map<String, dynamic>.from(property!.toJson()),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type & Delivery
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      property!.propertyType.name,
                      style: TextStyles.normal14darkGray(
                        context,
                      ).copyWith(color: AppColors.secondaryColor),
                    ),
                    Text(
                      "Delivery ${property!.minReadyBy!.year.toString()}",
                      style: TextStyles.light12LightGray(context),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Price
                Text(
                  "${property!.currency} ${formatEGP(property!.maxPrice!)}",
                  style: TextStyles.bold16Primary(context),
                ),
                6.verticalSpace,

                Text(
                  "${formatEGP(property!.minInstallments!)} ${property!.currency}/month over ${property!.maxInstallmentYears.toString()} years",
                  style: TextStyles.light12LightGray(context),
                ),
                4.verticalSpace,

                // Location
                Text(
                  property!.compound.name,
                  style: TextStyles.normal14darkGray(context),
                ),
                2.verticalSpace,

                Text(
                  property!.area.name,
                  style: TextStyles.normal14darkGray(
                    context,
                  ).copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),

          Container(
            color: AppColors.mediumWhiteColor,
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.h),
            child: Row(
              spacing: 16.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconText(
                  Assets.icons.bed.svg(),
                  property!.numberOfBedrooms.toString(),
                  context,
                ),
                _iconText(
                  Assets.icons.bathroom.svg(),
                  property!.numberOfBathrooms.toString(),
                  context,
                ),
                _iconText(
                  Assets.icons.area.svg(),
                  "${property!.minUnitArea}-${property!.maxUnitArea} m²",
                  context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconText(Widget icon, String text, BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        icon,
        Text(text, style: TextStyles.normal13darkNavy(context)),
      ],
    );
  }
}
