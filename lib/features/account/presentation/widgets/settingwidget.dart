import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // ✅ added

class SettingItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const SettingItem({
    super.key,
    required this.icon,
    this.iconColor = AppColors.primarycolor,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(context.sw(12)), // ✅ responsive radius
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.sh(12),
          horizontal: context.sw(14),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.sw(12)),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            CircleAvatar(
              radius: context.sw(20), // ✅ responsive
              backgroundColor: Colors.transparent,
              child: Icon(
                icon,
                color: iconColor,
                size: context.sp(30), // ✅ responsive
              ),
            ),
            SizedBox(width: context.sw(12)),

            // Title + Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: context.sp(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: context.sh(2)),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: context.sp(13),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
