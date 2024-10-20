import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibehunt/data/services/firebase/firebase_options.dart';
import 'package:vibehunt/presentation/screens/info/info1.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/add_message/add_message_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/create_comment/create_comment_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/delete_comment/delete_comment_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/explore_post/explore_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_comments/fetch_all_comments_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_following_post/fetch_all_following_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followings_bloc/fetchfollowing_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_saved_post/fetch_saved_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_users_post/fetch_users_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/edit_user_profile/edit_user_profile_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_users/fetch_all_users_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_post_bloc/fetch_my_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/forget_password/forget_password_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/get_all_conversation.dart/get_all_conversation_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/get_all_users/get_all_users_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/otp_verification/otp_verification_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/post_Upload/post_upload_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/save_post/save_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/search_all_users/search_all_users_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_user_details_bloc/signin_user_details_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/user_connection_count/user_connection_count_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setLanguageCode('en');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SignUpBloc(),
            ),
            BlocProvider(
              create: (context) => OtpVerificationBloc(),
            ),
            BlocProvider(
              create: (context) => SignInBloc(),
            ),
            BlocProvider(
              create: (context) => SigninUserDetailsBloc(),
            ),
            BlocProvider(
              create: (context) => PostUploadBloc(),
            ),
            BlocProvider(
              create: (context) => FetchMyPostBloc(),
            ),
            BlocProvider(
              create: (context) => EditUserProfileBloc(),
            ),
            BlocProvider(
              create: (context) => ForgetPasswordBloc(),
            ),
            BlocProvider(
              create: (context) => FetchAllUsersBloc(),
            ),
            BlocProvider(
              create: (context) => FollowUnfollowBloc(),
            ),
            BlocProvider(
              create: (context) => FetchfollowersBloc(),
            ),
            BlocProvider(
              create: (context) => FetchfollowingBloc(),
            ),
            BlocProvider(
              create: (context) => FetchAllFollowingPostBloc(),
            ),
            BlocProvider(
              create: (context) => FetchAllCommentsBloc(),
            ),
            BlocProvider(
              create: (context) => CreateCommentBloc(),
            ),
            BlocProvider(
              create: (context) => DeleteCommentBloc(),
            ),
            BlocProvider(
              create: (context) => FetchUsersPostBloc(),
            ),
            BlocProvider(
              create: (context) => UserConnectionCountBloc(),
            ),
            BlocProvider(
              create: (context) => LikeUnlikeBloc(),
            ),
            BlocProvider(
              create: (context) => SavePostBloc(),
            ),
            BlocProvider(
              create: (context) => FetchSavedPostBloc(),
            ),
            BlocProvider(
              create: (context) => SearchAllUsersBloc(),
            ),
            BlocProvider(
              create: (context) => ExplorePostBloc(),
            ),
            BlocProvider(
              create: (context) => GetAllConversationBloc(),
            ),
            BlocProvider(
              create: (context) => GetAllUsersBloc(),
            ),
            BlocProvider(
              create: (context) => AddMessageBloc(),
            ),
            BlocProvider(
              create: (context) => ConversationBloc(),
            ),
            
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'VibeHunt',
            theme: ThemeData(
              scaffoldBackgroundColor:
                  Colors.black, // Set the background color to black
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark, // Use dark mode for the entire app
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor:
                    Colors.black, // Set AppBar background color to black
                iconTheme: IconThemeData(
                  color: Colors.white, // Set AppBar icon color to white
                ),
              ),
              textTheme: TextTheme(
                displayLarge:
                    GoogleFonts.jost(fontSize: 24.sp, color: Colors.white),
                titleMedium:
                    GoogleFonts.jost(fontSize: 18.sp, color: Colors.white),
                bodyLarge:
                    GoogleFonts.mulish(fontSize: 16.sp, color: Colors.white),
                bodyMedium:
                    GoogleFonts.mulish(fontSize: 14.sp, color: Colors.white),
              ),
              useMaterial3: true,
            ),
            home: InfoScreen1(),
          ),
        );
      },
    );
  }
}
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}