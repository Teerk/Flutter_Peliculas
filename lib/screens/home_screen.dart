import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

      final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
      
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas de cine'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){ },
            icon: Icon(Icons.search_outlined)
            ), 
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          CardSwiper(movies: moviesProvider.onDisplayMovies),
          MovieSlider(
            moviesPopular:moviesProvider.popularMovies,
            title:'Peliculas Populares >',
            onNextPage:(){
              moviesProvider.getPopularMovies();
            }
          ),

        ],
      ),
      )
    );
  }
}