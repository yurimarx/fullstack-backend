Class dc.movie.service.MovieService Extends %CSP.REST
{

ClassMethod GetAll() As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).GetAll(##class(dc.movie.model.Movie).%New())
}

ClassMethod GetOne(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).GetOne(##class(dc.movie.model.Movie).%New(), id)
}

ClassMethod Create() As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Create(##class(dc.movie.model.Movie).%New())
}

ClassMethod Update(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Update(##class(dc.movie.model.Movie).%New(), id)
}

ClassMethod Delete(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Delete(##class(dc.movie.model.Movie).%New(), id)
}

/// Return casting from the movie
ClassMethod GetMovieCasting(id As %Integer) As %Status
{

    #dim tSC As %Status = $$$OK

    Set qry = "SELECT actor->name AS actorName, characterName, movie->name AS movieName FROM dc_movie_model.Casting WHERE movie = ?"

    Set tStatement = ##class(%SQL.Statement).%New()  
    Set qStatus = tStatement.%Prepare(qry)
    If tSC'=1 {WRITE "%Prepare failed:" DO $System.Status.DisplayError(qStatus) QUIT}
    Set rset = tStatement.%Execute(id)
    
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Set %response.Headers("Access-Control-Allow-Origin")="*"

    Set result = []

    While rset.%Next() {
        Set item = {}
        Set item.actorName = rset.actorName
        Set item.movieName = rset.movieName
        Set item.characterName = rset.characterName
        Do result.%Push(item)
    }

    Write result.%ToJSON()
    Quit tSC
}

}
