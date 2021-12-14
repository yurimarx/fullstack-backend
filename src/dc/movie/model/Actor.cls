Class dc.movie.model.Actor Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property actorId As %Integer [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property name As %VarString(MAXLEN = 120);

Property dob As %Date;

Property genre As %Integer(VALUELIST = ",1,2");

Storage Default
{
<Data name="ActorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>dob</Value>
</Value>
<Value name="4">
<Value>genre</Value>
</Value>
</Data>
<DataLocation>^dc.movie.model.ActorD</DataLocation>
<DefaultData>ActorDefaultData</DefaultData>
<IdLocation>^dc.movie.model.ActorD</IdLocation>
<IndexLocation>^dc.movie.model.ActorI</IndexLocation>
<StreamLocation>^dc.movie.model.ActorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
