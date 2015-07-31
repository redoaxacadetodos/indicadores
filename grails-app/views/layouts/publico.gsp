<%@ page import="org.apache.commons.lang.StringUtils; mx.gob.redoaxaca.Eje" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gubernatura</title>
    <asset:stylesheet src="publico.css"/>
    <asset:javascript src="publico.js"/>

    <!--<link rel="stylesheet" href="${resource(dir: 'css', file: 'tabstyles.css')}"/>-->

    <g:layoutHead/>

    <script type="text/javascript">
        var CONTEXT_ROOT = '${request.getContextPath()}';
    </script>

    <style>
    a:hover {
        text-decoration:none;
        /*color:pink;*/
    }
    </style>
</head>

<body>
<div>
    <div class="plecatop">
        <div class="menuinicio">
            <a href="#">Inicio</a>
        </div>
    </div>
    <div class="cabecera">
        <img src="${resource(dir: 'images', file: 'cabecera.jpg')}" class="img-responsive">
        %{--<div class="container">--}%
            %{--<g:link controller="login">--}%
                %{--<button type="button" class="btn btn-warning pull-right" id="crear-button">Administrador</button>--}%
            %{--</g:link>--}%
        %{--</div>--}%
    </div>

    <section>
        <div class=" tabs-conbox">
            <nav class="container navbar navbar-default">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".berg-collapse" >
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>

                    </div>
                    <div class="collapse navbar-collapse berg-collapse">
                        <ul class="nav navbar-nav ">
                            <li><g:link controller="publico" class="icon"><div class="icon-home"></div> <p class="inicio">Inicio</p> </g:link></li>
                            <g:each in="${Eje.list(sort: 'indice')}" var="eje">
                                <g:if test="${eje.status == 1}">
                                    <li class="item-${Ascii.quitarAcentos(StringUtils.substringBefore(eje.nombre, ' ').toLowerCase())}">
                                        <g:link

                                                controller="publico"
                                                action="mostrarEje"
                                                id="${eje.id}">
                                            <div class="icon icon-${Ascii.quitarAcentos(StringUtils.substringBefore(eje.nombre, ' ').toLowerCase())}">

                                            </div>${(eje.nombre)}

                                        </g:link>
                                    </li>
                                </g:if>
                            </g:each>
                         </ul>
                    </div>
                </div>
            </nav>
        </div>
    </section>

    <g:layoutBody/>

    <div class="bgfooter">
        <div class="container">
            <div class="container-fluid">
              <div class="row">
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="pieSecretaria">
                        <asset:image src="escudo.png" alt="Secretaría Técnica del Titular del Poder Ejecutivo" align="left"/><span>Secretar&iacute;a T&eacute;cnica del Titular del Poder Ejecutivo</span><br>
                        Palacio de Gobierno (Planta Alta), Plaza de la Constituci&oacute;n, Centro Hist&oacute;rico, Oaxaca de Ju&aacute;rez, Oaxaca C.P. 68000
                    </div>
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><asset:image src="poweredbyred.png" alt="Red Oaxaca de todos" align="right"/></div>
              </div>
            </div>
        </div>
        
        
    </div>
</div>
</body>
</html>

