// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_api.dart';

// **************************************************************************
// WebApiGenerator
// **************************************************************************

class _$GitHubServiceImpl extends GitHubService {
  @override
  Future<String> getUserName(String id) {
    RestroConfig config = RestroConfig();
    config.method = RequestMethod.GET;
    config.url = "/user-by-name";
    config.headers["access-token"] = "10";
    config.headers["contentType"] = "application/json";
  }

  @override
  Future<String> getDeletedUsers() {
    RestroConfig config = RestroConfig();
    config.method = RequestMethod.GET;
    config.url = "";
  }
}
