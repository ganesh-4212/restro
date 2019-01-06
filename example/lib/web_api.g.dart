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
  }

  @override
  Future<String> getDeletedUsers() {
    RestroConfig config = RestroConfig();
    config.method = RequestMethod.POST;
    config.url = "/user-deleted";
  }
}
