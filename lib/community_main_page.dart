import 'package:flutter/material.dart';
import 'board_data.dart';
import 'components.dart';
import 'write_post.dart';
import 'freeboard.dart';
import 'goalshareboard.dart';
import 'sdtipboard.dart';
import 'mentoringboard.dart';
import 'promotionboard.dart';
import 'hotboard.dart';
import 'wrote.dart';

final Map<String, List<Map<String, dynamic>>> boardPosts = {
  '자유 게시판': [],
  '목표 공유 게시판': [],
  '자기계발 팁 게시판': [],
  '멘토링 요청 게시판': [],
  '홍보 게시판': [],
  '내가 쓴 글': [],
};

class CommunityMainPage extends StatefulWidget {
  @override
  _CommunityMainPageState createState() => _CommunityMainPageState();
}

class _CommunityMainPageState extends State<CommunityMainPage> {
  bool isHotSelected = false;
  bool isMyPostsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로 가기 버튼 동작 추가
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isHotSelected = true;
                        isMyPostsSelected = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotBoardPage(posts: getHotPosts()),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isHotSelected ? Colors.brown.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.whatshot, size: 40, color: Colors.brown),
                          SizedBox(height: 30),
                          Text('HOT 게시판', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isHotSelected = false;
                        isMyPostsSelected = true;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WrotePage(posts: boardPosts['내가 쓴 글']!),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isMyPostsSelected ? Colors.brown.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.notes, size: 40, color: Colors.black),
                          SizedBox(height: 30),
                          Text('내가 쓴 글', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  buildListTile(context, '자유 게시판', FreeBoardPage(posts: boardPosts['자유 게시판']!)),
                  buildListTile(context, '목표 공유 게시판', GoalShareBoardPage(posts: boardPosts['목표 공유 게시판']!)),
                  buildListTile(context, '자기계발 팁 게시판', SdTipBoardPage(posts: boardPosts['자기계발 팁 게시판']!)),
                  buildListTile(context, '멘토링 요청 게시판', MentoringBoardPage(posts: boardPosts['멘토링 요청 게시판']!)),
                  buildListTile(context, '홍보 게시판', PromotionBoardPage(posts: boardPosts['홍보 게시판']!)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WritePostPage()),
          );
          if (result != null && result['board'] != null) {
            setState(() {
              boardPosts[result['board']]!.add({
                'title': result['title'],
                'content': result['content'],
                'likes': 0,
                'comments': [], // 댓글 리스트 초기화
              });
              // '내가 쓴 글'에 추가
              boardPosts['내가 쓴 글']!.add({
                'title': result['title'],
                'content': result['content'],
                'likes': 0,
                'comments': [], // 댓글 리스트 초기화
              });
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Map<String, dynamic>> getHotPosts() {
    return boardPosts.values
        .expand((posts) => posts)
        .where((post) => post['likes'] >= 10)
        .toList();
  }

  ListTile buildListTile(BuildContext context, String boardName, Widget page) {
    return ListTile(
      title: Text(boardName),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}