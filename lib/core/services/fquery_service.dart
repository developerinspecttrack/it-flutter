import 'package:fquery/fquery.dart';

class FQueryService{
  static final QueryClient _queryClient = QueryClient(
    defaultQueryOptions: DefaultQueryOptions()
  );
  static QueryClient get client => _queryClient;
}