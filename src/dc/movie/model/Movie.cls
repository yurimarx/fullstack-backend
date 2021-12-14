Class dc.movie.model.Movie Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property movieId As %Integer [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property name As %VarString(MAXLEN = 120);

Property releaseDate As %Date;

Property duration As %Integer;

Property imdb As %String(MAXLEN = 300);

Property movieCategory As dc.movie.model.MovieCategory;

ForeignKey MovieCategoryFK(movieCategory) References dc.movie.model.MovieCategory();

Storage Default
{
<Data name="MovieDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>releaseDate</Value>
</Value>
<Value name="4">
<Value>duration</Value>
</Value>
<Value name="5">
<Value>imdb</Value>
</Value>
<Value name="6">
<Value>movieCategory</Value>
</Value>
</Data>
<DataLocation>^dc.movie.model.MovieD</DataLocation>
<DefaultData>MovieDefaultData</DefaultData>
<IdLocation>^dc.movie.model.MovieD</IdLocation>
<IndexLocation>^dc.movie.model.MovieI</IndexLocation>
<StreamLocation>^dc.movie.model.MovieS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
