class ApiEndpoints {
  // BaseURL
  static const String baseUrl = 'https://zdm5p3m3-7002.inc1.devtunnels.ms/api';

  // UserUrl
  static const String signUp = '/users/send-otp';
  static const String verifyOtp = '/users/verify-otp';
  static const String login = '/users/login';
  static const String googleLogin = '/users/google-login';
  static const String logginedUser = '/users/getuser';
  static const String allUsers = '/users/fetch-users';
  static const String followUser = '/users/follow';
  static const String unfollowUser = '/users/unfollow';
  static const String getFollowing = '/users/fetch-following';
  static const String getFollowers = '/users/fetch-followers';
 


  
  static const String getPostByUserId = '/posts/getuserpost';
  static const String addpostUrl = '/posts/addPost';
  static const String updatePost = '/posts/update-post';
  static const String editProfile = '/users/edit-profile';
  static const String deletePost = '/posts/delete-post';
  static const String getAllComments = '/posts/fetch-comments';



  static const String forgotPassword = '/users/forgotPassword?email=';
  static const String forgetVerifyOtp = '/users/verifyOtp?email=';
  static const String updatePassword = '/users/changepassword';
}
