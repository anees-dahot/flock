import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProfileWidget extends StatelessWidget {
  const ShimmerProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.3,
              color: Colors.white,
            ),
            SizedBox(height: size.height * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 24,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: size.width * 0.7,
                    height: 16,
                    color: Colors.white,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.42,
                        height: size.height * 0.055,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: size.width * 0.4,
                        height: size.height * 0.055,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 24,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: size.width * 0.9,
                    height: size.height * 0.3,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 24,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  // Shimmer effect for posts
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        width: size.width * 0.9,
                        height: 200,
                        color: Colors.white,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}