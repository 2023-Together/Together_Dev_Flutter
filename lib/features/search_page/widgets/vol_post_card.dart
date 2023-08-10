import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/models/DBModels/volunteer_model.dart';

class VolPostCard extends StatelessWidget {
  final VolunteerModel volData;

  const VolPostCard({
    super.key,
    required this.volData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        clipBehavior: Clip.hardEdge,
        width: constraints.maxWidth,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [],
            // ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                volData.title,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.purple.shade300,
                  // border: Border.all(
                  //   width: 1,
                  // ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: const Text(
                  "모집 중",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              "활동 장소: ${volData.actPlace} (${volData.areaName})",
              maxLines: 2,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12.0,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Gaps.v10,
            Container(
              height: 1,
              width: 400,
              color: const Color.fromARGB(255, 203, 203, 203),
            ),
            Gaps.v10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    volData.centName ?? "",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Gaps.h6,
                if (volData.teenager == "Y")
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "청소년",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.black,
                      ),
                    ),
                  )
              ],
            ),
            Gaps.v10,
          ],
        ),
      ),
    );
  }
}