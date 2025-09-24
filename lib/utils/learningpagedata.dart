import 'package:flutter/material.dart';

class LearningPageData {
  final String title;
  final String description;
  final String? imagePath;
  final List<String>? bulletPoints;

  LearningPageData({
    required this.title,
    required this.description,
    this.imagePath,
    this.bulletPoints,
  });
}

final List<LearningPageData> learningPages = [
  LearningPageData(
    title: "Converting Binary to Decimal",
    description:
        "We will learn how to take a binary value and convert it into a number",
    imagePath: "assets/images/BINARY_ARROW_DECIMAL.png",
  ),
  LearningPageData(
    title: "Decimal = Numbers",
    description:
        "This number is part of the decimal system so we call it a Binary to Decimal conversion",
    imagePath: "assets/images/BINARY_ARROW_RED_DECIMAL.png",
  ),
  LearningPageData(
    title: "Binary to Decimal can be any length",
    description:
        "A binary number can be a single digit or one million digits and still be converted into a decimal",
    imagePath: "assets/images/ 1 = 1 and 101110111111011101001011 = 12318539",
  ),
];
