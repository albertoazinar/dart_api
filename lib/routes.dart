import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class SpeakersApi {
  final List films = json.decode(File('speakers.json').readAsStringSync());

  //getter to all wrapped routes
  Router get router {
    final router = Router();

    router.get('/', (Request request) {
      return Response.ok('Hello Word');
    });

    router.get('/speakers', (Request request) {
      if (films != null) {
        return Response.ok(json.encode(films),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('No Films found');
    });

    router.get('/speakers/<topic>', (Request request, String topic) {

      final film = films.firstWhere((element) => element['topic'] == topic,
          orElse: () => null);

      if (film != null) {
        return Response.ok(json.encode(film),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('Filme not Found');
    });

    return router;
  }
}
