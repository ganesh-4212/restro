// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_api.dart';

// **************************************************************************
// WebApiGenerator
// **************************************************************************

class _$GitHubServiceImpl extends GitHubService {
  @override
  Future<String> getUserName(String repoIds, String id, String userId) {
    RestroConfig config = RestroConfig();
    config.method = RequestMethod.GET;
    config.url = "/secure/users/$userId/user-by-name/$id/repository/$repoIds";
    config.headers["access-token"] = "10";
    config.headers["contentType"] = "application/json";
  }

  @override
  Future<String> getDeletedUsers(
      String userId, String secondArg, String queryArg) {
    RestroConfig config = RestroConfig();
    config.method = RequestMethod.GET;
    config.url = "/secure/users/$userId";
    config.queryParams["firstQuerys"] = secondArg;
    config.queryParams["queryArg"] = queryArg;
  }
}
