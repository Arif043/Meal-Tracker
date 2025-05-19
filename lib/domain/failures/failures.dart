abstract class Failure{}

class ProductFailure extends Failure{
  @override
  String toString() => 'Produkt konnte nicht gefunden werden';
}
class ServerFailure extends Failure {
  @override
  String toString() => 'Verbindung wurder unterbrochen';
}
class GeneralFailure extends Failure{
  @override
  String toString() => 'Etwas lief schief';
}