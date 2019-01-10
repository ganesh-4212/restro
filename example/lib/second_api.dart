import 'package:restro/restro.dart';

part 'second_api.g.dart';

@WebApi()
abstract class SecondApi extends BaseService{
  factory SecondApi() => _$SecondApiImpl();
  @GET()
  Future<String> getAll();
}