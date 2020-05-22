//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

#include {% TWebInclude() %}
REQUEST HB_CODEPAGE_ES850
REQUEST HB_LANG_ESWIN
REQUEST DBFCDX
function main(op)
    local o, oCol, oWeb, oBrw, cAlias
	local aRows := {}
	local cStyle := cHtml:= cfooter:=''

		USE ( PATH_DATA + 'movies.dbf' ) NEW SHARED
		INDEX ON field->nombre TAG "nombre" FOR !Empty(field->ext) MEMORY			
	
		cAlias := Alias()
		nL:=0
		while !Eof() 
		
			Aadd( aRows,  { 'nombre' 	=> UHtmlEncode( (cAlias)->nombre  )	,;
							 'tamano' 	=> (cAlias)->tamano 		,;						
							 'duracion' => UHtmlEncode( (cAlias)->duracion 	)	,;						
							 'reparto'	=> UHtmlEncode( (cAlias)->reparto )	})
			(cAlias)->( dbskip() )
		   nL++
		   If nL=154
			 *exit
		   Endif
		end
	    CLOSE
		DEFINE WEB oWeb TITLE 'MovieCenter' TABLES INIT
		TEXT TO cStyle ECHO
		
		<head>
	   <meta charset="utf-8">
   		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1"> 
		<link rel="icon" href="images/moviecenter.ico" type="image/x-icon">
   		<link rel="shortcut icon" href="moviecenter.ico" type="image/x-icon">
   		<title>MovieCenter Septimo Arte</title>
   </head>	
		<style>
		
		.jumbotron {
			background: url("images/banner.jpg") no-repeat center center;
			background-size: 100% 100%;
		}

	</style>	

	ENDTEXT
	
	Banner()	
	DEFINE FORM o ID 'movies'
	
	INIT FORM o  			

		DEFINE BROWSE oBrw ID 'ringo' HEIGHT 350  OF o

			ADD oCol TO oBrw ID 'nombre'   HEADER 'NOMBRE' 
			ADD oCol TO oBrw ID 'tamano'   HEADER 'GB' 
			ADD oCol TO oBrw ID 'duracion' HEADER 'DURACION' 
			ADD oCol TO oBrw ID 'reparto'  HEADER 'REPARTO' 
		INIT BROWSE oBrw DATA aRows	
		
	END FORM o	
	TEXT TO cfooter ECHO
	  <div class="container">
   	   <a href="https://adhemarcr.github.io/acrsoft/"> <img
		    src="https://acrsofts.github.io/moviecenter/images/lAcrSoft.jpg" align="left"> <br> Soluciones Informaticas</a>

        <div align="right"><a href="https://adhemarcr.github.io/acrsoft/"> <img
			src="https://acrsofts.github.io/moviecenter/images/hfw.jpg" align="right" width="80" height="80">
	  	   <h20><br>Powered By:<br>Adhemar Cuellar ©2020</h20>
		  </div>
	  </div>
	ENDTEXT
retu nil

function Banner()

	TEXT TO cHtml ECHO
	<div class="container">
		<div class="jumbotron">
			
		</div>
	
		<a href=todas.prg>
			<img src="images/todas.jpg" width="90"
			height="60"></a>
			&nbsp;&nbsp;
			<a href=AyS.prg>
				<img src="images/AyS.jpg" width="90"
				height="60"></a>
			<br>
			
			&nbsp;&nbsp;&nbsp;
			<a href=todas.prg>
			<button type="button" class="btn btn-sm btn-success">Todas</button></a>
			&nbsp;&nbsp;
			<a href=AyS.prg>
				<button type="button" class="btn btn-sm btn-success">Accion y Suspenso</button></a>

				<center><b><h5>TODAS</h5></b></center>
	</div>	
	ENDTEXT  
return 

INIT PROCEDURE PrgInit
	HB_LANGSELECT( 'ESWIN' )
    HB_SetCodePage("ESWIN");HB_CDPSELECT("ESWIN")
    rddSetDefault( "DBFCDX" )
    SET AUTOPEN ON
	SET EXACT ON
	SET OPTIMIZE ON
  	SET DELETED ON                   
  	SET EPOCH TO 1950                
  	SET CENTURY OFF
  	Set( _SET_SOFTSEEK, .T. )
Return
