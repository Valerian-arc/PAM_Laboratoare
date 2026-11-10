import 'package:flutter/material.dart';

/// The Course Overview design uses Roboto (unlike the Poppins home page).
TextStyle overviewText(
  double size,
  Color color, [
  FontWeight weight = FontWeight.w400,
]) => TextStyle(
  fontFamily: 'Roboto',
  fontSize: size,
  color: color,
  fontWeight: weight,
  letterSpacing: 0,
  height: 1.17,
);
