enum DataSource {
  success,
  noContent,
  babRequest,
  forBiden,
  unauthorised,
  notFound,
  internalSeverError,
  connectTimeout,
  cancel,
  recieveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultResponse,
}

class ResponseCode {
  static const int success = 200;
  static const int created = 201;
  static const int babRequest = 400;
  static const int forBiden = 403;
  static const int unauthorised = 401;
  static const int notFound = 404;
  static const int internalSeverError = 500;
  static const int parcelExist = 4001;

// local status code
  static const int defaultResponse = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int recieveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  static const String success = "Succès";
  static const String noContent = "Succès Sans Contenu";
  static const String babRequest =
      "Mauvaise Requête, Veuillez Réessayer Plus Tard";
  static const String forBiden =
      "Requête Interdite, Veuillez Réessayer Plus Tard";
  static const String unauthorised =
      "Utilisateur Non Autorisé, Veuillez Réessayer Plus Tard";
  static const String notFound =
      "URL Introuvable, Veuillez Réessayer Plus Tard";
  static const String internalSeverError =
      "Oups, Une Erreur S'est Produite, Veuillez Réessayer";

// local status code
  static const String defaultResponse =
      "Oups, Une Erreur S'est Produite, Veuillez Réessayer";
  static const String connectTimeout = "Réseau Instable";
  static const String cancel = "Requête Annulée, Veuillez Réessayer Plus Tard";
  static const String recieveTimeout =
      "Délai D'attente Dépassé, Veuillez Réessayer Plus Tard";
  static const String sendTimeout =
      "Délai D'envoi Dépassé, Veuillez Réessayer Plus Tard";
  static const String cacheError =
      "Erreur De Cache, Veuillez Réessayer Plus Tard";
  static const String noInternetConnection =
      "Veuillez Vérifier Votre Connexion";
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
