import 'package:flutter/material.dart';
import 'package:swag_cross_app/features/club/club_post_detail_page.dart';

class PostCard extends StatelessWidget {
  int id;
  String clubName;
  String title;
  String? clubBanner;
  int viewCount = 0;
  int commentCount = 0;

  PostCard({
    super.key,
    required this.id,
    required this.clubName,
    required this.clubBanner,
    required this.title,
    required this.viewCount,
    required this.commentCount,
  });

  void tabHandler(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClubPostDetailPage(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tabHandler(context, id),
      child: Container(
        color: Colors.white,
        height: 160,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _clubInfo(clubName: clubName),
                            const SizedBox(height: 8),
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _postInfo(
                                  icon: Icons.remove_red_eye,
                                  count: viewCount,
                                ),
                                _postInfo(
                                  icon: Icons.messenger,
                                  count: commentCount,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      clubBanner ?? "assets/images/dog.jpg",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _clubInfo({required String clubName, Image? clubBanner}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xFFf2f2f2),
          child: clubBanner ?? Container(),
        ),
        const SizedBox(width: 10),
        Text(
          clubName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Row _postInfo({required IconData icon, required int count}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28,
          color: const Color(0xFFa6a6a6),
        ),
        Text(
          "$count",
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFa6a6a6),
          ),
        ),
      ],
    );
  }
}
