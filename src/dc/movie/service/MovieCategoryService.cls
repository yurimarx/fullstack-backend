Class dc.movie.service.MovieCategoryService
{

ClassMethod GetAll() As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).GetAll(##class(dc.movie.model.MovieCategory).%New(), "dc_movie_model.MovieCategory")
}

ClassMethod GetOne(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).GetOne(##class(dc.movie.model.MovieCategory).%New(), id)
}

ClassMethod Create() As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Create(##class(dc.movie.model.MovieCategory).%New())
}

ClassMethod Update(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Update(##class(dc.movie.model.MovieCategory).%New(), id)
}

ClassMethod Delete(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Delete(##class(dc.movie.model.MovieCategory).%New(), id)
}

}
