import 'package:restro/restro.dart';

part 'second_api.g.dart';

@WebApi()
abstract class SecondApi{
  @GET()
  Future<String> getAll();
}