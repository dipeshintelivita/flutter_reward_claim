//
//
//
//
//
//
//
//
// final facebookLogInResult = await FacebookAuth.instance.login();
// final userData = await FacebookAuth.instance.getUserData();
// final facebookAuthCredential =
// FacebookAuthProvider.credential(facebookLogInResult.accessToken.token);
// await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// await FirebaseFirestore.instance.collection('users').add({
// 'email': userData['email'],
// 'imageUrl': userData['picture']['data']['url'],
// 'name': userData['name']
// });
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter_reward_claim/Webservices.dart';
// //
// // class WebServiceClient {
// //   static final version = "api_v1/";
// //
// //   static Future<dynamic> getAPICallForRowResponse(
// //       String apiName,
// //       Map<String, dynamic> params,
// //       ) async {
// //     //var url = baseUrl + version + apiName;
// //     var postUri = Uri.parse(apiName);
// //
// //     var response = await http.get(postUri);
// //
// //     var jsValue = json.decode(response.body);
// //
// //     return jsValue;
// //   }
// //
// //   static Future<ServerResponse> getAPICall(
// //       String apiName,
// //       /*String params*/
// //       ) async {
// //     var url = Webservices.baseUrl + version + apiName;
// //     if (apiName.startsWith("http")) {
// //       url = apiName;
// //     }
// //     print("Get Url :" + url);
// //     var postUri = Uri.parse(url);
// //     var checkInternet = await Constant.checkInternet();
// //     ServerResponse serverResponse;
// //     if (!checkInternet) {
// //       serverResponse = ServerResponse();
// //       serverResponse.isSuccess = false;
// //       serverResponse.message = "Please check your internet connection";
// //     } else {
// //       var header = Webservices.defaultHeaders();
// //       var response = await http.get(
// //         postUri,
// //         headers: header,
// //       );
// //       print(response.body);
// //
// //       var jsValue = json.decode(response.body);
// //       serverResponse = ServerResponse.withJson(jsValue);
// //     }
// //
// //     return serverResponse;
// //   }
// //
// //   static Future<ServerResponse> postAPICall(
// //       String apiName, Map<String, dynamic> params) async {
// //     var url = Webservices.baseUrl + version + apiName;
// //     if (apiName.startsWith("http")) {
// //       url = apiName;
// //     }
// //     var postUri = Uri.parse(url);
// //     print("\n");
// //     print("Request URL: $url");
// //     print("Request parameters: $params");
// //     print("\n");
// //
// //     var completer = Completer<ServerResponse>();
// //
// //     var checkInternet = await Constant.checkInternet();
// //     if (!checkInternet) {
// //       var response = ServerResponse();
// //       response.isSuccess = false;
// //       response.message = "Please check your internet connection";
// //       completer.complete(response);
// //     } else {
// //       print("Header :- " + Webservices.defaultHeaders().toString());
// //       var header = Webservices.defaultHeaders();
// //       http.post(postUri, headers: header, body: params).then((response) {
// //         print(response.body);
// //         var statusCode = response.statusCode;
// //         if (statusCode == 401) {}
// //         if (response.body.contains("User not found.")) {
// //           print("Hello True");
// //           Navigator.pushAndRemoveUntil(
// //               Constant.context,
// //               MaterialPageRoute(builder: (context) => LoginScreen()),
// //                   (route) => false);
// //           return;
// //         }
// //         var header = response.headers['token'];
// //         if (header != null) {
// //           PrefUtils.setStringValue(PrefUtils.token, header);
// //           if (Constant.authUser == null) Constant.authUser = AuthUser();
// //           Constant.authUser.authToken = header;
// //         }
// //         var jsValue = json.decode(response.body);
// //
// //         var serverResponseObj = ServerResponse.withJson(jsValue);
// //
// //         completer.complete(serverResponseObj);
// //       }).catchError((error) {
// //         var response = ServerResponse();
// //
// //         switch (error.runtimeType) {
// //           case SocketException:
// //             print("socekt exception");
// //             response.message = error.osError.message;
// //
// //             break;
// //           default:
// //             response.message = error.toString();
// //             break;
// //         }
// //
// //         response.isSuccess = false;
// //         completer.complete(response);
// //       });
// //     }
// //
// //     return completer.future;
// //   }
// //
// //   static Future<ServerResponse> multiPartAPI(
// //       String apiName, Map<String, dynamic> params, File imageFile) async {
// //     var url = Webservices.baseUrl + version + apiName;
// //     var postUri = Uri.parse(url);
// //
// //     print("reqeust Url: \n$url");
// //     print("reqeust parameters: \n$params");
// //     var request =
// //     new MultipartRequest("POST", postUri, onProgress: (current, total) {});
// //     params.forEach((key, value) => {request.fields[key] = value});
// //     if (imageFile != null) {
// //       var ext = imageFile.uri.pathSegments.last.split(".")[1];
// //       var filename = "image." + ext;
// //
// //       var multiPart = await http.MultipartFile.fromPath(
// //           "profile_picture", imageFile.path,
// //           filename: filename);
// //
// //       request.files.add(multiPart);
// //
// //       /* var multiPart = await http.MultipartFile.fromPath(
// //           "profile_picture", imageFile.path,
// //           filename: "test.jpg");
// //       request.files.add(multiPart);*/
// //     }
// //
// //     request.headers.addAll(Webservices.defaultHeaders());
// //
// //     var result = await request.send();
// //     var completer = Completer<ServerResponse>();
// //
// //     result.stream.transform(utf8.decoder).listen((body) {
// //       var value = json.decode(body);
// //       print(value);
// //       var serverResponseObj = ServerResponse.withJson(value);
// //       completer.complete(serverResponseObj);
// //     });
// //
// //     return completer.future;
// //   }
// //
// //   static Future<ServerResponse> multipleImagesMultiPartAPI(String apiName,
// //       Map<String, dynamic> params, List<MultiPartFile> imageFiles,
// //       {String postType}) async {
// //     var url = Webservices.baseUrl + version + apiName;
// //     var postUri = Uri.parse(url);
// //
// //     print("reqeust Url: \n$url");
// //     print("reqeust parameters: \n$params");
// //
// //     var request =
// //     new MultipartRequest("POST", postUri, onProgress: (current, total) {});
// //     request.persistentConnection = true;
// //
// //     params.forEach((key, value) => {request.fields[key] = value});
// //     if (imageFiles != null) {
// //       for (var i = 0; i < imageFiles.length; i++) {
// //         var mpart = imageFiles[i];
// //         var bytes = await mpart.file.readAsBytes();
// //         var mimeType =
// //             lookupMimeType(mpart.file.path, headerBytes: bytes) ?? "image/png";
// //         print("Mime Type: $mimeType");
// //         var type = mimeType.split("/")[0];
// //         var subType = mimeType.split("/")[1];
// //
// //         var extension = Platform.isAndroid || postType == "2"
// //             ? subType
// //             : setupExtension(mpart);
// //
// //         var filename = "image$i." + extension;
// //         print("FileName $filename");
// //         var multiPart = await http.MultipartFile.fromPath(
// //             mpart.paramName, mpart.file.path,
// //             filename: filename, contentType: mime.MediaType(type, subType));
// //
// //         request.files.add(multiPart);
// //       }
// //     }
// //     request.headers.addAll(Webservices.defaultHeaders());
// //     var completer = Completer<ServerResponse>();
// //
// //     request.send().then((result) async {
// //       print("found result ${result.statusCode}");
// //       print(result.toString());
// //       var resultString = await result.stream.bytesToString();
// //       print("rsult done========");
// //       print(resultString);
// //       var value = json.decode(resultString);
// //       // print(value);
// //       var serverResponseObj = ServerResponse.withJson(value);
// //       completer.complete(serverResponseObj);
// //     }).catchError((error) {
// //       print("fond error $error");
// //       var response = ServerResponse();
// //
// //       switch (error.runtimeType) {
// //         case SocketException:
// //           if (error.osError != null) {
// //             if (error.osError.errorCode == 32) {
// //               response.message = "Connection time out";
// //             } else if (error.osError.errorCode == 8 ||
// //                 error.osError.errorCode == 7) {
// //               response.message =
// //               "Internet connection not available, check your connection and try again";
// //             } else {
// //               response.message = error.osError.message ?? error.toString();
// //             }
// //           } else {
// //             response.message = error.message ?? error.toString();
// //           }
// //           break;
// //         default:
// //           response.message = error.message ?? error.toString();
// //           break;
// //       }
// //       response.isSuccess = false;
// //       completer.complete(response);
// //     }).timeout(Duration(seconds: 60), onTimeout: () {
// //       var response = ServerResponse();
// //       response.message = "Timeout! unable to get the data";
// //       response.isSuccess = false;
// //       completer.complete(response);
// //     });
// //     return completer.future;
// //   }
// //
// //   static setupExtension(MultiPartFile file) {
// //     if ((file.file.path.contains("mp4"))) {
// //       return "mov";
// //     } else if (file.file.path.contains("MOV") ||
// //         file.file.path.contains("MP4")) {
// //       return "mp4";
// //     }
// //   }
// // }