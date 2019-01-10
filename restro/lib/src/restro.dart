class Restro {
  Map<Type, dynamic> _servicesMap = {};
  void registerService<T extends BaseService>(Type type, T service) {
    service.restro = this;
    _servicesMap[type] = service;
  }

  T getSevice<T extends BaseService>(Type service) {
    return _servicesMap[service];
  }
}

abstract class BaseService {
  Restro restro;
}
