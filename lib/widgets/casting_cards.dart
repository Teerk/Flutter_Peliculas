import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {


  final int movieId;

  const CastingCards( this.movieId );
   
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot snapshot) {

        if(!snapshot.hasData){
          return Container(
                margin: EdgeInsets.only(bottom: 30),
                width: double.infinity,
                height: 180,
                child: CupertinoActivityIndicator());
        }

        final List<Cast> cast = snapshot.data;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          // color: Colors.red,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _CastCards(cast[index]);
              }),
        );

      },
    );



  }
}

class _CastCards extends StatelessWidget {

  final Cast actor;

  const _CastCards( this.actor );


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_constructors
            child: FadeInImage(
              placeholder: AssetImage('assets/gif1.gif'), 
              image: NetworkImage(actor.fotoDePerfilActor),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
              ),
          ),
          SizedBox(height: 5,),
          Text(
            actor.originalName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}