class News {
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String sourceUrl;

  // Constructor
  News({
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.sourceUrl,
  });

  // Factory constructor to create a News object from JSON with null checks
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'No title available',
      description: json['description'] ?? "No description available",
      content: json['content'] ?? 'No content available',
      imageUrl: json['urlToImage'] ?? '', // Empty string if no image URL
      sourceUrl: json['url'] ?? '', // Empty string if no source URL
    );
  }

  // Method to convert a News object to JSON
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'content': content,
        'image_url': imageUrl,
        'source_url': sourceUrl,
      };
}
