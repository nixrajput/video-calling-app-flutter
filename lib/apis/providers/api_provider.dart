import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:video_calling_app/constants/secrets.dart';
import 'package:video_calling_app/constants/urls.dart';

class ApiProvider {
  ApiProvider(this._client, {this.baseUrl}) {
    baseUrl ??= AppSecrets.awsServerUrl;
  }

  final http.Client _client;

  String? baseUrl;

  /// Server -------------------------------------------------------------------

  Future<http.Response> checkServerHealth() async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.serverHealthEndpoint}'),
      headers: {"content-type": "application/json"},
    );

    return response;
  }

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

  Future<http.Response> forgotPassword(Map<String, dynamic> body) async {
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
      Uri.parse('${baseUrl!}${AppUrls.resetPasswordEndpoint}'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> sendVerifyAccountOtp(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.verifyAccountEndpoint}'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> verifyAccount(Map<String, dynamic> body) async {
    final response = await _client.put(
      Uri.parse('${baseUrl!}${AppUrls.verifyAccountEndpoint}'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> validateToken(String token) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.validateTokenEndpoint}?token=$token'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
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

  Future<http.Response> uploadProfilePicture(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.uploadProfilePicEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> deleteProfilePicture(String token) async {
    final response = await _client.delete(
      Uri.parse('${baseUrl!}${AppUrls.deleteProfilePicEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> checkUsername(String token, String uname) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.checkUsernameEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'uname': uname}),
    );

    return response;
  }

  Future<http.Response> changeUsername(String token, String uname) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.changeUsernameEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'uname': uname}),
    );

    return response;
  }

  Future<http.Response> updateProfile(
      String token, Map<String, dynamic> body) async {
    final response = await _client.put(
      Uri.parse('${baseUrl!}${AppUrls.updateProfileEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> changePassword(
      String token, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.changePasswordEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> verifyPassword(String token, String password) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.verifyPasswordEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({"password": password}),
    );

    return response;
  }

  Future<http.Response> getUserDetailsById(String token, String userId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.userDetailsEndpoint}?id=$userId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getUserDetailsByUsername(
      String token, String username) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.userDetailsEndpoint}?username=$username'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  // Future<http.Response> checkUsernameAvailability(
  //     String uname, String token) async {
  //   final response = await _client.post(
  //     Uri.parse(baseUrl! + AppUrls.checkUsernameAvailableEndpoint),
  //     headers: {
  //       "content-type": "application/json",
  //       "authorization": "Bearer $token",
  //     },
  //     body: jsonEncode({'uname': uname}),
  //   );
  //
  //   return response;
  // }
  //
  // Future<http.Response> updateUsername(String uname, String token) async {
  //   final response = await _client.post(
  //     Uri.parse(baseUrl! + AppUrls.updateUsernameEndpoint),
  //     headers: {
  //       "content-type": "application/json",
  //       "authorization": "Bearer $token",
  //     },
  //     body: jsonEncode({'uname': uname}),
  //   );
  //
  //   return response;
  // }

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

  Future<http.Response> getLatestReleaseInfo() async {
    final response = await _client.get(
      Uri.parse(AppUrls.githubApiUrl + AppUrls.checkAppUpdateEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer ${AppSecrets.githubToken}",
      },
    );

    return response;
  }
}
