import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';
import 'package:vwmdb/rate/data/repositories/rate_repository.dart';

class MockRateLocalSourceImpl extends Mock implements RateLocalSourceImpl {

}

@GenerateMocks([MockRateLocalSourceImpl])
void main() {

  RateRepository? rateRepository;
  RateLocalSourceImpl? rateLocalSourceImpl;
  MockRateLocalSourceImpl? mockRateLocalSourceImpl;

  setUp(() {
    // rateLocalSource = RateLocalSourceImpl();
    //mockRateLocalSourceImpl = MockRateLocalSourceImpl();
    rateLocalSourceImpl = RateLocalSourceImpl();
    rateRepository = RateRepositoryImpl(rateLocalSourceImpl!);
  });

  test('시청 목록에 영화가 있는지 조회', () {
     // when(mockRateLocalSource!.getIfMovieInWatchList(284052))
     // .thenAnswer((_) => boolTrue);

    final result = rateRepository!.getIfMovieInWatchList(284052);

    // verify(mockRateLocalSource!.getIfMovieInWatchList(284052));
  });

  test('영화 시청 목록에 등록', () {

  });

  test('영화 시청 목록에서 삭제', () {

  });

  test('영화에 내가 준 별점이 있는지 조회', () {

  });

  test('영화에 내가 준 별점 조회', () {

  });

  test('영화에 내가 준 별점 저장', () {

  });

  test('영화에 내가 준 별점 삭제', () {

  });
}