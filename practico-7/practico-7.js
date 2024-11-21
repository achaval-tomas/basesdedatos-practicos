// PARTE 1

use('mflix')

// Ejercicio 1
db.users.insertMany(
    [
        {
            name: 'Ned Stark1',
            email: 'sean_an@gameofthron.es',
            password: '$2b$12$UREFwsRUoyF0CRqGNK0LzO0HM/jLhgUCNNIJ9RJAqMUQ74crlJ1Vu'
        },
        {
            name: 'Ned Stark2',
            email: 'sean_be@gameofthron.es',
            password: '$2b$12$UREFwsRUoyF0CRqGNK0LzO0HM/jLhgUCNNIJ9RJAqMUQ74crlJ1Vu'
        },
        {
            name: 'Ned Stark3',
            email: 'se_bean@gameofthron.es',
            password: '$2b$12$UREFwsRUoyF0CRqGNK0LzO0HM/jLhgUCNNIJ9RJAqMUQ74crlJ1Vu'
        }
    ]
)

// Ejercicio 2
db.movies.find({
    $and: [
        { year: { $gte: 1990 } },
        { year: { $lt: 2000 } },
        { "imdb.rating": { $type: "double" } }
    ]
}, {
    _id: 0, title: 1, cast: 1, directors: 1, "imdb.rating": 1
}).sort({
    "imdb.rating": -1
}).limit(10)

// Ejercicio 3
db.comments.find({
    movie_id: { $eq: ObjectId("573a1399f29313caabcee886") },
    date: { $gte: ISODate("2014-01-01"), $lt: ISODate("2017-01-01") }
},
    { _id: 0, movie_id: 0 }
).count()

// Ejercicio 4
db.comments.find({
    email: { $eq: "patricia_good@fakegmail.com" }
},
    { _id: 0, email: 0 }
).sort(
    { date: -1 }
).limit(3)

// Ejercicio 5
db.movies.find({
    genres: { $all: ["Drama", "Action"] },
    languages: { $size: 1 },
    $or: [
        { "imdb.rating": { $type: "double", $gt: 9 } },
        { runtime: { $gte: 180 } }
    ]
}, {
    title: 1,
    languages: 1,
    genres: 1,
    released: 1,
    "imdb.votes": 1
})

// Ejercicio 6
db.theaters.find({
    "location.address.state": { $in: ["CA", "NY", "TX"] },
    "location.address.city": { $regex: "^F" }
}, {
    _id: 1, theaterId: 1, "location.address.state": 1, "location.address.city": 1

})

// Ejercicio 7
db.comments.updateOne(
    {
        _id: ObjectId("5b72236520a3277c015b3b73")
    },
    {
        $set: {
            text: "Mi mejor comentario"
        },
        $currentDate: { date: true }
    }
)

// Ejercicio 8
db.users.updateOne(
    { email: "joel.macdonel@fakegmail.com" },
    {
        $set:
            { password: "Some Password" }
    },
    {
        upsert: true
    }
)

// Ejercicio 9
db.comments.deleteMany(
    {
        email: "victor_patel@fakegmail.com",
        date: {
            $gte: ISODate("1980-01-01"),
            $lt: ISODate("1981-01-01")
        }
    }
)

// PARTE 2
use("restaurantdb");

// Ejercicio 10
db.restaurants.find(
    {
        grades:
        {
            $elemMatch:
            {
                date: {
                    $gte: ISODate("2014-01-01"),
                    $lt: ISODate("2015-01-01")
                },
                score: { $gt: 70, $lte: 90 }
            }
        }
    },
    { _id: 1, grades: 1 }
)

// Ejercicio 11
db.restaurants.updateOne(
    { restaurant_id: "50018608" },
    {
        $push: {
            grades: {
                $each: [{
                    "date": ISODate("2019-10-10T00:00:00Z"),
                    "grade": "A",
                    "score": 18
                }, {
                    "date": ISODate("2020-02-25T00:00:00Z"),
                    "grade": "A",
                    "score": 21
                }
                ]
            }
        }
    }
)