class UserData {
  var socialId = "";
  int user_id = 0;
  var full_name = "";
  var first_time = "";
  var phone = "";
  var firstName = "";
  var lastName = "";
  var name = "";
  var email = "";
  var token = "";
  var profilePicture = "";

  var type = "";
  dynamic error;

  String social_id = "";
  String social_type = "";

  UserData();

  UserData.fromJson(Map<String, dynamic> json) {
    socialId = json['socialId'];
    name = json['name'];
    user_id = json['user_id'];
    full_name = json['full_name'];
    first_time = json['first_time'];
    profilePicture= json['profilePicture'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    token = json['token'];
    phone = json['phone'];
    type = json['type'];
  }

  UserData.facebook(Map<String, dynamic> toJson){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.user_id;
    data['full_name'] = this.full_name;
    data['first_time'] = this.first_time;
    data['profilePicture'] = this.profilePicture;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['type'] = this.type;
    data['token'] = this.token;

  }
  UserData.withError(String error) {
    this.error = error;
  }

  // Future<ServerResponse> socialSignup() async {
  //   Completer<ServerResponse> completer = Completer();
  //   var params = {
  //     "email": email,
  //     "social_id": social_id,
  //     "full_name": full_name,
  //     "social_type": social_type
  //   };
  //   WebServiceClient.postAPICall(Webservices.socialSignUp, params)
  //       .then((response) {
  //     if (response.isSuccess) {
  //       socialProfile = SocialProfile.fromJson(response.body);
  //       if (socialProfile.first_time == "0") {
  //         PrefUtils.setUserDataPref(response.body);
  //       } else {
  //         Constant.authUser = AuthUser();
  //         Constant.authUser.authToken = socialProfile.token;
  //       }
  //       // PrefUtils.setUserDataPref(response.body);
  //       print(socialProfile);
  //       completer.complete(response);
  //     } else {
  //       completer.completeError(response.message);
  //     }
  //   }).catchError((error) {
  //     completer.completeError(error.toString());
  //   });
  //
  //   return completer.future;
  // }
}