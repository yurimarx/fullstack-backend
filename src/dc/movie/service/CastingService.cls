Class dc.movie.service.CastingService
{

ClassMethod GetAll() As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).GetAll(##class(dc.movie.model.Casting).%New())
}

ClassMethod GetOne(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).GetOne(##class(dc.movie.model.Casting).%New(), id)
}

ClassMethod Create() As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Create(##class(dc.movie.model.Casting).%New())
}

ClassMethod Update(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Update(##class(dc.movie.model.Casting).%New(), id)
}

ClassMethod Delete(id As %Integer) As %Status
{
    Return ##class(dc.movie.service.CrudUtilService).Delete(##class(dc.movie.model.Casting).%New(), id)
}

}
