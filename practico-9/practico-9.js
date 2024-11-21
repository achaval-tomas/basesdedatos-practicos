// info: "https://www.mongodb.com/docs/manual/reference/operator/query/jsonSchema/"

// Ejercicio 1
db.runCommand({
    collMod: "users",
    validator: {
        $jsonSchema: {
            required: ["name", "email", "password"],
            properties: {
                name: { bsonType: "string", maxLength: 30 },
                email: { bsonType: "string", pattern: "^(.*)@(.*)\\.(.{2,4})$" },
                password: { bsonType: "string", minLength: 30 }
            }
        },
    }
})

// Ejercicio 2
db.getCollectionInfos({ name: "users" })

// Ejercicio 3
db.runCommand({
    collMod: "theaters",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["theaterId", "location", "address"],
            properties: {
                theaterId: { bsonType: "int" },
                location: {
                    bsonType: "object",
                    required: ["address"],
                    properties: {
                        address: {
                            bsonType: "object",
                            required: ["street1", "city", "state", "zipcode"],
                            properties: {
                                street1: { bsonType: "string" },
                                city: { bsonType: "string" },
                                state: { bsonType: "string" },
                                zipcode: { bsonType: "string" }
                            }
                        },
                        geo: {
                            bsonType: "object",
                            required: ["type", "coordinates"],
                            properties: {
                                type: {
                                    enum: ["Point", null]
                                },
                                coordinates: {
                                    bsonType: "array",
                                    items: { bsonType: "double" },
                                    maxItems: 2,
                                    minItems: 2
                                }
                            }
                        }
                    }
                }
            }
        }
    },
    validationAction: "warn"
})

// Ejercicio 4
db.runCommand({
    collMod: "movies",
    validator: {
        bsonType: "object",
        required: ["title", "year"],
        properties: {
            title: { bsonType: "string" },
            year: { bsonType: "int", minimum: 1900 },
            cast: { bsonType: "array", uniqueItems: true },
            directors: { bsonType: "array", uniqueItems: true },
            countries: { bsonType: "array", uniqueItems: true },
            genres: { bsonType: "array", uniqueItems: true }
        }
    }
})

// Ejercicio 5
db.createCollection("userProfiles", {
    validator: {
        bsonType: "object",
        required: ["user_id", "language"],
        properties: {
            user_id: { bsonType: "objectId" },
            language: { bsonType: "string", enum: ["English", "Spanish", "Portuguese"] },
            favorite_genres: { bsonType: "array", uniqueItems: true }
        }
    }
}
)

// Ejercicio 6
/*
 Hay una relación One-to-Many entre movies y comments.
 Se utilizó una referencia (movie_id) desde comments hacia movie.
 Esta decisión puede haber sido para reducir el tamaño y la cantidad de modificaciones
 al documento de cada película debido a que no siempre serán relevantes los comentarios
 al trabajar con ellas.
*/

// Ejercicio 7
db.books.insertOne({
    book_id: 15125124,
    title: "Super Book",
    author: "Louis Hamilton",
    price: 99.50,
    category: "Action"
})

db.orders.insertOne({
    order_id: 84724128957120,
    delivery_name: "John Lennon",
    delivery_address: "P. Sherman, 425 Wallaby St.",
    cc_name: "Leo Pessi",
    cc_number: "12948216",
    cc_expiry: "2025-01-01",
    order_details: [
        {
            book_id: 15125124,
            quantity: 3,
            price: 99.50,
        }
    ]
})

