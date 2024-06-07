import 'package:flutter/material.dart';
import 'Post.Detail.dart'; // Import the PostDetailPage

class WroteBoardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> posts;

  WroteBoardScreen({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내가 쓴 글'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              child: ListTile(
                title: Text(
                  post['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.thumb_up, size: 18),
                    SizedBox(width: 4),
                    Text(post['likes'].toString()),
                    SizedBox(width: 16),
                    Icon(Icons.comment, size: 18),
                    SizedBox(width: 4),
                    Text(post['comments'].length.toString()),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetail(post: post),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
