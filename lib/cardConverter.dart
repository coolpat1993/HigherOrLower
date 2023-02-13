import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardConverter extends StatelessWidget {
  final String card;
  final double scale;
  final int shadow;

  List<List<List<int>>> cardArray = [
    [
      [0],
      [1],
      [0],
    ],
    [
      [0],
      [1, 1],
      [0],
    ],
    [
      [0, 0, 1],
      [0, 1, 0],
      [1, 0, 0],
    ],
    [
      [1, 0, 1],
      [0, 0, 0],
      [1, 0, 1],
    ],
    [
      [1, 0, 1],
      [0, 1, 0],
      [1, 0, 1],
    ],
    [
      [1, 1, 1],
      [0, 0, 0],
      [1, 1, 1],
    ],
    [
      [1, 1, 1],
      [0, 1, 0, 0],
      [1, 1, 1],
    ],
    [
      [1, 1, 1, 1],
      [0, 0, 0],
      [1, 1, 1, 1],
    ],
    [
      [1, 1, 1, 1],
      [0, 1, 0],
      [1, 1, 1, 1],
    ],
    [
      [1, 1, 1, 1],
      [1, 1],
      [1, 1, 1, 1],
    ]
  ];
  final Map<String, Map<String, dynamic>> _suits = {
    'C': {'color': Colors.black, 'icon': 'assets/icons/025-clubs.svg'},
    'D': {'color': Colors.red, 'icon': 'assets/icons/026-diamonds.svg'},
    'H': {'color': Colors.red, 'icon': 'assets/icons/219-heart.svg'},
    'S': {'color': Colors.black, 'icon': 'assets/icons/024-spades.svg'},
  };

  CardConverter(
      {required this.card, required this.scale, required this.shadow});

  @override
  Widget build(BuildContext context) {
    String number = card[0];
    String suit = card[1];
    if (card.length > 2) {
      number = '10';
      suit = card[2];
    }
    ;

    double centerIconScale = 41 * scale;
    final Map<String, dynamic>? _suit = _suits[suit];
    final suitColor = _suit!['color'];
    final suitIcon = SvgPicture.asset(_suit['icon'],
        height: centerIconScale, color: suitColor);

    SvgPicture createSvg(String filePath, Color color, [double? height]) {
      return SvgPicture.asset(filePath, color: color, height: height);
    }

    Map<String, SvgPicture> svgs = {
      'K': createSvg('assets/icons/King.svg', suitColor, 250 * scale),
      'Q': createSvg('assets/icons/Queen.svg', suitColor, 230 * scale),
      'J': createSvg('assets/icons/Jack.svg', suitColor, 230 * scale),
      'A': createSvg(
          suit == 'C'
              ? 'assets/icons/Clubs.svg'
              : suit == 'S'
                  ? 'assets/icons/Spades.svg'
                  : suit == 'H'
                      ? 'assets/icons/Heart.svg'
                      : 'assets/icons/Diamonds.svg',
          suitColor,
          230 * scale)
    };

    Widget buildIcon(visible) {
      return Center(
        child: visible == 0 ? null : suitIcon,
      );
    }

    bool cardTest = false;

    return Container(
      padding: EdgeInsets.all(10),
      width: 250 * scale,
      height: 350 * scale,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0 * scale, color: Colors.black),
        borderRadius: BorderRadius.circular(10 * scale),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(shadow, 0, 0, 0),
            offset: Offset(9.0 * scale, 13.5 * scale),
            blurRadius: 8.5 * scale,
          ),
        ],
      ),
      child: number == 'B'
          ? Container(
              child: SvgPicture.asset('assets/icons/sqPlayingCardThinLines.svg',
                  color: Color.fromARGB(255, 107, 164, 211)))
          : Stack(
              children: [
                SvgPicture.asset('assets/icons/SQlogo.svg',
                    color: isNumeric(number)
                        ? suitColor.withOpacity(0.1)
                        : suitColor.withOpacity(0.0)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        number,
                        style: TextStyle(
                          fontSize: 30.0 * scale,
                          color: suitColor,
                        ),
                      ),
                      Container(
                        child: suitIcon,
                        width: 30 * scale,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(17.0 * scale),
                    child: isNumeric(number)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  for (int j = 0;
                                      j <
                                          cardArray[int.parse(number) - 1][0]
                                              .length;
                                      j++)
                                    Expanded(
                                        child: buildIcon(
                                            cardArray[int.parse(number) - 1][0]
                                                [j])),
                                ],
                              ),
                              Column(
                                children: [
                                  for (int j = 0;
                                      j <
                                          cardArray[int.parse(number) - 1][1]
                                              .length;
                                      j++)
                                    Expanded(
                                        child: buildIcon(
                                            cardArray[int.parse(number) - 1][1]
                                                [j])),
                                ],
                              ),
                              Column(
                                children: [
                                  for (int j = 0;
                                      j <
                                          cardArray[int.parse(number) - 1][2]
                                              .length;
                                      j++)
                                    Expanded(
                                        child: buildIcon(
                                            cardArray[int.parse(number) - 1][2]
                                                [j])),
                                ],
                              )
                            ],
                          )
                        : Align(
                            alignment: Alignment.center, child: svgs[number])),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Transform.rotate(
                    angle: 3.14,
                    child: Column(
                      children: [
                        Text(
                          number,
                          style: TextStyle(
                            fontSize: 30.0 * scale,
                            color: suitColor,
                          ),
                        ),
                        Transform(
                          transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 30 * scale,
                            child: suitIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
