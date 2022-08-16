class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/logo_gas.png',
    title: 'Limiter le Danger',
    description: 'Notre but est de limiter le danger des fuites de gaz dans les domiciles',
  ),
  Slide(
    imageUrl: 'assets/images/logo_gas.png',
    title: 'Design Interactive App UI',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'assets/images/logo_gas.png',
    title: 'It\'s Just the Beginning',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
];
