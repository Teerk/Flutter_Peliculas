// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //todo luego por una instancia de movie
    // final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);

      return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie),
              _Overview(movie),
              CastingCards(movie.id)
            ])
          )
        ],

      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 250.0,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,

        title: Container(
          width: double.infinity,
          height: 250.0,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 1, left: 10, right: 10),
          color: Colors.black12,
          child: Text(movie.title)
          ),

        background: FadeInImage(
          placeholder: AssetImage('assets/gif1.gif'), 
          image: NetworkImage(movie.fullBackDropPath),
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    return Container(
      margin: EdgeInsets.only(top:10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:FadeInImage(
              placeholder: AssetImage('assets/gif1.gif'), 
              image: NetworkImage(movie.fullUrl),
              height: 250.0,
              width: 100.0,
              
            )
          ),

          SizedBox(width: 10,),
          
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width-140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [              
                Text(movie.title, style:Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,
                maxLines: 2             ,
                ),
                Text(movie.originalTitle, style:Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,
                maxLines: 2             ,
                ),
                Row(
                  children: [
                    Icon(Icons.star_rate, size: 15,color:Colors.yellow,),
                    SizedBox(width: 5),
                    Text('Calificación: ${movie.voteAverage}', style:Theme.of(context).textTheme.caption,
                maxLines: 2             ,
                ),
                  ],
                  
                )
          
          
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {  

    final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
        ),
    );
  }
}