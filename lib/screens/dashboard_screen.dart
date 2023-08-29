import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myukapp/screens/add_criminal_screen.dart';
import 'package:myukapp/screens/list_screen.dart';
import 'package:myukapp/screens/update_criminal_screen.dart';
import 'package:myukapp/styles/app_colors.dart';
import 'package:myukapp/styles/styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          'Dashboard',
          style: AppStyles.titleSty,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ShadeColor,
                foregroundColor: AppColors.textColor, 
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(250.w, 50.h),
                enableFeedback: true,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
                );
              },
              child: Text(
                'Search records',
                style: AppStyles.headingStyle,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ShadeColor,
                foregroundColor:AppColors.textColor,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(250.w, 50.h),
                enableFeedback: true,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCriminalScreen()),
                );
              },
              child: Text(
                'Add records',
                style: AppStyles.headingStyle,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ShadeColor,
                foregroundColor: AppColors.textColor,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(250.w, 50.h),
                enableFeedback: true,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateCriminalScreen()),
                );
              },
              child: Text(
                'Update records',
                style: AppStyles.headingStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
