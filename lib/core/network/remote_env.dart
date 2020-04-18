const String PROTOCOL_HTTP = 'http';
const String PROTOCOL_HTTPS = 'https';

class RemoteEnv {
  final String envName;
  final String protocol;
  final String domain;
  final String port;
  final String secret;

  const RemoteEnv(
    this.envName,
    this.protocol,
    this.domain,
    this.port,
    this.secret,
  );

  static RemoteEnv _singleton;

  static RemoteEnv setInstance(RemoteEnv env) {
    return _singleton = env;
  }

  /// Only access this function after set an instance
  /// call RemoteEnv.set(...) on main function
  static RemoteEnv get() {
    // ArgumentError.checkNotNull(_singleton, 'RemoteEnv');
    if (_singleton == null) {
      _singleton = PRODUCTION;
    }
    return _singleton;
  }

  static const RemoteEnv PRODUCTION = const RemoteEnv(
    "production",
    PROTOCOL_HTTPS,
    "api.miloo.id/dirumahaja",
    "",
    "EHqBr8d8OmtuLEoQBWx5O1E5XrDCGSMt",
  );

  static const RemoteEnv DEBUG = const RemoteEnv(
    "debug",
    PROTOCOL_HTTPS,
    "localhost",
    "3002",
    "EHqBr8d8OmtuLEoQBWx5O1E5XrDCGSMt",
  );

  static const RemoteEnv MOCK = const RemoteEnv(
    "MOCK",
    PROTOCOL_HTTPS,
    "7185f494-c7e3-4565-ba39-5c3529b66469.mock.pstmn.io",
    "",
    "EHqBr8d8OmtuLEoQBWx5O1E5XrDCGSMt",
  );
}
