import 'package:flutter/material.dart';
import 'package:siri_prototype/modules/main/home/tabs/feed/horizontal_image_slider.dart';
import 'package:siri_prototype/modules/main/home/tabs/feed/vertical_feed_list.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const HorizontalImageSlider(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: VerticalFeedList(),
          ),
        ],
      ),
    );
  }
}
