import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siri_prototype/api/api_service.dart';
import 'package:siri_prototype/models/response/course_response.dart';

class HorizontalImageSlider extends StatefulWidget {
  const HorizontalImageSlider({super.key});

  @override
  _HorizontalImageSliderState createState() => _HorizontalImageSliderState();
}

class _HorizontalImageSliderState extends State<HorizontalImageSlider> {
  // final List<String> imageList = [
  //   'https://s3.ap-northeast-2.amazonaws.com/com.liveschole/common/1675813400118.png',
  //   'https://s3.ap-northeast-2.amazonaws.com/com.liveschole/common/1675813405511.png',
  //   'https://s3.ap-northeast-2.amazonaws.com/com.liveschole/common/1675813383738.png',
  // ];
  static const String format = "yyyy-MM-dd'T'HH:mm:ss.SSSZZ";

  Future<List<CourseModel>> courses = ApiService.getCourses();

  int _currentPage = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: _currentPage,
      keepPage: false,
      viewportFraction: 0.8,
    );
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
            future: courses,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: 155,
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ClipRect(
                            child: Container(
                              width: 275,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      // TODO: image data 처리!
                                      'https://s3.ap-northeast-2.amazonaws.com/com.liveschole/course/1676439475609.png.medium'
                                      // snapshot.data![index].imageUrl,
                                      ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    snapshot.data![index].title,
                                    softWrap: true,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '완독 ${snapshot.data![index].price}분 소요',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('yyyy.MM.dd hh:mm').format(
                                            DateFormat(format).parse(snapshot
                                                .data![index].createdAt)),
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) => GestureDetector(
                          onTap: () {
                            _controller.animateToPage(index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 2.5, vertical: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? const Color(0XFFAAADB0)
                                  : const Color(0XFFD4D7DA),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              return const CircularProgressIndicator();
            }),
      ],
    );
  }
}
