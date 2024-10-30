import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TweenSequenceDemo(),
    );
  }
}

class TweenSequenceDemo extends StatefulWidget {
  @override
  _TweenSequenceDemoState createState() => _TweenSequenceDemoState();
}

class _TweenSequenceDemoState extends State<TweenSequenceDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _colorAnimation = _controller.drive(
      TweenSequence<Color?>(
        [
          TweenSequenceItem(
            tween: ColorTween(begin: Colors.blue, end: Colors.red)
                as Animatable<Color?>,
            weight: 1,
          ),
          TweenSequenceItem(
            tween: ColorTween(begin: Colors.red, end: Colors.green)
                as Animatable<Color?>,
            weight: 1,
          ),
        ],
      ),
    );

    _sizeAnimation = _controller.drive(
      TweenSequence<double>(
        [
          TweenSequenceItem(
            tween: Tween(begin: 50.0, end: 150.0),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween(begin: 150.0, end: 100.0),
            weight: 1,
          ),
        ],
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TweenSequence Demo')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              color: _colorAnimation.value,
            );
          },
        ),
      ),
    );
  }
}
