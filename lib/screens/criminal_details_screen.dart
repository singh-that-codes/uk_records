import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myukapp/styles/app_colors.dart';
import 'package:myukapp/styles/styles.dart';
 
class CriminalDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> criminalDetails;

  const CriminalDetailsScreen({super.key, required this.criminalDetails});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          'Criminal Details',
          style: AppStyles.headingStyle,
          )
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200.h, // Set the desired height for the image
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${criminalDetails['imageUrl']}'),
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Criminal\'s Name:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['fullName']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Father\'s Name:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['fathersName']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mother\'s Name:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['mothersName']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['age']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['address']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['phone']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Criminal Record:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['criminalRecord']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Related Records:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['relatedRecords']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Summary:', style: AppStyles.commonTextStyleBold),
                      Text('${criminalDetails['summary']}', style: AppStyles.commonTextStyle),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
