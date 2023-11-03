class GripsModel {
  final String name;
  final String img;
  final String description;

  const GripsModel({
    required this.name,
    required this.img,
    required this.description,
  });
}

List<GripsModel> getAllGrips() {
  final allGrips = [
    const GripsModel(
      name: 'Jugs',
      img:
          'https://static.wixstatic.com/media/003ebe_868ef5895e9647f78e1e816043d8da40~mv2.jpeg/v1/fill/w_640,h_640,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/003ebe_868ef5895e9647f78e1e816043d8da40~mv2.jpeg',
      description: 'Jugs are Very nice indeed, we very like like yis.',
    ),
    const GripsModel(
        name: 'Pinches',
        img:
            'https://static.wixstatic.com/media/003ebe_418dcfcb31bb4375b5c4312f1922c0b4~mv2.jpeg/v1/fill/w_640,h_640,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/003ebe_418dcfcb31bb4375b5c4312f1922c0b4~mv2.jpeg',
        description:
            'Pinches is alright, use your fingers and thumb to PINCH it, like grandma pinches your cheeks'),
    const GripsModel(
      name: 'Crimp',
      img:
          'https://www.99boulders.com/wp-content/uploads/2018/02/crimp-climbing-hold-1200x675.png',
      description: 'u bitch.',
    ),
    const GripsModel(
        name: 'Pinches',
        img:
            'https://static.wixstatic.com/media/003ebe_418dcfcb31bb4375b5c4312f1922c0b4~mv2.jpeg/v1/fill/w_640,h_640,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/003ebe_418dcfcb31bb4375b5c4312f1922c0b4~mv2.jpeg',
        description: 'Alright'),
  ];
  return allGrips;
}
