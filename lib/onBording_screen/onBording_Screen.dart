import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/componanets.dart';
import 'package:shop/moudules/login_screen/login_screen.dart';
import 'package:shop/network/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BordingModel {
  String? image;
  String? title;
  String? body;

  BordingModel({required this.image, required this.title, required this.body});
}

class OnBoarding_Screen extends StatefulWidget {
  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {
  var boardController = PageController();

  List<BordingModel> bording = [
    BordingModel(
        image: 'assets/images/onBording.png',
        title: 'Screen Title 1',
        body: 'Screen Body 1'),
    BordingModel(
        image: 'assets/images/onBording2.png',
        title: 'Screen Title 2',
        body: 'Screen Body 2'),
    BordingModel(
        image: 'assets/images/onBording3.png',
        title: 'Screen Title 3',
        body: 'Screen Body 3'),
  ];
  bool isLast = false;
  void submit() {
    CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateToAndErase(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('6c63ff'),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
                'SKIP',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JoseifSans',
                    color: Colors.black87),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == bording.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('last');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('Not Last');
                  }
                },
                itemBuilder: (context, index) =>
                    buildBordingItem(bording[index]),
                itemCount: bording.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: bording.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: HexColor('6c63ff'),
                    dotHeight: 15,
                    expansionFactor: 3,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: HexColor('6c63ff'),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(microseconds: 600),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBordingItem(BordingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(height: 20),
          Text(
            '${model.title}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'lobster'),
          ),
          SizedBox(height: 40),
          Text('${model.body}',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'JoseifSans')),
        ],
      );
}
