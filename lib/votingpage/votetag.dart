import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VoteTag extends StatelessWidget {
  const VoteTag({Key? key, required this.imageAsset, required this.rankNum})
      : super(key: key);

  final String imageAsset;
  final String rankNum;

  @override
  Widget build(BuildContext context) {
    Widget _voteTag(String imageAseet, String rankNum) {
      return Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(imageAseet),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(rankNum),
          ],
        ),
      );
    }

    return _voteTag(imageAsset, rankNum);
  }
}
