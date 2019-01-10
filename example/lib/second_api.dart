import 'package:restro/restro.dart';

@WebApi()
abstract class SecondApi{
  @GET()
  Future<String> getAll();
}