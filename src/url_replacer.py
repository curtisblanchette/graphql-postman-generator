#!/usr/bin/python3

# this is to replace all the urls of all queries and mutations
# with the baseUrl environment variable from the environment file "postman_environment.json"
# enabling users to switch environments using generated collection
import json

with open('out/postman_collection.json', 'r') as f:
    data = json.load(f)

for item in data['item']:
    for request in item['item']:
        urlObject = {
            "raw": "https://core.dev-api.feeld.co/graphql",
            "protocol": "",
            "host": [
                "{{baseUrl}}"
            ],
            "path": [
                "graphql"
            ]
        }
        request['request']['url'] = urlObject

with open('out/postman_collection.json', 'w') as f:
    json.dump(data, f)