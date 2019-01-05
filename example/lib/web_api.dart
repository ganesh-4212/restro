import 'package:restro/restro.dart';
part 'web_api.g.dart';

@WebApi(url: '/secure/users')
abstract class GitHubService{
  String headers;
  String users;
  @GET(url: '/user-by-name')
  Future<String> getUserName(String id);

  @GET(url: '/user-deleted')
  Future<String> getDeletedUsers();
}
