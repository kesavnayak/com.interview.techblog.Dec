import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techblog/Helper/card_background.dart';

class CardWidget extends StatelessWidget {
  final CardBackground cardBackground;
  final String? cardHolderName;
  final double roundedCornerRadius;
  final Color cardHolderNameColor;
  final String? cardNumber;
  final Color numberColor;
  final String? cardNetworkType;

  const CardWidget(
      {Key? key,
      required this.cardBackground,
      this.cardHolderName,
      this.roundedCornerRadius = 20,
      this.cardHolderNameColor = Colors.white,
      this.numberColor = Colors.white,
      this.cardNetworkType,
      this.cardNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 300,
      height: 200,
      decoration: _buildBackground(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildChip(),
          Column(
            children: <Widget>[
              _buildCardNumber(),
              const SizedBox(height: 8),
              _buildNameAndCardNetworkType(),
              const SizedBox(height: 10),
              _buildCardNetworkType(),
            ],
          ),
        ],
      ),
    );
  }

  _buildBackground() {
    if (cardBackground is SolidColorCardBackground) {
      SolidColorCardBackground? solidColorCardBackground =
          cardBackground as SolidColorCardBackground?;
      return BoxDecoration(
        borderRadius: BorderRadius.circular(roundedCornerRadius),
        color: solidColorCardBackground?.backgroundColor,
      );
    } else if (cardBackground is GradientCardBackground) {
      GradientCardBackground? gradientCardBackground =
          cardBackground as GradientCardBackground?;
      return BoxDecoration(
        borderRadius: BorderRadius.circular(roundedCornerRadius),
        gradient: gradientCardBackground?.gradient,
      );
    } else if (cardBackground is ImageCardBackground) {
      ImageCardBackground? imageCardBackground =
          cardBackground as ImageCardBackground?;
      return BoxDecoration(
        borderRadius: BorderRadius.circular(roundedCornerRadius),
        image: imageCardBackground?.build(),
      );
    } else {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(roundedCornerRadius),
        color: Colors.black,
      );
    }
  }

  _buildChip() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      alignment: Alignment.topRight,
      child: Image.network(
        cardNetworkType.toString(),
        height: 45,
      ),
    );
  }

  _buildCardNumber() {
    if (cardNumber == null || cardNumber?.trim() == "") {
      return const SizedBox.shrink();
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        cardNumber.toString(),
        style: GoogleFonts.bigShouldersText(
          color: numberColor,
          fontSize: 24,
        ),
      ),
    );
  }

  _buildNameAndCardNetworkType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        cardHolderName != null
            ? Expanded(
                flex: 3,
                child: AutoSizeText(
                  cardHolderName.toString().toUpperCase(),
                  maxLines: 1,
                  minFontSize: 8,
                  style: GoogleFonts.bigShouldersText(
                    color: cardHolderNameColor,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  _buildCardNetworkType() {
    return Align(
      alignment: Alignment.centerRight,
      child: AutoSizeText('Read More...',
          maxLines: 1,
          minFontSize: 8,
          style: GoogleFonts.bigShouldersText(color: cardHolderNameColor)),
    );
  }
}
