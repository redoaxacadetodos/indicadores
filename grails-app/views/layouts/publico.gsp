<%@ page import="org.apache.commons.lang.StringUtils; mx.gob.redoaxaca.Eje" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gubernatura</title>
    <asset:stylesheet src="publico.css"/>
    <asset:javascript src="publico.js"/>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'tabstyles.css')}"/>

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
        %{--<div class="container">--}%
            %{--<g:link controller="login">--}%
                %{--<button type="button" class="btn btn-warning pull-right" id="crear-button">Administrador</button>--}%
            %{--</g:link>--}%
        %{--</div>--}%
    </div>
    <section>
        <div class="tabs tabs-style-iconbox">
            <nav>
                <ul>
                    <li><g:link controller="publico" class="icon"><div class="icon-home"></div> Inicio </g:link></li>
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
            </nav>
        </div>
    </section>

    <g:layoutBody/>

    <div class="bgfooter">
        <div class="container">
          <div class="row">
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <div class="pieSecretaria">
                    <asset:image src="escudo.png" alt="Secretaría Técnica del Titular del Poder Ejecutivo" align="left"/><span>Secretaría Técnica del Titular del Poder Ejecutivo</span><br>
                    Palacio de Gobierno (Planta Alta), Plaza de la Constitución, Centro Histórico, Oaxaca de Juárez, Oaxaca C.P. 68000
                </div>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><asset:image src="poweredbyred.png" alt="Red Oaxaca de todos" align="right"/></div>
          </div>  
        </div>
        
        
    </div>
</div>
</body>
</html>

