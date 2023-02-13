import 'dart:math';
import 'package:flutter/material.dart';
import 'package:higherorlower/cardConverter.dart';

void main() => runApp(HigherLowerGame());

class HigherLowerGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Higher or Lower',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Higher or Lower'),
        ),
        body: HigherLowerGameBody(),
      ),
    );
  }
}

class HigherLowerGameBody extends StatefulWidget {
  @override
  _HigherLowerGameBodyState createState() => _HigherLowerGameBodyState();
}

class _HigherLowerGameBodyState extends State<HigherLowerGameBody> {
  final _random = Random();
  final List<String> _cardPool = [
    'AH',
    'AD',
    'AS',
    'AC',
    '2H',
    '2D',
    '2S',
    '2C',
    '3H',
    '3D',
    '3S',
    '3C',
    '4H',
    '4D',
    '4S',
    '4C',
    '5H',
    '5D',
    '5S',
    '5C',
    '6H',
    '6D',
    '6S',
    '6C',
    '7H',
    '7D',
    '7S',
    '7C',
    '8H',
    '8D',
    '8S',
    '8C',
    '9H',
    '9D',
    '9S',
    '9C',
    '10H',
    '10D',
    '10S',
    '10C',
    'JH',
    'JD',
    'JS',
    'JC',
    'QH',
    'QD',
    'QS',
    'QC',
    'KH',
    'KD',
    'KS',
    'KC',
  ];

  late String _currentCard;
  late String _prevCard = 'AD';
  late int _currentCardValue;
  int _score = 0;
  int _prevCardValue = 0;

  @override
  void initState() {
    super.initState();
    _generateNewCard();
  }

  void _generateNewCard() {
    if (_cardPool.length > 0) {
      int index = _random.nextInt(_cardPool.length);
      setState(() {
        _currentCard = _cardPool[index];
        _cardPool.removeAt(index);
        _currentCardValue = _getCardValue(_currentCard[0]);
      });
    }
  }

  int _getCardValue(String cardValue) {
    switch (cardValue) {
      case 'A':
        return 1;
      case 'J':
        return 11;
      case 'Q':
        return 12;
      case 'K':
        return 13;
      default:
        return int.parse(cardValue);
    }
  }

  void _onHigherButtonPressed() {

    print(_prevCardValue);
    print(_currentCardValue);
    setState(() {
      _prevCardValue = _currentCardValue;
      _prevCard = _currentCard;
      _generateNewCard();
      if (_getCardValue(_currentCard[0]) > _prevCardValue) {
        _score++;
      } else {
        _score--;
      }
    });
  }

  void _onLowerButtonPressed() {
    setState(() {
      _prevCardValue = _currentCardValue;
      _generateNewCard();
      if (_getCardValue(_currentCard[0]) < _prevCardValue) {
        _score++;
      } else {
        _score--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              child: CardConverter(card: _prevCard, scale: 1, shadow: 1),
            ),
            Container(
              child: CardConverter(card: _currentCard, scale: 1, shadow: 1),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Score: $_score',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text('Higher'),
          onPressed: _onHigherButtonPressed,
        ),
        SizedBox(height: 8),
        ElevatedButton(
          child: Text('Lower'),
          onPressed: _onLowerButtonPressed,
        ),
      ],
    );
  }
}
