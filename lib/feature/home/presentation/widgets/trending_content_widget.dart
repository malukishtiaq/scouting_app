import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class TrendingContentWidget extends StatelessWidget {
  const TrendingContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Trending Topics', Icons.trending_up),
            const SizedBox(height: 16),
            _buildTrendingTopics(),
            const SizedBox(height: 24),
            _buildSectionHeader('Popular Users', Icons.people),
            const SizedBox(height: 16),
            _buildPopularUsers(),
            const SizedBox(height: 24),
            _buildSectionHeader('Recent Activity', Icons.history),
            const SizedBox(height: 16),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.xamarinAccent),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingTopics() {
    final topics = [
      {'name': '#Flutter', 'posts': '1.2K posts'},
      {'name': '#MobileDev', 'posts': '856 posts'},
      {'name': '#Programming', 'posts': '2.1K posts'},
      {'name': '#TechNews', 'posts': '743 posts'},
      {'name': '#OpenSource', 'posts': '1.5K posts'},
    ];

    return Column(
      children: topics.map((topic) => _buildTopicItem(topic)).toList(),
    );
  }

  Widget _buildTopicItem(Map<String, String> topic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            topic['name']!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            topic['posts']!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularUsers() {
    final users = [
      {'name': 'John Doe', 'followers': '12K followers', 'verified': true},
      {'name': 'Jane Smith', 'followers': '8.5K followers', 'verified': false},
      {'name': 'Tech Guru', 'followers': '25K followers', 'verified': true},
      {'name': 'Flutter Dev', 'followers': '15K followers', 'verified': true},
    ];

    return Column(
      children: users.map((user) => _buildUserItem(user)).toList(),
    );
  }

  Widget _buildUserItem(Map<String, dynamic> user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.xamarinAccent,
            child: Text(
              user['name'].toString().substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (user['verified'])
                      const SizedBox(width: 4),
                    if (user['verified'])
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 16,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  user['followers'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle follow action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.xamarinAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Follow'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    final activities = [
      {'action': 'John liked your post', 'time': '2 hours ago'},
      {'action': 'Jane commented on your photo', 'time': '4 hours ago'},
      {'action': 'Tech Guru shared your story', 'time': '6 hours ago'},
      {'action': 'Flutter Dev followed you', 'time': '1 day ago'},
    ];

    return Column(
      children: activities.map((activity) => _buildActivityItem(activity)).toList(),
    );
  }

  Widget _buildActivityItem(Map<String, String> activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.xamarinAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['action']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['time']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
