import 'package:restro/restro.dart';

part 'web_api.g.dart';

@WebApi(url: '/secure/users')
abstract class GitHubService {
  @Headers(
    {'access-token': '10', 'contentType': 'application/json'},
  )
  @GET('/user-by-name')
  Future<String> getUserName(String id);

  Future<String> getDeletedUsers();
}
