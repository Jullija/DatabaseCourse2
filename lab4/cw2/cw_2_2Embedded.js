use("ToursDB");

firstTourInsert = db.Tours.insertOne({
  companyInfo:{
    companyName: "Trivago",
    country: "Poland",
    city: "Kraków",
    address: "Miła 12",
    phone: "123456789",
    email: "trivago@gmail.com"
  },
  reviews:[],
  tourName: "Hot n'Cold",
  price: 92000,
  destination: "Egypt and North Pole",
  availablePlaces: 7,
  startDate: "12.07.2023",
  endDate: "20.08.2023",
});

secondTourInsert = db.Tours.insertOne({
  companyInfo: {
    companyName: "Booking",
    country: "Poland",
    city: "Warszawa",
    address: "Zła 1",
    phone: "987654321",
    email: "booking@gmail.com",
  },
  reviews:[],
  tourName: "Colorful Rainbow",
  price: 19800,
  destination: "New Zealand",
  availablePlaces: 2,
  startDate: "12.07.2023",
  endDate: "25.07.2023",
});


const firstPersonInsert = db.People.insertOne({
  name: "Jan Kowalski"
});
const secondPersonInsert = db.People.insertOne({
  name: "Anna Panna"
});

firstPerson = db.People.findOne(
  {_id: firstPersonInsert.insertedId}
)

secondPerson = db.People.findOne(
  {_id: secondPersonInsert.insertedId}
)


firstReview = {
  stars: 5,
  user: firstPersonInsert.insertedId,
  comment: "Very nice."
};

secondReview = {
  stars: 2,
  user: secondPersonInsert.insertedId,
  comment: "Not nice."
};

db.Tours.update(
  {_id: firstTourInsert.insertedId},
  {$push: {reviews: firstReview}}
)

db.Tours.update(
  {_id: secondTourInsert.insertedId},
  {$push: {reviews: secondReview}}
)

db.Tours.update(
    {_id: firstTourInsert.insertedId},
    {$push: {reviews: secondReview}}
  )


//////////
db.People.aggregate([
    {
      $match: {"_id": secondPersonInsert.insertedId}
    },
    {
      $lookup: {
        from: "Tours",
        localField:"_id",
        foreignField: "reviews.user",
        as: "info"
      }
    },
    {
      $unwind: "$info"
    },
    {
      $project:{
        personName: "$name",
        tourName: "$info.tourName",
        stars: "$info.review.stars"
      }
    }
  ])




  db.Tours.find(
    {
      reviews: 
      {
        $elemMatch: {user: secondPersonInsert.insertedId}
      }
    },
    {
      name: secondPerson.name,
      tourName: true,
      "reviews.$": 1
    }
  )