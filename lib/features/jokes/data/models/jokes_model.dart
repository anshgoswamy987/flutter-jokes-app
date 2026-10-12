import 'package:joke_app/features/jokes/domain/entities/jokes.dart';

class JokeModel extends Joke {
  const JokeModel({
    required super.id,
    required super.category,
    required super.setup,
    super.delivery,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    final isTwoPart = json['type'] == 'twopart';

    return JokeModel(
      id: json['id'] as int,
      category: json['category'] as String,
      setup: (isTwoPart ? json['setup'] : json['joke']) as String,
      delivery: isTwoPart ? json['delivery'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'type': isTwoPart ? 'twopart' : 'single',
      if (isTwoPart) ...{
        'setup': setup,
        'delivery': delivery,
      } else ...{
        'joke': setup,
      },
    };
  }
}
