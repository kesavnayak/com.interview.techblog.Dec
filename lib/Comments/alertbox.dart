import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AlertBoxWidget extends StatelessWidget {
  final int i;
  final AppBarController _appBarCtrl = Get.find();
  AlertBoxWidget(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String emailError = '';
    // String review;
    String reviewError = '';
    dynamic _formKey = GlobalKey<FormState>();

    CommentModel commentModel = _appBarCtrl.commentDocumentSnapshot.value[i];

    TextFormField buildEmailFormField() {
      return TextFormField(
        onSaved: (newValue) => commentModel.email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            emailError = "";
            return;
          } else if (emailValidatorRegExp.hasMatch(value)) {
            emailError = "";
            return;
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            emailError = kEmailNullError;
            return emailError;
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            emailError = kInvalidEmailError;
            return emailError;
          }
          commentModel.email = value;
          return null;
        },
        initialValue: commentModel.email,
        style: const TextStyle(
          fontSize: 20.0, color: Colors.black,
          decorationColor: Colors.black, //Font color change
        ),
        cursorColor: Colors.black,
        maxLines: 1,
        decoration: InputDecoration(
            hintText: commentModel.email,
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: const TextStyle(color: Colors.black, fontSize: 16.0)),
      );
    }

    TextFormField buildReviewFormField() {
      return TextFormField(
        onSaved: (newValue) => commentModel.review = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            reviewError = "";
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            reviewError = kAddressreviewError;
            return reviewError;
          }
          commentModel.review = value;

          return null;
        },
        initialValue: commentModel.review,
        cursorColor: Colors.black,
        style: const TextStyle(
          fontSize: 20.0, color: Colors.black,
          decorationColor: Colors.black, //Font color change
        ),
        maxLines: 8,
        decoration: InputDecoration(
            hintText: commentModel.review,
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.grey),
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: const TextStyle(color: Colors.black, fontSize: 16.0)),
      );
    }

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 10.0),
      content: SizedBox(
        width: 300.0,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    "Rate",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  RatingBar.builder(
                    initialRating: double.parse(commentModel.rating.toString()),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      if (kDebugMode) {
                        print(rating);
                      }
                      commentModel.rating = rating;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: buildEmailFormField(),
              ),
              const Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: buildReviewFormField(),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const SizedBox(
                height: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    commentModel.isVerified = false;
                    _appBarCtrl.updateComment(commentModel);
                    Get.back();
                  }
                },
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: const BoxDecoration(
                      color: Color(0xff00bfa5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: const Text(
                      "Edit Comment",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
