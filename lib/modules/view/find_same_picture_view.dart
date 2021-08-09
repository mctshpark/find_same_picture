import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:find_same_picture/modules/view/find_same_picture_ctr.dart';
import 'package:find_same_picture/modules/widgets/c_button.dart';
import 'package:find_same_picture/modules/widgets/c_text.dart';
import 'package:find_same_picture/modules/widgets/disable_multi_touch_recognizer.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindSamePictureView extends StatefulWidget {
  const FindSamePictureView({Key? key}) : super(key: key);

  @override
  _FindSamePictureViewState createState() => _FindSamePictureViewState();
}

class _FindSamePictureViewState extends State<FindSamePictureView> with TickerProviderStateMixin {
  final controller = Get.put(FindSamePictureCtr());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: GetBuilder<FindSamePictureCtr>(
        builder: (controller) {
          return AnimatedBackground(
            behaviour: controller.isClear ? SpaceBehaviour() : BubblesBehaviour(),
            vsync: this,
            child: IgnorePointer(
              ignoring: controller.ignore,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50.h, bottom: 10.h),
                        alignment: Alignment.center,
                        child: CText(
                          '같은 그림 맞추기',
                          fontSize: 25.sp,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.h, bottom: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              '클리어 횟수 : ${controller.scoreList.length}',
                              color: Colors.white,
                            ),
                            SizedBox(height: 5.h),
                            controller.scoreList.isEmpty
                                ? const CText('')
                                : CText(
                                    '최고 기록 : ${controller.scoreList.reduce(min)}',
                                    color: Colors.white,
                                  ),
                            SizedBox(height: 5.h),
                            CText(
                              '카드 뒤집기 횟수 : ${controller.tryCount}',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      RawGestureDetector(
                        gestures: <Type, GestureRecognizerFactory>{
                          DisableMultiTouchRecognizer: GestureRecognizerFactoryWithHandlers<DisableMultiTouchRecognizer>(
                            () => DisableMultiTouchRecognizer(),
                            (DisableMultiTouchRecognizer instance) {},
                          ),
                        },
                        child: GridView.builder(
                          key: Key('${controller.level}'),
                          padding: EdgeInsets.zero,
                          itemCount: controller.problemList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            controller.problemList[index] = controller.problemList[index].copyWith(idx: index);
                            return FlipCard(
                              flipOnTouch: controller.problemList[index].flipOnTouch,
                              controller: controller.problemList[index].flipCardController,
                              direction: FlipDirection.VERTICAL,
                              onFlip: () {
                                controller.flipping();
                              },
                              onFlipDone: (isFront) {
                                controller.flipped(isFront, index);
                              },
                              front: Container(
                                color: Colors.grey.withOpacity(0.5),
                                child: Center(
                                  child: CText(
                                    '❓',
                                    color: Colors.black,
                                    fontSize: 50.sp,
                                  ),
                                ),
                              ),
                              back: Container(
                                color: controller.problemList[index].color,
                                child: Center(
                                  child: CText(
                                    controller.problemList[index].name ?? '',
                                    color: Colors.black,
                                    fontSize: 50.sp,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 30.h),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: controller.isClear ? 1 : 0,
                        child: CButton(
                          onTap: () async {
                            await controller.completeReset();
                          },
                          color: Colors.red,
                          child: CText(
                            controller.level > 2 ? '다시 하기' : '다음',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
