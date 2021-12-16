import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:techblog/Models/index.dart';

class PhoneAuthWidgets {
  static Widget getLogo({String? logoPath}) => Material(
        type: MaterialType.transparency,
        elevation: 10.0,
        child: Lottie.asset(logoPath!, width: 250.0),
      );
}

class SearchCountryTF extends StatelessWidget {
  final TextEditingController controller;

  const SearchCountryTF({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 2.0, right: 8.0),
      child: Card(
        child: TextFormField(
          autofocus: false,
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Search your country',
            contentPadding:
                EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String prefix;

  const PhoneNumberField(
      {Key? key, required this.controller, required this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Text("  " + prefix + "  ", style: const TextStyle(fontSize: 16.0)),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextFormField(
              controller: controller,
              autofocus: false,
              keyboardType: TextInputType.phone,
              key: const Key('EnterPhone-TextFormField'),
              decoration: const InputDecoration(
                border: InputBorder.none,
                errorMaxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  final String text;

  const SubTitle(Map<dynamic, Object> map, {Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(' $text',
            style: const TextStyle(color: Colors.white, fontSize: 14.0)));
  }
}

class ShowSelectedCountry extends StatelessWidget {
  final VoidCallback onPressed;
  final Country country;

  const ShowSelectedCountry(
      {Key? key, required this.onPressed, required this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 4.0, right: 4.0, top: 8.0, bottom: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                ' ${country.flag}  ${country.name} ',
              )),
              const Icon(Icons.arrow_drop_down, size: 24.0)
            ],
          ),
        ),
      ),
    );
  }
}

class SelectableWidget extends StatelessWidget {
  final Function(Country) selectThisCountry;
  final Country country;

  const SelectableWidget(
      {Key? key, required this.selectThisCountry, required this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      type: MaterialType.canvas,
      child: InkWell(
        onTap: () => selectThisCountry(country), //selectThisCountry(country),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "  " +
                country.flag.toString() +
                "  " +
                country.name.toString() +
                " (" +
                country.dialCode.toString() +
                ")",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
