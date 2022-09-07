import 'dart:math';

import 'package:design_pattern/design_pattern/structural/flyweight/positioned_shape.dart';
import 'package:design_pattern/design_pattern/structural/flyweight/shape_factory.dart';
import 'package:design_pattern/design_pattern/structural/flyweight/shape_flyweight_factory.dart';
import 'package:design_pattern/design_pattern/structural/flyweight/shape_type.dart';
import 'package:flutter/material.dart';

class FlyweightExample extends StatefulWidget {
  @override
  _FlyweightExampleState createState() => _FlyweightExampleState();
}

class _FlyweightExampleState extends State<FlyweightExample> {
  static const int SHAPES_COUNT = 1000;

  final ShapeFactory shapeFactory = ShapeFactory();

  ShapeFlyweightFactory? _shapeFlyweightFactory;
  List<IPositionedShape>? _shapesList;

  int _shapeInstancesCount = 0;
  bool _useFlyweightFactory = false;

  @override
  void initState() {
    super.initState();

    _shapeFlyweightFactory = ShapeFlyweightFactory(
      shapeFactory: shapeFactory,
    );

    _buildShapesList();
  }

  void _buildShapesList() {
    var shapeInstancesCount = 0;
    _shapesList = List<IPositionedShape>();

    for (var i = 0; i < SHAPES_COUNT; i++) {
      var shapeType = _getRandomShapeType();
      var shape = _useFlyweightFactory
          ? _shapeFlyweightFactory?.getShape(shapeType)
          : shapeFactory.createShape(shapeType);

      shapeInstancesCount++;
      _shapesList?.add(shape!);
    }

    setState(() {
      _shapeInstancesCount = _useFlyweightFactory
          ? _shapeFlyweightFactory!.getShapeInstancesCount()
          : shapeInstancesCount;
    });
  }

  ShapeType _getRandomShapeType() {
    var values = ShapeType.values;

    return values[Random().nextInt(values.length)];
  }

  void _toggleUseFlyweightFactory(bool value) {
    setState(() {
      _useFlyweightFactory = value;
    });

    _buildShapesList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        for (var shape in _shapesList!)
          PositionedShapeWrapper(
            shape: shape,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwitchListTile.adaptive(
              title: Text(
                'Use flyweight factory',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: Colors.black,
              value: _useFlyweightFactory,
              onChanged: _toggleUseFlyweightFactory,
            ),
          ],
        ),
        Center(
          child: Text(
            'Shape instances count: $_shapeInstancesCount',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}