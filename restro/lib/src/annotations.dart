class WebApi {
  final String url;
  const WebApi({this.url = ''});
}

class GET {
  final String value;
  const GET([this.value = null]);
}

class POST {
  final String value;
  const POST([this.value = null]);
}

class PUT {
  final String value;
  const PUT([this.value = null]);
}

class DELETE {
  final String value;
  const DELETE([this.value = null]);
}

class Path {
  final String value;
  const Path([this.value = null]);
}

class Query {
  final String value;
  const Query([this.value = null]);
}

/** URL for passing url as method param
 *      @WebApi
 *      abstract class APIService {
 *         @GET  
 *         Call<Users> getUsers(@Url String url);
 *      }
 * 
*/
class Url {
  const Url();
}

class QueryMap {
  const QueryMap();
}

class Body {
  const Body();
}

class Header {
  final String value;
  const Header([this.value = null]);
}

class HeaderMap {
  const HeaderMap();
}

/** Headers for passing static headers for method
 *      @WebApi
 *      abstract class APIService {
 *        @Headers({
 *            "Accept": "application/vnd.github.v3.full+json",
 *            "User-Agent": "Retrofit-Sample-App"
 *        })      
 *        @GET  
 *        Call<Users> getUsers(@Url String url);
 *      }
 * 
*/
class Headers {
  final Map<String, String> value;
  const Headers([this.value = const {}]);
}
