import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class PictureModel {
  String? name;
  num? id;
  int? idx;
  bool flipOnTouch;
  Color? color;
  FlipCardController? flipCardController;

  PictureModel({this.name, this.id, this.idx, this.flipOnTouch = true, this.color, this.flipCardController});

  PictureModel copyWith({
    String? name,
    num? id,
    int? idx,
    bool? flipOnTouch,
    Color? color,
    FlipCardController? flipCardController,
  }) {
    return PictureModel(
      name: name ?? this.name,
      id: id ?? this.id,
      flipOnTouch: flipOnTouch ?? this.flipOnTouch,
      idx: idx ?? this.idx,
      color: color ?? this.color,
      flipCardController: flipCardController ?? this.flipCardController,
    );
  }
}
