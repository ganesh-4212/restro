import 'package:restro/restro.dart';

part 'web_api.g.dart';

@WebApi(url: '/secure/users/:userId')
class GitHubService {

  factory GitHubService() => _$GitHubServiceImpl();

  @Headers(
    {'access-token': '10', 'contentType': 'application/json'},
  )
  @GET('/user-by-name/:id/repository/:repoIds')
  Future<String> getUserName(
      @Path() String repoIds, @Path() String id, @Path() String userId);

  Future<String> getDeletedUserss(@Path() String userId, @Query('firstQuerys') String secondArg,String queryArg);
}
