// import 'dart:io';
//
// import 'package:shout_me/GeneralUtils/Constant.dart';
//
// class Webservices {
//   static bool isLive = false;
//
// // // new
//   static final baseUrl = isLive
//       ? "https://www.shoutmee.com/shout-me/"
//       : "http://178.79.145.76/shout-me-dev/";
//
//   static final loginAPI = "account/user_login";
//   static final forgotPassword = "account/forgot_password";
//   static final signupAPI = "account/registration";
//   static final introductionAPI = "settings/introductions";
//   static final sportsAPI = "settings/sports";
//   static final countriesAPI = "settings/countries";
//   static final socialSignUp = "account/social_signup";
//   static final socialSignUpMoreInfo = "account/get_signup_more_information";
//   static final checkMobileNumberExisr = "account/check_mobile_number_exists";
//   static final checkSaveMobileNumber = "account/change_mobile_number";
//   static final setUpProfile = "account/setup_profile";
//   static final createPost = "posts/create";
//   static final updateDeviceToken = "profile/update_token";
//
//   static final searchUser = "posts/search_user";
//   static final postLike = "post_action/like";
//   static final postFavourite = "post_action/favourite";
//   static final postBookmark = "post_action/bookmark";
//
//   static final reportIssues = "post_action/report_issues";
//   static final postReport = "post_action/report";
//
//   static final commentIssuesList = "comment/report_issues";
//   static final commentReport = "comment/report";
//
//   static final postList = "home/post_list";
//   static final searchHomeUser = "home/search_user";
//   static final searchHomePost = "home/search_post";
//   static final commentList = "comment/list";
//   static final commentCountData = "posts/post_counts";
//   static final createComment = "comment/create";
//   static final postDetails = "home/get_post_detail";
//   static final activityList = "activities/activities_list";
//   static final exploreNearByActivities = "activities/explore_nearby_activities";
//   static final createActivity = "activities/create";
//   static final invitePlayer = "activities/invite_player";
//   static final activityDetails = "activities/activity_detail?activity_id=";
//   static final participants =
//       "activities/activity_participants_list?activity_id=";
//   static final requests = "activities/activity_request_list?activity_id=";
//   static final requestsAcceptReject = "activities/activity_approve_reject";
//
//   static final userActivityReqList = "activities/user_activity_request_list";
//   static final activityApproveReject =
//       "activities/user_activity_approve_reject";
//
//   static final payment = "activities/payment";
//
//   static final teamList = "team/list_teams?activity_id=";
//
//   static final editTeamName = "team/edit_team";
//
//   static final requestToJoinActivity = "activities/join_activity";
//
//   static final cancelActivity = "activities/cancel_activity";
//   static final cancelRequest = "activities/cancel_request";
//   static final user_profile =
//       "profile/user_profile?offset="; //Login User details get
//   static final updateBio = "profile/update_bio";
//   static final updateProfile = "profile/update_profile";
//   static final updateSportActivities = "profile/update_activities";
//   static final player_profile =
//       "users/player_profile"; //UserId wise User details get
//
//   static final userFollowUnFollow = "users/follow_unfollow";
//
//   static final followersList = "profile/user_follower_list";
//   static final followingList = "profile/user_following_list";
//
//   static final playerFollowersList = "users/player_follower_list";
//   static final playerFollowingList = "users/player_following_list";
//
//   static final changePassword = "profile/change_password";
//   static final deleteUser = "users/delete_account";
//   static final getFeedback = "profile/feedback_topics";
//
//   //activity wise send invitation list
//   static final invitedParticipants = "activities/invited_participants";
//
//   //TeamFormation
//   static final removeFromTeam = "team/remove_from_team";
//   static final addToTeam = "team/add_to_team";
//   static final teamFormation = "team/formation?team_id=";
//
//   //chatApi
//   static final updateQuickbloxId = "chat/update_quickblox_id";
//
//   //Tournaments
//   static final getUpcomingTournaments = "tournament/upcoming";
//   static final getJoinedTournaments = "tournament/joined";
//   static final getTournamentDetails = "tournament/detail?tournament_id=";
//   static final getSchedule = "tournament/schedule?tournament_id=";
//   static final getPointTable = "tournament/points_table?tournament_id=";
//   static final joinTournament = "tournament/join";
//
//   //settingPage
//   static final getFavouritePost = "posts/favorite_posts?offset=";
//   static final getBookmarkedPost = "posts/bookmarked_posts?offset=";
//   static final deleteAccount = "home/post_list";
//   static final feedbackTopics = "home/feedback_topics";
//   static final sendFeedback = "home/send_feedback";
//   // static defaultHeaders() {
//   //   return {
//   //     "authorization": Constant.authUser?.authToken == null
//   //         ? ""
//   //         : Constant.authUser.authToken,
//   //     HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
//   //   };
//   // }
// }
