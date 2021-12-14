Class dc.movie.model.Casting Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property castingId As %Integer [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property movie As dc.movie.model.Movie;

ForeignKey MovieFK(movie) References dc.movie.model.Movie();

Property actor As dc.movie.model.Actor;

ForeignKey ActorFK(actor) References dc.movie.model.Actor();

Property characterName As %String(MAXLEN = 100);

Index CastingIndex On (movie, actor) [ Unique ];

Storage Default
{
<Data name="CastingDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>movie</Value>
</Value>
<Value name="3">
<Value>actor</Value>
</Value>
<Value name="4">
<Value>characterName</Value>
</Value>
</Data>
<DataLocation>^dc.movie.model.CastingD</DataLocation>
<DefaultData>CastingDefaultData</DefaultData>
<IdLocation>^dc.movie.model.CastingD</IdLocation>
<IndexLocation>^dc.movie.model.CastingI</IndexLocation>
<StreamLocation>^dc.movie.model.CastingS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
