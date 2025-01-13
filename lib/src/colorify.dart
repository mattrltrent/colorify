import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';

/// Two modes: full color range, or only bright colors.
enum ColorType {
  /// Use the full color range from the hash:
  /// can be black, white, grey, neon, or anything in between.
  all,

  /// Only bright, vibrant colors: no black-ish, white-ish, or dull/grey-ish.
  brights,
}

/// Generates a deterministic color from [seed].
///
/// - [ColorType.all] = No restrictions (full color range).
/// - [ColorType.brights] = Clamps lightness & saturation to produce bright colors.
Color colorify(
  dynamic seed, {
  ColorType colorType = ColorType.all,
}) {
  // Convert the seed to a string
  final seedString = seed.toString();

  // Hash the string using MD5 -> 16 bytes
  final hash = crypto.md5.convert(utf8.encode(seedString)).bytes;

  // Scale the first 3 bytes of the hash to the range 0-255
  final r = (hash[0] / 255 * 255).round();
  final g = (hash[1] / 255 * 255).round();
  final b = (hash[2] / 255 * 255).round();

  // Create the base ARGB color from the hash
  final baseColor = Color.fromARGB(255, r, g, b);

  // If we want the full color range, just return directly
  if (colorType == ColorType.all) {
    return baseColor;
  }

  // Otherwise, convert to HSL to clamp lightness/saturation for bright colors
  final hsl = HSLColor.fromColor(baseColor);
  double hue = hsl.hue; // [0..360]
  double saturation = hsl.saturation; // [0..1]
  double lightness = hsl.lightness; // [0..1]

  // For "Brights":
  // - Keep away from too-dark or too-light => clamp lightness
  // - Keep saturation high => avoid grey/brown
  //
  // Adjust these values to taste:
  const double minLightness = 0.5;
  const double maxLightness = 0.7;
  const double minSaturation = 0.8;

  // Helper to clamp a value between [low, high]
  double clamp(double value, double low, double high) {
    if (value < low) return low;
    if (value > high) return high;
    return value;
  }

  // Clamp to the "bright" range
  saturation = clamp(saturation, minSaturation, 1.0);
  lightness = clamp(lightness, minLightness, maxLightness);

  // Build the new HSL color with adjusted values
  final adjustedHSL = HSLColor.fromAHSL(
    1.0, // alpha (fully opaque)
    hue,
    saturation,
    lightness,
  );

  // Convert back to ARGB
  return adjustedHSL.toColor();
}
