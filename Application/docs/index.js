const docOptions = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "Typescript Sample API",
            version: "1.0.0",
            description: "Typescript Node js Sample API"
        },
        servers: [
            {
                url: "http://localhost:4000",
            },
            {
                url: "https://online_server:5000/"
            }
        ],
    },
    apis: ["**/*.ts"]
}

module.exports = {
    docOptions
}