abstract class BaseConfig {
  String get apiHost;
  String get algoliaAppId;
  String get algoliaSearchOnlyApiKey;
  bool get useHttps;
  bool get trackEvents;
  bool get reportErrors;
}

class StagingConfig implements BaseConfig {
  @override
  String get apiHost =>
      "https://sweeftly-backend-api-stagging.herokuapp.com/api/v1/";

  @override
  String get algoliaAppId => "5CI8KODE0S";

  @override
  String get algoliaSearchOnlyApiKey => "3519e84961694684832a0e85d9ae9836";

  @override
  bool get reportErrors => true;

  @override
  bool get trackEvents => false;

  @override
  bool get useHttps => true;
}


class ProdConfig implements BaseConfig {
  @override
  String get apiHost =>
      "https://sweeftly-backend-api-production.herokuapp.com/api/v1/";

  @override
  String get algoliaAppId => "ZXMI3EWOQ6";

  @override
  String get algoliaSearchOnlyApiKey => "221aa46d6e041336a926623633aadbc0";

  @override
  bool get reportErrors => true;

  @override
  bool get trackEvents => true;

  @override
  bool get useHttps => true;
}


class DevConfig implements BaseConfig {
  @override
  String get apiHost => "localhost";

  @override
  bool get reportErrors => false;

  @override
  bool get trackEvents => false;

  @override
  bool get useHttps => false;

  @override
  // TODO: implement algoliaAppId
  String get algoliaAppId => throw UnimplementedError();

  @override
  // TODO: implement algoliaSearchOnlyApiKey
  String get algoliaSearchOnlyApiKey => throw UnimplementedError();
}


class Environment {
  factory Environment() {
    return _singleton;
  }
  BaseConfig? config;

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      case Environment.STAGING:
        return StagingConfig();
      default:
        return DevConfig();
    }
  }
}
