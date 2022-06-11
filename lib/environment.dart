enum AppEnvironment { dev, prd }

extension EnvExetension on AppEnvironment? {
  static const apiUrls = {
    AppEnvironment.dev: "localhost:3333",
    AppEnvironment.prd: "yes.com.tm",
  };

  String? get apiUrl => apiUrls[this!];
}
