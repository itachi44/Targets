import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/image1.png',
    title: 'Venir à bout du Corona Virus!',
    description: 'Le virus gagne du terrain!, chaque jour la proportion d\'individus contaminés ne cesse de croitre. \nArretons la propagation du virus dès maintenant',
  ),
  Slide(
    imageUrl: 'assets/images/image2.jpg',
    title: 'Se déplacer en sécurité',
    description: 'Target vous permet de consulter sur votre itinéraire les endroits fréquentés par des personnes contaminés.',
  ),
  Slide(
    imageUrl: 'assets/images/image3.jpg',
    title: 'Suivi de l\'itinéraire',
    description: 'Il permettra aux autorités sanitaires de suivre vos déplacements quotidiens afin de vous éviter tout potentiel risque de contamination.',
  ),
];
