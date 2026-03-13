import 'package:flutter/material.dart';

class KTextStyle {
  static const titleTealText = TextStyle(
    fontSize: 18.0,
    color: Colors.teal,
    fontWeight: FontWeight.bold,
  );
  static const descText = TextStyle(fontSize: 16.0);
}

class CardData {
  final String title;
  final String desc;

  const CardData({required this.title, required this.desc});
}

const List<CardData> KCardData = [
  CardData(title: "Apa itu Tutur.id", desc: "Desc 1"),
  CardData(title: "Mengapa Tutur.id?", desc: "Desc 2"),
  CardData(title: "Apa Kata Mereka?", desc: "Desc 3"),
  CardData(title: "Perlu Bantuan Lebih Lanjut?", desc: "Desc 4"),
];
