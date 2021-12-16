import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RoundedAlertBox extends StatelessWidget {
  final int i;
  const RoundedAlertBox(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              elevation: 0,
              onPressed: () async {
                await Get.dialog(openAlertBox());
              },
              color: const Color(0xff00bfa5),
              child: const Text(
                "+ Add Comment",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // double _rating = 0;
  // String email;

  openAlertBox() {
    String emailError = '';
    // String review;
    String reviewError = '';
    CommentModel commentModel = CommentModel(
        id: null,
        email: null,
        isVerified: null,
        phoneNumber: null,
        postRef: null,
        parentPostRef: null,
        rating: null,
        timeStamp: null,
        review: null,
        token: null);
    dynamic _formKey = GlobalKey<FormState>();

    final AppBarController _appBarCtrl = Get.find();
    final ArticleController _articleCtrl = Get.find();
    final AuthController _authCtrl = Get.find();

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
        style: const TextStyle(
          fontSize: 20.0, color: Colors.black,
          decorationColor: Colors.black, //Font color change
        ),
        cursorColor: Colors.black,
        maxLines: 1,
        decoration: const InputDecoration(
            hintText: "Enter Email",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: TextStyle(color: Colors.black, fontSize: 16.0)),
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
        cursorColor: Colors.black,
        style: const TextStyle(
          fontSize: 20.0, color: Colors.black,
          decorationColor: Colors.black, //Font color change
        ),
        maxLines: 8,
        decoration: const InputDecoration(
            hintText: "Add Review",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: TextStyle(color: Colors.black, fontSize: 16.0)),
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
                    style: TextStyle(fontSize: 16.0),
                  ),
                  RatingBar.builder(
                    initialRating: commentModel.rating != null
                        ? double.parse(commentModel.rating.toString())
                        : 0.00,
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
                  child: buildEmailFormField()),
              const Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: buildReviewFormField()),
              const SizedBox(
                height: 5.0,
              ),
              const SizedBox(
                height: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    commentModel.phoneNumber = _authCtrl.getPhoneNumber;
                    commentModel.token = _authCtrl.getToken;
                    commentModel.isVerified = false;
                    commentModel.postRef = _articleCtrl.articleModel[i].id;
                    commentModel.parentPostRef =
                        _articleCtrl.articleModel[i].articleId;
                    _appBarCtrl.addComment(commentModel);
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
                      "Add Comment",
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
