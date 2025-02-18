# Colorify

An *extremely* simple Flutter package that deterministically converts arbitrary `dynamic` input into a `Color`. Published mainly for personal use to avoid reinventing the wheel in my projects.

## Usage

<img src="https://raw.githubusercontent.com/mattrltrent/random_assets/refs/heads/main/colorify_ex.gif" height="auto" width="30%"/>

### Basic Example

```dart
import 'package:colorify/colorify.dart' as c;
import 'package:flutter/material.dart';

void main() {
  final input = 'example-seed';
  final color = c.colorify(input);
  print(color); // Outputs a Color object deterministically derived from 'example-seed'.
}
```

### Customizing Color Type

You can specify the type of colors generated by using the `ColorType` enum:

- `ColorType.all`: Generates colors from the full spectrum.
- `ColorType.brights`: Generates bright and vibrant colors.

Example:

```dart
import 'package:colorify/colorify.dart' as c;
import 'package:flutter/material.dart';

void main() {
  final input = 'example-seed';

  // Generate a color from the full spectrum
  final allColors = c.colorify(input, colorType: c.ColorType.all);

  // Generate a bright color
  final brightColor = c.colorify(input, colorType: c.ColorType.brights);
}
```
