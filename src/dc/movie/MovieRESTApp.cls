Class dc.movie.MovieRESTApp Extends %CSP.REST
{

Parameter CHARSET = "utf-8";

Parameter CONTENTTYPE = "application/json";

Parameter Version = "1.0.0";

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<!-- Server Info -->
<Route Url="/" Method="GET" Call="GetInfo" Cors="true"/>
<!-- Swagger specs -->
<Route Url="/_spec" Method="GET" Call="SwaggerSpec" />

<!-- List all movies -->
<Route Url="/movies" Method="GET" Call="GetAllMovies" />
<!-- Get a movie -->
<Route Url="/movies/:id" Method="GET" Call="GetMovie" />
<!-- Get the movie casting -->
<Route Url="/movies/casting/:id" Method="GET" Call="GetMovieCasting" />
<!-- Create new movie -->
<Route Url="/movies" Method="POST" Call="CreateMovie" />
<!-- Update a movie -->
<Route Url="/movies/:id" Method="PUT" Call="UpdateMovie" />
<!-- Delete a movie -->
<Route Url="/movies/:id" Method="DELETE" Call="DeleteMovie" />

<!-- List all movie categories --> 
<Route Url="/categories" Method="GET" Call="GetAllMovieCategories" Cors="true" />
<!-- Get a movie category -->
<Route Url="/categories/:id" Method="GET" Call="GetMovieCategory" /> 
<!-- Create new movie category -->
<Route Url="/categories" Method="POST" Call="CreateMovieCategory" />
<!-- Update a movie category -->
<Route Url="/categories/:id" Method="PUT" Call="UpdateMovieCategory" />
<!-- Delete a movie category -->
<Route Url="/categories/:id" Method="DELETE" Call="DeleteMovieCategory" />

<!-- List all actors -->
<Route Url="/actors" Method="GET" Call="GetAllActors" />
<!-- Get a actor -->
<Route Url="/actors/:id" Method="GET" Call="GetActor" />
<!-- Create new actor -->
<Route Url="/actors" Method="POST" Call="CreateActor" />
<!-- Update a actor -->
<Route Url="/actors/:id" Method="PUT" Call="UpdateActor" />
<!-- Delete a actor -->
<Route Url="/actors/:id" Method="DELETE" Call="DeleteActor" />


<!-- List all castings -->
<Route Url="/castings" Method="GET" Call="GetAllCastings" />
<!-- Get a actor -->
<Route Url="/castings/:id" Method="GET" Call="GetCasting" />
<!-- Create new actor -->
<Route Url="/castings" Method="POST" Call="CreateCasting" />
<!-- Update a actor -->
<Route Url="/castings/:id" Method="PUT" Call="UpdateCasting" />
<!-- Delete a actor -->
<Route Url="/castings/:id" Method="DELETE" Call="DeleteCasting" />

</Routes>
}

/// List movies
ClassMethod GetAllMovies() As %Status
{
  Return ##class(dc.movie.service.MovieService).GetAll()
}

/// Get movie casting
ClassMethod GetMovieCasting(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.MovieService).GetMovieCasting(id)
}

/// Get a movie
ClassMethod GetMovie(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.MovieService).GetOne(id)
}

// Create a new movie

ClassMethod CreateMovie() As %Status
{
  Return ##class(dc.movie.service.MovieService).Create()
}

// Update a movie

ClassMethod UpdateMovie(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.MovieService).Update(id)
}

// Delete a movie

ClassMethod DeleteMovie(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.MovieService).Delete(id)
}

/// List movies categories
ClassMethod GetAllMovieCategories() As %Status
{
  Return ##class(dc.movie.service.MovieCategoryService).GetAll()
}

/// Get a movie category
ClassMethod GetMovieCategory(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.MovieCategoryService).GetOne(id)
}

// Create a new movie category

ClassMethod CreateMovieCategory() As %Status
{
  Return ##class(dc.movie.service.MovieCategoryService).Create()
}

// Update a movie category

ClassMethod UpdateMovieCategory(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.MovieCategoryService).Update(id)
}

// Delete a movie category

ClassMethod DeleteMovieCategory(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.MovieCategoryService).Delete(id)
}

/// List actors
ClassMethod GetAllActors() As %Status
{
  Return ##class(dc.movie.service.ActorService).GetAll()
}

/// Get an actor
ClassMethod GetActor(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.ActorService).GetOne(id)
}

// Create a new actor

ClassMethod CreateActor() As %Status
{
  Return ##class(dc.movie.service.ActorService).Create()
}

// Update an actor

ClassMethod UpdateActor(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.ActorService).Update(id)
}

// Delete an actor

ClassMethod DeleteActor(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.ActorService).Delete(id)
}

/// List castings
ClassMethod GetAllCastings() As %Status
{
  Return ##class(dc.movie.service.CastingService).GetAll()
}

/// Get a casting
ClassMethod GetCasting(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.CastingService).GetOne(id)
}

// Create a new casting item

ClassMethod CreateCasting() As %Status
{
  Return ##class(dc.movie.service.CastingService).Create()
}

// Update a casting

ClassMethod UpdateCasting(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.CastingService).Update(id)
}

// Delete a casting

ClassMethod DeleteCasting(id As %Integer) As %Status
{
  Return ##class(dc.movie.service.CastingService).Delete(id)
}

/// General information
ClassMethod GetInfo() As %Status
{
  SET version = ..#Version
  SET fmt=##class(%SYS.NLS.Format).%New("ptbw")
  
  SET info = {
    "Service": "Movie API",
    "version": (version),
    "Developer": "Yuri Gomes",
    "Status": "Ok",
    "Date": ($ZDATETIME($HOROLOG))
  }
  Set %response.ContentType = ..#CONTENTTYPEJSON
  Set %response.Headers("Access-Control-Allow-Origin")="*"

  Write info.%ToJSON()
  Quit $$$OK
}

ClassMethod OnPreDispatch(pUrl As %String, pMethod As %String, ByRef pContinue As %Boolean) As %Status
{
  SET tSC = $$$OK
  
  TRY {
    
    // Set the return type according to the Accept type in the request. Default is application/json.
    IF ('..AcceptsContentType(..#CONTENTTYPEJSON)) {
      SET tSC = ..ReportHttpStatusCode(..#HTTP406NOTACCEPTABLE), pContinue=0
      QUIT 
        } ELSE {   
      // This always returns json
      SET %response.ContentType=..#CONTENTTYPEJSON
        }
        
        
        // read request object into %DynamicObject format
    IF ((pMethod'="POST") && (pMethod'="PUT")) || (%request.Content="") {
      SET %request.Content = {}
    } ELSE {
      IF '$isobject(%request.Content) {
        SET tContent = %request.Content
      } ELSE {
        SET tContent = ""
        WHILE '%request.Content.AtEnd {
          SET tContent = tContent_%request.Content.Read()
        }
      }
      IF (tContent="") {
        SET %request.Content = {}
      } ELSE {
        SET tContent = $zconvert(tContent, "I", "UTF8")
        SET %request.Content = ##class(%Library.DynamicObject).%FromJSON(tContent)
      }
    }
        
  } CATCH ex {
    SET tSC = ex.AsStatus()
  }
  QUIT ##class(%iKnow.REST.Base).%ErrorHandler(tSC, .pContinue)
}

ClassMethod %ProcessResult(pStatus As %Status = {$$$OK}, pResult As %DynamicObject = "") As %Status [ Internal ]
{
  #dim %response As %CSP.Response
  
  SET tSC = $$$OK
  IF $$$ISERR(pStatus) {
    SET %response.Status = 500
    SET tSC = ..StatusToJSON(pStatus, .tJSON)
    IF $isobject(tJSON) {
      SET pResult = tJSON
    } ELSE {
      SET pResult = { "errors": [ { "error": "Unknown error parsing status code" } ] }
    }
  } 
  ELSEIF pStatus=1 {
    IF '$isobject(pResult){
      SET pResult = {
      }
    }
  }
  ELSE {
    SET %response.Status = pStatus
    SET error = $PIECE(pStatus, " ", 2, *)
    SET pResult = {
      "error": (error)
    }
  }
  
  IF pResult.%Extends("%Library.DynamicAbstractObject") {
    WRITE pResult.%ToJSON()
  }
  ELSEIF pResult.%Extends("%JSON.Adaptor") {
    DO pResult.%JSONExport()
  }
  ELSEIF pResult.%Extends("%Stream.Object") {
    DO pResult.OutputToDevice()
  }
  
  QUIT tSC
}

ClassMethod ReportHttpStatusCode(pHttpStatus, pSC As %Status = {$$$OK}) As %Status
{
  Set %response.Status=pHttpStatus
  
  If $$$ISERR(pSC) Do ..outputStatus(pSC)
  /*
  If (+pHttpStatus>=400) {
    Set %response.ContentType = "application/json"
    SET pResult = {
      "error": ($PIECE(pHttpStatus, " ", 2, *))
    }
    Return ..%ProcessResult($$$OK, pResult)
  }*/
      
  Return $$$OK
}

ClassMethod SwaggerSpec() As %Status
{
  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)
  Do swagger.info.%Remove("x-ISC_Namespace")
  Set swagger.basePath = "/movie-api" 
  Set swagger.info.title = "Movie API"
  Set swagger.info.version = "1.0"
  Set swagger.host = "localhost:52773"
  Return ..%ProcessResult($$$OK, swagger)
}

}
