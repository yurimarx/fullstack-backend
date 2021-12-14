Class dc.movie.model.MovieCategory Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property movieCategoryId As %Integer [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property name As %VarString(MAXLEN = 120);

Storage Default
{
<Data name="MovieCategoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
</Data>
<DataLocation>^dc.movie.model.MovieCategoryD</DataLocation>
<DefaultData>MovieCategoryDefaultData</DefaultData>
<IdLocation>^dc.movie.model.MovieCategoryD</IdLocation>
<IndexLocation>^dc.movie.model.MovieCategoryI</IndexLocation>
<StreamLocation>^dc.movie.model.MovieCategoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
