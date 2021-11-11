import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';


class MovieSlider extends StatefulWidget {

    final List<Movie> moviesPopular;
    final String? title;
    final Function onNextPage;

  const MovieSlider({
    Key? key, 
    required this.moviesPopular,
    required this.onNextPage,
    this.title
    }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}



class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();    

    scrollController.addListener(() {
      // print(scrollController.position.pixels);
      // print(scrollController.position.maxScrollExtent);

      if(scrollController.position.pixels >=scrollController.position.maxScrollExtent-1000){
        widget.onNextPage();
      }
    });


  }

  @override
  void dispose(){
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


        if (this.widget.moviesPopular.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(child: CircularProgressIndicator()),
      );
    }


    return Container(
      width: double.infinity,
      height: 250,
      color:Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if(this.widget.title != null)
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(this.widget.title!, style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
          ),
          

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.moviesPopular.length,
              itemBuilder: (BuildContext context, int index) {
                return _MoviePoster(widget.moviesPopular[index]);
              },
            ),
          ),
          
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {


  final Movie moviePopular;

  const _MoviePoster(this.moviePopular);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 250,
      color: Colors.white10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()=>{
              Navigator.pushNamed(context, 'details',arguments: moviePopular)
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage('assets/gif1.gif'), 
                image: NetworkImage(moviePopular.fullUrl),
                fit: BoxFit.cover,
                ),
            ),
          ),
            SizedBox(height: 10,),
            Text(moviePopular.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
            
        ],
      ),
    );
  }
}
