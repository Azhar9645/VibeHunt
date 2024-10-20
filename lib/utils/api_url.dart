class ApiEndpoints {
  // BaseURL
  static const String baseUrl = 'https://zdm5p3m3-7002.inc1.devtunnels.ms/api';
    // static const String baseUrl = 'https://api.azhar11.online';


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
  static const String getSingleUser = '/users/get-single-user';
  static const String getUserConnections = '/users/get-count';
  static const String searchAllUsers = '/users/searchallusers?searchQuery=';
  static const String getAllUsers = '/users/getAllUsers';

  //post Urls
  static const String getPostByUserId = '/posts/getuserpost';
  static const String addpostUrl = '/posts/addPost';
  static const String updatePost = '/posts/update-post';
  static const String editProfile = '/users/edit-profile';
  static const String deletePost = '/posts/delete-post';
  static const String getAllComments = '/posts/fetch-comments';
  static const String allFollowingsPost = '/posts/allfollowingsPost';
  static const String createCommentPost = '/posts/add-comment';
  static const String deleteComments = '/posts/delete-comment';
  static const String likePost = '/posts/like-post';
  static const String unlikePost = '/posts/unlike-post';
  static const String savePost = '/posts/savePost';
  static const String unSavedPost = '/posts/savePosts';
  static const String fetchSavedPost = '/posts/savePosts';
  static const String explorePosts = '/posts/exploreposts';

  //reset Urls
  static const String forgotPassword = '/users/forgotPassword?email=';
  static const String forgetVerifyOtp = '/users/verifyOtp?email=';
  static const String updatePassword = '/users/changepassword';

  //chat urls
  static const String createConversation = '/chats/conversation';
  static const String getAllConversations = '/chats/conversation';
  static const String addMessage = '/chats/message';
  static const String getAllMessages = '/chats/message';
}
