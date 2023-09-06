class Quote {
  final String id;
  final String authorName;
  final String quote;
  final int isFavourite;

  const Quote({
    required this.id,
    required this.authorName,
    required this.quote,
    required this.isFavourite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorName': authorName,
      'quote': quote,
      'isFavourite': isFavourite
    };
  }

  @override
  String toString() {
    return 'Quote{id:$id,authorName:$authorName, quote:$quote, isFavourite:$isFavourite}';
  }
}
