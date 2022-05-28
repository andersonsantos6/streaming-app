import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final String nameCategory;

  final Function() fnSetstate;

  const CategoryWidget({
    Key? key,
    required this.nameCategory,
    required this.fnSetstate,
  }) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: ElevatedButton(
          onPressed: widget.fnSetstate,
          child: Text(
            widget.nameCategory,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).accentColor),
          ),
        ));
  }
}
