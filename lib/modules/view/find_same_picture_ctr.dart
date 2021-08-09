import 'package:find_same_picture/data/local/picture_model.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const List<int> levelList = [4, 8, 12, 16];

class FindSamePictureCtr extends GetxController {
  final List<PictureModel> originList = [
    PictureModel(id: 1, name: '🦭', color: Colors.cyan, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 2, name: '🐱', color: Colors.blue, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 3, name: '🐭', color: Colors.greenAccent, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 4, name: '🐹', color: Colors.brown, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 5, name: '🐰', color: Colors.amber, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 6, name: '🦊', color: Colors.pinkAccent, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 7, name: '🐻', color: Colors.deepPurpleAccent, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 8, name: '🐼', color: Colors.lightGreen, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 9, name: '🙈', color: Colors.black, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 10, name: '🦍', color: Colors.white, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 11, name: '🐈', color: Colors.grey, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 12, name: '🦁', color: Colors.lightGreen, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 13, name: '🐯', color: Colors.purple, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 14, name: '🐶', color: Colors.red, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 15, name: '🐲', color: Colors.teal, flipOnTouch: true, flipCardController: FlipCardController()),
    PictureModel(id: 16, name: '🦈', color: Colors.limeAccent, flipOnTouch: true, flipCardController: FlipCardController()),
  ];

  List<PictureModel> problemList = [];
  List<int> scoreList = [];
  PictureModel? currentCard;
  PictureModel? oldCard;

  int? indexCheck;
  int tryCount = 0;
  int level = 0;
  bool isClear = false;
  bool ignore = false;

  @override
  void onInit() {
    problemList.clear();
    for (int i = 0; i < levelList[level]; i++) {
      problemList.add(originList[i].copyWith(flipCardController: FlipCardController()));
      problemList.add(originList[i].copyWith(flipCardController: FlipCardController()));
    }
    problemList.shuffle();
    super.onInit();
  }

  flipping() {
    ignore = true;
    update();
  }

  void flipped(bool isFront, int index) {
    if (isFront) {
      currentCard = null;
      oldCard = null;
      indexCheck = null;
      ignore = false;
    } else {
      tryCount = tryCount + 1;
      if (indexCheck == null) {
        indexCheck = index;
        currentCard = problemList[index];
      } else if (indexCheck != index) {
        indexCheck = index;
        oldCard = currentCard;
        currentCard = problemList[index];
        if (oldCard?.id == currentCard?.id) {
          problemList[currentCard!.idx!] = problemList[currentCard!.idx!].copyWith(flipOnTouch: false);
          problemList[oldCard!.idx!] = problemList[oldCard!.idx!].copyWith(flipOnTouch: false);
          currentCard = null;
          oldCard = null;
          indexCheck = null;
        } else {
          if (currentCard?.idx != null) {
            problemList[currentCard!.idx!].flipCardController?.toggleCard();
            currentCard = null;
          }
          if (oldCard?.idx != null) {
            problemList[oldCard!.idx!].flipCardController?.toggleCard();
            oldCard = null;
          }
          indexCheck = null;
        }
      } else {
        currentCard = null;
      }
      ignore = false;

      if (problemList.where((element) => element.flipOnTouch == false).length == problemList.length) {
        isClear = true;
      }
    }
    update();
  }

  Future<void> completeReset() async {
    for (int i = 0; i < problemList.length; i++) {
      if (problemList[i].flipCardController?.state?.isFront == false) {
        problemList[i].flipCardController?.toggleCard();
      }
    }
    problemList.clear();
    if (level >= 3) {
      level = 0;
    } else {
      level++;
    }

    for (int i = 0; i < levelList[level]; i++) {
      problemList.add(originList[i].copyWith(flipCardController: FlipCardController()));
      problemList.add(originList[i].copyWith(flipCardController: FlipCardController()));
    }

    problemList.shuffle();
    scoreList.add(tryCount);
    currentCard = null;
    oldCard = null;
    indexCheck = null;
    isClear = false;
    tryCount = 0;
    ignore = false;
    update();
  }
}
