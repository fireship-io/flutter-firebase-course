abstract class Failure implements Exception {
  const Failure();

  bool get needsReauthentication => false;
}
