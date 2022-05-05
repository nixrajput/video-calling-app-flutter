import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:video_calling_app/constants/urls.dart';

class ApiProvider {
  ApiProvider(this._client, {this.baseUrl}) {
    baseUrl ??= AppUrls.baseUrl;
  }

  final http.Client _client;

  String? baseUrl;

  Future<http.Response> login(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.loginEndpoint),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> register(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.registerEndpoint),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> sendPasswordResetEmail(
      Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.forgotPasswordEndpoint),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> resetPassword(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.resetPasswordEndpoint),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> getProfileDetails(String token) async {
    final response = await _client.get(
      Uri.parse(baseUrl! + AppUrls.profileDetailsEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.StreamedResponse> uploadProfilePicture(
    String token,
    http.MultipartFile multiPartFile,
  ) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl! + AppUrls.uploadProfilePicEndpoint),
    );

    request.headers.addAll({
      "content-type": "application/json",
      "authorization": "Bearer $token",
    });

    request.files.add(multiPartFile);

    final response = await request.send();

    return response;
  }

  Future<http.Response> updateProfileDetails(
      Map<String, dynamic> body, String token) async {
    final response = await _client.put(
      Uri.parse(baseUrl! + AppUrls.updateProfileDetailsEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> changePassword(
      Map<String, dynamic> body, String token) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.updatePasswordEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> getUserProfileDetails(
      String userId, String token) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.userDetailsEndpoint}?id=$userId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> checkUsernameAvailability(
      String uname, String token) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.checkUsernameAvailableEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'uname': uname}),
    );

    return response;
  }

  Future<http.Response> updateUsername(String uname, String token) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.updateUsernameEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'uname': uname}),
    );

    return response;
  }

  Future<http.Response> getRctToken(String channelId, String userId) async {
    final response = await _client.get(
      Uri.parse(
          '${AppUrls.tokenBaseUrl}${AppUrls.getRtcToken}?channelName=$channelId&uid=$userId'),
      headers: {
        "content-type": "application/json",
      },
    );

    return response;
  }
}
