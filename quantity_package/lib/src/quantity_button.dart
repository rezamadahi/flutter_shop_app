import 'package:flutter/material.dart';

class QuantityButton extends StatefulWidget {
  QuantityButton(
      {Key key, this.value = 0, this.maxValue = 500, this.onChangeValue , this.isLoading = false})
      : super(key: key);
  Function onChangeValue;
  int value;
  int maxValue;
  bool isLoading;

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  add() {
    setState(() {
      if (widget.maxValue > widget.value) {
        widget.value++;
        widget.onChangeValue?.call(true);
      }
    });
  }

  minus() {
    setState(() {
      if (widget.value > 0) {
        widget.value--;
        widget.onChangeValue?.call(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutlinedButton(
          icon: Icons.remove,
          press: widget.isLoading ?  null : () => minus(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.value.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlinedButton(icon: Icons.add, press:widget.isLoading ?  null : () => add())
      ],
    );
  }

  Widget buildOutlinedButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: ButtonStyle(
            padding:
            MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ))),
        onPressed: widget.isLoading ? null : press,
        child: Icon(icon),
      ),
    );
  }
}
