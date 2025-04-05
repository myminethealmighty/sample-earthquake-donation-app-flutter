// models/donation_post.dart
class DonationPost {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String location;
  final String contactName;
  final String contactPhone;
  final DateTime timestamp;

  DonationPost({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.contactName,
    required this.contactPhone,
    required this.timestamp,
  });
}
