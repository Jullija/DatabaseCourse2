
use('sample_mflix');

db.movies.find(
  {title: "Blacksmith Scene"}
)


use('JS');
db.student.insertOne({
  firstName: "Jan",
  secondName: "Kowalski",
  indexNumber: 123456,
  subjects: {
    Math: {
      teacher: "Marcin Park",
      grades: [4, 4, 2, 5]
    },
    Physics: {
      teacher: "Robert Grew",
      grades: [5, 5 , 4]
    },
    English:{
    teacher: "Angelina Balerina",
      grades: [4, 3, 2, 3]
    }
  }
})


db.student.insertMany([{
  firstName: "Kamil",
  secondName: "Ślimak",
  indexNumber: 654321,
  subjects: {
    Math: {
      teacher: "Marcin Park",
      grades: [2, 2, 2, 4]
    },
    IT: {
      teacher: "Patryk Meta",
      grades: [5, 5 , 5, 5, 5]
    },
    Biology:{
    teacher: "Patrycja Fikcja",
      grades: [4, 4, 3, 3]
    }
  }
},
{
  firstName: "Anna",
  secondName: "Panna",
  indexNumber: 192835,
  subjects: {
    Polish: {
      teacher: "Marcin Park",
      grades: [2, 2, 2, 4]
    },
    English: {
      teacher: "Patryk Meta",
      grades: [5, 5 , 5, 5, 5]
    },
    Biology:{
    teacher: "Patrycja Fikcja",
      grades: [4, 4, 3, 3]
    }
  }
}]
)






