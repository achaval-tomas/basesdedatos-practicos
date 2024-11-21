use('mflix')

// Ejercicio 1
db.theaters.aggregate([
    {
        $group: {
            "_id": "$location.address.state",
            n_theaters: { $sum: 1 }
        }
    }
])

// Ejercicio 2
db.theaters.aggregate([
    {
        $group: {
            "_id": "$location.address.state",
            n_theaters: { $sum: 1 }
        }
    },
    {
        $match: {
            n_theaters: { $gte: 2 }
        }
    },
    {
        $group: {
            _id: null,
            n_states_with_2plus_theaters: { $sum: 1 }
        }
    }
])

// Ejercicio 3
// Sin agregación
db.movies.find({
    directors: {
        $elemMatch: {
            $eq: "Louis Lumière"
        }
    }
}).count()

// Con agregación
db.movies.aggregate([
    { $unwind: "$directors" },
    {
        $group: {
            _id: "$directors",
            n_movies: { $sum: 1 }
        }
    },
    {
        $match: {
            _id: "Louis Lumière"
        }
    }
])

// Ejercicio 4
// Con agregación
db.movies.aggregate([
    {
        $match: {
            year: { $gte: 1950, $lte: 1959 }
        }
    },
    {
        $group: {
            _id: null,
            n_movies_in_50s: { $sum: 1 }
        }
    },
    {
        $project: {
            _id: 0
        }
    }
])

// Ejercicio 5
db.movies.aggregate([
    { $unwind: "$genres" },
    { $group: { _id: "$genres", n_movies: { $sum: 1 } } },
    { $project: { _id: 0, genre: "$_id" } },
    { $sort: { n_movies: -1 } },
    { $limit: 10 }
])

// Ejercicio 6
db.comments.aggregate([
    {
        $group: {
            _id: "$email",
            email: { $first: "$email" },
            name: { $first: "$name" },
            n_coms: { $sum: 1 }
        }
    },
    {
        $project: {
            _id: 0
        }
    }
])

// Ejercicio 7
db.movies.aggregate([
    {
        $match: {
            year: { $gte: 1980, $lt: 1990 },
            "imdb.rating": { $type: "double" }
        }
    },
    {
        $group: {
            _id: "$year",
            year: { $first: "$year" },
            avg_rating: { $avg: "$imdb.rating" },
            min_rating: { $min: "$imdb.rating" },
            max_rating: { $max: "$imdb.rating" }
        }
    },
    { $project: { _id: 0 } },
    { $sort: { avg_rating: -1 } }
])

// Ejercicio 8
db.comments.aggregate([
    {
        $group: {
            _id: "$movie_id",
            n_coms: { $sum: 1 }
        }
    },
    { $sort: { n_coms: -1 } },
    { $limit: 10 },
    {
        $lookup: {
            from: "movies",
            localField: "_id",
            foreignField: "_id",
            as: "movie"
        }
    },
    { $unwind: "$movie" },
    {
        $project: {
            title: "$movie.title",
            year: "$movie.year",
            n_coms: 1,
            _id: 0
        }
    }
])

// Ejercicio 9
db.createView("popular_genres", "movies", [
    {
        $lookup:
        {
            from: "comments",
            localField: "_id",
            foreignField: "movie_id",
            as: "all_comments"
        }
    },
    { $unwind: "$genres" },
    {
        $group: {
            _id: "$genres",
            n_coms: {
                $sum: {
                    $size: "$all_comments"
                }
            }
        }
    },
    { $sort: { n_coms: -1 } },
    { $limit: 5 },
    { $project: { _id: 0, genre: "$_id", n_coms: 1 } }
])


// Ejercicio 10
db.movies.aggregate([
    {
        $match: {
            directors: {
                $elemMatch: {
                    $eq: "Jules Bass"
                }
            }
        }
    },
    { $unwind: "$cast" },
    {
        $group: {
            _id: "$cast",
            movies: {
                $addToSet: {
                    title: "$title",
                    year: "$year"
                }
            }
        }
    },
    {
        $match: {
            "movies.2":
                { $exists: true }
        }
    },
    {
        $project: {
            actor: "$_id",
            movies: 1,
            _id: 0
        }
    }
])

