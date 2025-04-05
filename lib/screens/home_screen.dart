// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/donation_post_card.dart';
import '../../models/donation_post.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, you would fetch posts from your backend
    final posts = [
      DonationPost(
        id: '1',
        title: 'Food Supplies',
        description: 'We have 50 boxes of canned food to donate',
        imageUrl:
            'https://foodbunker.co.uk/cdn/shop/files/Bumper_LongLife_Pack_alt_1024x1024.jpg?v=1650581593',
        location: 'Istanbul, Turkey',
        contactName: 'Ahmet Yılmaz',
        contactPhone: '+905551234567',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      DonationPost(
        id: '2',
        title: 'Blankets and Clothes',
        description: 'Warm blankets and winter clothes for affected families',
        imageUrl:
            'https://www.thespruce.com/thmb/JKsh1z0BpIsATPe0JyRzUN95B2E=/2121x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-1310931045-135bf1f7fa3949a9a2dd04615349bc54.jpg',
        location: 'Izmir, Turkey',
        contactName: 'Ayşe Demir',
        contactPhone: '+905553456789',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquake Relief Donations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/create-post'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return DonationPostCard(post: posts[index]);
        },
      ),
    );
  }
}
