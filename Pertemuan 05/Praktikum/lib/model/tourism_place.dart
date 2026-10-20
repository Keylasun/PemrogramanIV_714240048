class TourismPlace {
  String name;
  String location;
  String description;
  String openDays;
  String openTime;
  String ticketPrice;
  String imageAsset;
  List<String> imageUrls;

  TourismPlace({
    required this.name,
    required this.location,
    required this.description,
    required this.openDays,
    required this.openTime,
    required this.ticketPrice,
    required this.imageAsset,
    required this.imageUrls,
  });
}

var tourismPlaceList = [
  TourismPlace(
    name: 'Farm House Lembang',
    location: 'Lembang',
    description:
        'Berada di jalur utama Bandung-Lembang, Farm House menjadi objek wisata yang selalu ramai dikunjungi pengunjung. Dengan suasana berarsitektur Eropa, banyak spot foto menarik yang ditawarkan.',
    openDays: 'Open Everyday',
    openTime: '09:00 - 20:00',
    ticketPrice: 'Rp 25.000',
    imageAsset: 'images/ranca-upas.jpg',
    imageUrls: [
      'https://picsum.photos/300/200?random=1',
      'https://picsum.photos/300/200?random=2',
      'https://picsum.photos/300/200?random=3',
    ],
  ),
  TourismPlace(
    name: 'Observatorium Bosscha',
    location: 'Lembang',
    description:
        'Memiliki beberapa teleskop besar, antara lain Refraktor Ganda Zeiss. Benda ini diletakkan pada atap kubah sehingga saat teropong digunakan, atap tersebut harus dibuka.',
    openDays: 'Open Tuesday - Saturday',
    openTime: '09:00 - 14:30',
    ticketPrice: 'Rp 20.000',
    imageAsset: 'images/ranca-upas.jpg',
    imageUrls: [
      'https://picsum.photos/300/200?random=4',
      'https://picsum.photos/300/200?random=5',
      'https://picsum.photos/300/200?random=6',
    ],
  ),
  TourismPlace(
    name: 'Ranca Upas',
    location: 'Ciwidey',
    description:
        'Ranca Upas Ciwidey adalah kawasan bumi perkemahan di bawah pengelolaan Perhutani. Tempat ini berada di kawasan wisata Bandung Selatan.',
    openDays: 'Open Everyday',
    openTime: '24 Hours',
    ticketPrice: 'Rp 20.000',
    imageAsset: 'images/ranca-upas.jpg',
    imageUrls: [
      'https://picsum.photos/300/200?random=7',
      'https://picsum.photos/300/200?random=8',
      'https://picsum.photos/300/200?random=9',
    ],
  ),
];