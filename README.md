It is a TODO application with a REST API to create, read, update and delete TODOs. It uses [MongoDB](https://www.mongodb.com/) as the database. [JWT](https://jwt.io/) is used for authentication. The server is built using [Shelf](https://pub.dev/packages/shelf), [Shelf Router](https://pub.dev/packages/shelf_router) and [Mongo Dart](https://pub.dev/packages/mongo_dart).
configured to enable running with [Docker](https://www.docker.com/).

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
server listening on 127.0.0.1:8080
```

And then from a second terminal:

```
$ curl http://127.0.0.1:8080/
{'message': 'Hey Buddy, Server is up and running.'}

$ curl http://127.0.0.1:8080/any-path
{'message': 'Are you lost buddy?'}
```

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
server listening on 127.0.0.1:8080
```

And then from a second terminal:

```
$ curl http://127.0.0.1:8080/
{'message': 'Hey Buddy, Server is up and running.'}

$ curl http://127.0.0.1:8080/any-path
{'message': 'Are you lost buddy?'}
```

## TODO

hosting on cloud
client side application(using flutter)

## Contributing

We welcome contributions! You can contribute by reporting bugs, suggesting enhancements or writing code.
