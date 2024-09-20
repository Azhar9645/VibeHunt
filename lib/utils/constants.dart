import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const backgroundColor = Colors.black;
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black;
const infoBack = Color(0x47979797);
const kGrey = Color.fromARGB(255, 53, 53, 53);
const kGrey1 = Color.fromARGB(255, 40, 33, 33);

const kGreen = Color(0xFF71BC7E);
const kYellow = Color(0xFFDDD471);
const kOrange = Color(0xFFFEA384);
const kRed = Colors.red;

// Text Styles with ScreenUtil
final TextStyle jStyleW = GoogleFonts.jost(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle joffwh = GoogleFonts.jost(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  color: Colors.white70,
);

final TextStyle j30 = GoogleFonts.jost(
  fontSize: 30.sp,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle j24 = GoogleFonts.jost(
  fontSize: 24.sp,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle j20 = GoogleFonts.jost(
  fontSize: 20.sp,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle j20G = GoogleFonts.jost(
  fontSize: 20.sp,
  fontWeight: FontWeight.w500,
  color: kGreen,
);

final TextStyle jStyleB = GoogleFonts.jost(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle jStyleHint = GoogleFonts.jost(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);

// border radiusfinal
BorderRadius kradius10 = BorderRadius.circular(10);
BorderRadius kradius30 = BorderRadius.circular(30);
BorderRadius kradius20 = BorderRadius.circular(20.0);
BorderRadius kradius100 = BorderRadius.circular(100);


//auth key sharedpreference
const authKey = 'UserLoggedIn';

//token key sharedpreference
const tokenKey = 'userToken';

//userid key sharedpreference
const userIdKey = 'userId';

//userRole key sharedpreference
const userRolekey = 'userRole';

//userEmail key sharedpreference
const userEmailkey = 'userEmail';

//userName key sharedpreference
const userNamekey = 'userName';

//userProfilepic key sharedpreference
const userProfilePickey = 'userProfilePic';
