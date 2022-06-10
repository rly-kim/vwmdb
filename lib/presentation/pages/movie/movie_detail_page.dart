import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/movie/single_movie_model.dart';
import '../../viewmodels/movie/movie_viewmodel.dart';
import '../../viewmodels/rate/rate_viewmodel.dart';
import '../../widgets/rate/rating_bar_widget.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class SingleMoviePage extends ConsumerWidget {

  final int movieId;

  SingleMoviePage(this.movieId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<SingleMovieModel> singleMovieModel = ref.watch(singleMovieProvider(movieId));
    return singleMovieModel.when(
      data: (data) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Title'),
            ),
            body: Center(
              child: SingleMoviePageDetail(data),
            ),
        );
      },
      loading: () => CircularProgressIndicator(),
    error: (err, stack) => Text('${err}'),
    );
  }
}

class SingleMoviePageDetail extends ConsumerWidget {

  SingleMovieModel singleMovie;

  SingleMoviePageDetail(this.singleMovie);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(starStateProvider);
    ref.watch(checkInWatchListStateProvider);
    double? movieRatedByMe = ref.watch(rateProvider).getMovieRated(singleMovie.movieId);
    bool ifInWatchList = ref.read(rateProvider).getIfMovieInWatchList(singleMovie.movieId);
    return Container(
      width: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Container(
            padding: EdgeInsets.only(left: 20, top: 30, bottom: 30,),
            child: Expanded(
              child: Text('${singleMovie.title}'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget> [
              Text('${singleMovie.year}'), Text('age'), Text('${singleMovie.runtime} minutes'),
            ],
          ),
          Row(
            children: <Widget> [
              Container(
                width: 200,
                height: 240,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network('https://image.tmdb.org/t/p/w500/${singleMovie.poster}'),
                ),

                padding: EdgeInsets.only(left: 20, right: 30, bottom: 10, top: 40),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text('${singleMovie.genres}'),
                  SizedBox(height: 20),
                  Text('${singleMovie.overview}'),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: ElevatedButton(
              child: Row(
                children: <Widget> [
                  Icon(Icons.add, size: 16),
                  SizedBox(width: 10),
                  ifInWatchList ? Text('시청목록에서 삭제') : Text('시청목록에 추가'),
                ],
              ),
              onPressed: () {
                ref.read(rateProvider).saveMovieIfNotInLocalStore(singleMovie);
                ref.read(rateProvider).postCheckOrUncheckMovieInWatchList(singleMovie.movieId);
                ref.read(checkInWatchListStateProvider.state).state++;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Column(
                children: [
                  Icon(Icons.favorite),
                  Text('${singleMovie.voteAverage} / ${singleMovie.voteCount}'),
                  Text('rating by others'),
                ],
              ),
              SizedBox(width: 30),
              Column(
                children: [
                  StarsButton(singleMovie),
                  movieRatedByMe == null ? Text('') : Text('${movieRatedByMe*2} / 10'),
                  Text('rating by me'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
