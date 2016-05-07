# README

To obtain a token (only test data for now) from the API, use:

    curl -H "Content-Type: application/json" -X POST -d '{"owner_name": "John Doe", "number": "1234 1234 1234 1234", "expiration_date": "2016-12-31", "brand": "VISA", "scheme": "CR", "cvc": "111"}' localhost:3000/tokens
