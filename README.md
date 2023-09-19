# GraphQL Postman Collection Generator

The purpose of this is to provide engineering with a consistent method of regenerating a
shared postman collection that stays aligned and up-to-date with the latest graphql.schema.

This Collection automatically runs login and sets the Authorization header for all requests.

### Generate Collection
https://www.loom.com/share/568013eb6be14cab862f3449a853d421?sid=5b1bbc5f-2e54-4291-b7cb-cc01551e6a26

```shell
$ ./generate.sh
```

### Importing Into Postman
Import both the files in the `/out` directory \
`postman_collection.json` &
`postman_environment.json` 
files into the workspace.

Update any environment variables to your liking \
Duplicate the environment for LOCAL and change the `baseUrl` to http://localhost:3000
