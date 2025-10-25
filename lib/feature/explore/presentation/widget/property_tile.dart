import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/app_text_style.dart';

class PropertyTile extends StatelessWidget {
  final String? name, image;

  const PropertyTile({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 60.w,
        height: 60.h,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Color(0xFFEFF2F5),
          shape: BoxShape.circle,
        ),
        child: image!.isNotEmpty
            ? Image.network(
                image ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.location_pin,
                  size: 30,
                  color: AppColors.darkNavyColor,
                ),
              )
            : Icon(
                Icons.location_pin,
                size: 30,
                color: AppColors.darkNavyColor,
              ),
      ),
      title: Text(name!, style: TextStyles.normal14MediumBlack(context)),
    );
  }
}
