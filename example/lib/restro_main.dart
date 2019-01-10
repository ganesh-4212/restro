import 'package:example/second_api.dart';
import 'package:restro/restro.dart';
import './web_api.dart';

part 'restro_main.g.dart';

@RestroSetup(const [
  GitHubService,
  SecondApi,
])
Restro restro = _$restro;
