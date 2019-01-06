import 'package:restro/restro.dart';

part 'web_api.g.dart';

@WebApi(url: '/secure/users')
abstract class GitHubService{
  String headers;
  String users;
  @GET('/user-by-name')
  Future<String> getUserName(String id);

  @POST('/user-deleted')
  Future<String> getDeletedUsers();
}