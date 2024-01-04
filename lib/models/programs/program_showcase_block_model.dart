class ProgramShowcaseBlockModel {
  bool isHovered;
  String title;
  String? description;
  String imgUrl;

  ProgramShowcaseBlockModel({
    this.isHovered = false,
    required this.title,
    this.description,
    required this.imgUrl,
  });

  static const img = "https://jooinn.com/images/lonely-tree-reflection.jpg";
  static List<ProgramShowcaseBlockModel> programShowcaseList = [
    ProgramShowcaseBlockModel(
      title: 'Program 1',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 2',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 3',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 4',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 5',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 6',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 7',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 8',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 9',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 10',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 11',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 12',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 1',
      description: 'This is a description',
      imgUrl: img,
    ),
    ProgramShowcaseBlockModel(
      title: 'Program 2',
      description: 'This is a description',
      imgUrl: img,
    ),
  ];
}
