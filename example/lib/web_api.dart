import 'package:restro/restro.dart';

part 'web_api.g.dart';

@WebApi(url: '/secure/users/:userId')
abstract class GitHubService {
  @Headers(
    {'access-token': '10', 'contentType': 'application/json'},
  )
  @GET('/user-by-name/:id/repository/:repoIds')
  Future<String> getUserName(@Path() String repoIds, @Path() String id,@Path()String userId);

  Future<String> getDeletedUsers(@Path()String userId);
}
