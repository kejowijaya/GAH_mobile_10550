var profile = {
  "name": "Sangvaleap",
  "image": "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
  "email": "sangvaleap.vanny@gmail.com"
};

List categories = [
  {"name": "All", "icon": "assets/icons/home.svg"},
  {"name": "Single Room", "icon": "assets/icons/home.svg"},
  {"name": "Double Room", "icon": "assets/icons/home.svg"},
  {"name": "Family Room", "icon": "assets/icons/home.svg"},
  {"name": "Queen Room", "icon": "assets/icons/home.svg"},
  {"name": "King Room", "icon": "assets/icons/home.svg"},
  {"name": "Bungalow", "icon": "assets/icons/home.svg"},
  {"name": "Single Villa", "icon": "assets/icons/home.svg"},
  {"name": "Apartment", "icon": "assets/icons/home.svg"},
];

List cities = [
  {"name": "Phnom Penh", "icon": "assets/icons/home.svg"},
  {"name": "Siem Reap", "icon": "assets/icons/home.svg"},
  {"name": "Sihanoukville", "icon": "assets/icons/home.svg"},
  {"name": "Battambang", "icon": "assets/icons/home.svg"},
  {"name": "Mondulkiri", "icon": "assets/icons/home.svg"},
  {"name": "Kampot", "icon": "assets/icons/home.svg"},
  {"name": "Pursat", "icon": "assets/icons/home.svg"},
  {"name": "Steung Treng", "icon": "assets/icons/home.svg"},
];

List<String> albumImages = [
  "https://images.unsplash.com/photo-1598928636135-d146006ff4be?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1505692952047-1a78307da8f2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1618221118493-9cfa1a1c00da?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1571508601891-ca5e7a713859?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
];

List features = [
  {
    "id": 100,
    "name": "Superior Room",
    "image":
    "https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "Rp. 500.000",
    "type": categories[1]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 101,
    "name": "Junior Suite",
    "image":"https://images.unsplash.com/photo-1505692952047-1a78307da8f2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2h",
    "price":"Rp. 1.200.000",
    "type": categories[3]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": true,
    "album_images": albumImages,
    "description":
    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 102,
    "name": "Executive Deluxe",
    "image":
    "https://images.unsplash.com/photo-1618221118493-9cfa1a1c00da?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "Rp. 900.000",
    "type": categories[2]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 103,
    "name": "Double Deluxe",
    "image":
    "https://images.unsplash.com/photo-1571508601891-ca5e7a713859?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "Rp. 700.000",
    "type": categories[2]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
];

List recommends = [
  {
    "id": 110,
    "name": "Luxury King",
    "image":
    "https://images.unsplash.com/photo-1541123356219-284ebe98ae3b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$310",
    "type": categories[1]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 111,
    "name": "Classic Room",
    "image":
    "https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$250",
    "type": categories[2]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 112,
    "name": "Twin Room",
    "image":
    "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$190",
    "type": categories[1]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "album_images": albumImages,
    "is_favorited": false,
    "description":
    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },

];

List facilities = [
  {
    "id": 120,
    "name": "Extra Bed",
    "type": "per unit",
    "price": "\Rp.150.000",
    "image": "https://media-cdn.tripadvisor.com/media/photo-s/0c/b4/1b/57/extra-bed.jpg",
  },
  {
    "id": 121,
    "name": "Laundry",
    "type": "per baju",
    "price": "Rp.1000",
    "image": "https://smartlink.id/wp-content/uploads/2023/03/house-laundry-hotel.jpeg",
  },
  {
    "id": 122,
    "name": "Massage",
    "type": "per orang",
    "price": "Rp.200.000",
    "image": "https://akcdn.detik.net.id/visual/2021/08/27/pijat-wanita_169.jpeg?w=720&q=90x",
  },
  {
    "id": 123,
    "name": "Meeting Room",
    "type": "per jam",
    "price": "Rp.300.000",
    "image": "https://cdn-5db27433f911da130c7ce697.closte.com/wp-content/uploads/2019/11/meetings-and-events.slide_.66-e1596476467588.jpg",
  },
  {
    "id": 124,
    "name": "Breakfast",
    "type": "per unit",
    "price": "Rp.50.000",
    "image": "https://storage.googleapis.com/gen-atmedia/3/2017/01/369383bca2cbf05c3f9656d00ddefdbd51b38031.jpeg",
  },
];