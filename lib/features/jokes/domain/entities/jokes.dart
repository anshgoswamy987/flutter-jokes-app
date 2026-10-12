// TODO Implement this library.
class Joke {
  final int id;
  final String category;
  final String setup;
  final String? delivery;

  const Joke({
    required this.id,
    required this.category,
    required this.setup,
    this.delivery,
  });

  bool get isTwoPart => delivery != null;
}
