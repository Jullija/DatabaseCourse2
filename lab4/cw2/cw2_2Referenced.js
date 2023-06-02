use('ToursDB');

const firstCompanyInsert = db.Companies.insertOne({
  name: "Trivago",
  country: "Poland",
  city: "Kraków",
  address: "Miła 12",
  phone: "123456789",
  email: "trivago@gmail.com",
  tours: []
});

const secondCompanyInsert = db.Companies.insertOne({
  name: "Booking",
  country: "Poland",
  city: "Warszawa",
  address: "Zła 1",
  phone: "987654321",
  email: "booking@gmail.com",
  tours: []
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

firstReview = db.Reviews.insertOne({
  stars: 5,
  user: firstPersonInsert.insertedId,
  comment: "Very nice."
});

secondReview = db.Reviews.insertOne({
  stars: 2,
  user: secondPersonInsert.insertedId,
  comment: "Not nice."
});


const firstTourInsert = db.Tours.insertOne({
  company: firstCompanyInsert.insertedId,
  tourName: "Hot n'Cold",
  price: 92000,
  destination: "Egypt and North Pole",
  availablePlaces: 7,
  startDate: "12.07.2023",
  endDate: "20.08.2023",
  reviews: [],
  tourists: []
});

const secondTourInsert = db.Tours.insertOne({
  company: secondCompanyInsert.insertedId,
  tourName: "Colorful Rainbow",
  price: 19800,
  destination: "New Zealand",
  availablePlaces: 2,
  startDate: "12.07.2023",
  endDate: "25.07.2023",
  reviews: [],
  tourists: []
});

firstTour = db.Tours.findOne(
  {_id: firstTourInsert.insertedId}
)
secondTour = db.Tours.findOne(
  {_id: secondTourInsert.insertedId}
)


db.Companies.updateOne(
  {_id: firstCompanyInsert.insertedId},
  {$push: {tours: firstTourInsert.insertedId}}
)

db.Companies.updateOne(
  {_id: secondCompanyInsert.insertedId},
  {$push: {tours: secondTourInsert.insertedId}}
)

db.Tours.updateOne(
  {_id: firstTourInsert.insertedId},
  {$push: {reviews: firstReview.insertedId, tourists: firstPersonInsert.insertedId}}
)

db.Tours.updateOne(
  {_id: secondTourInsert.insertedId},
  {$push: {reviews: secondReview.insertedId, tourists: secondPersonInsert.insertedId}}
)

  

////////////////////
db.Tours.find(
    {tourists: firstPersonInsert.insertedId}
)

firstPerson = db.People.findOne(
    {_id: firstPersonInsert.insertedId}
  )

db.People.aggregate([
    {
      $match: {_id: firstPersonInsert.insertedId}
    },
    {
      $lookup:{
        from: "Reviews",
        localField: "_id",
        foreignField: "user",
        as: "reviewInfo"
      }
    },
    {
      $unwind: "$reviewInfo"
    },
    {
      $lookup:{
        from: "Tours",
        localField: "_id",
        foreignField: "tourists",
        as: "tourInfo"
      }
    },
    {
      $unwind: "$tourInfo"
    },
    {
      $project: {
        personName: firstPerson.name,
        personComment: "$reviewInfo.comment",
        starsGiven: "$reviewInfo.stars",
        tourName: "$tourInfo.tourName"
      }
    }
])


db.People.updateOne(
{_id: firstPersonInsert.insertedId},
{$set: {name: "Grzegorz Pomidor"}}
)
