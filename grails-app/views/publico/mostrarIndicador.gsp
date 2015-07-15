<%@ page import="org.apache.commons.lang.StringUtils" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" name="publico">
    <title>Gubernatura del Estado - Indicadores</title>

    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">

    <asset:javascript src="raphael.2.1.0.min.js"/>
    <asset:javascript src="justgage.1.0.1.min.js"/>

</head>

<body>
<script>window.twttr = (function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0],
            t = window.twttr || {};
    if (d.getElementById(id)) return t;
    js = d.createElement(s);
    js.id = id;
    js.src = "https://platform.twitter.com/widgets.js";
    fjs.parentNode.insertBefore(js, fjs);

    t._e = [];
    t.ready = function (f) {
        t._e.push(f);
    };

    return t;
}(document, "script", "twitter-wjs"));</script>

<div id="fb-root"></div>
<script>(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s);
    js.id = id;
    js.src = "//connect.facebook.net/es_LA/sdk.js#xfbml=1&version=v2.3&appId=1024820874208179";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="container margentopaccordion ">
    <ol class="breadcrumb bread_${Ascii.quitarAcentos(StringUtils.substringBefore(indicadorInstance?.tema?.eje?.nombre, ' ')?.toLowerCase())}">
        <li>
            <g:link controller="publico" action="index">
                Inicio
            </g:link>
        </li>
        <li>
            <g:link controller="publico" action="mostrarEje" id="${indicadorInstance?.tema?.eje?.id}">
                ${indicadorInstance?.tema?.nombre}
            </g:link>
        </li>

        <div class="pull-right">
            <sec:ifLoggedIn>
                <g:link controller="adminPrincipal" id="${indicadorInstance?.tema?.eje?.id}">
                    volver a administrador
                </g:link>
            </sec:ifLoggedIn>
        </div>
    </ol>

    <export:formats formats="['csv', 'excel', 'pdf']" controller="publico" action="descargarIndicadoresEnFormatos" params="[id:indicadorInstance?.id]"/>

    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading heading_${StringUtils.substringBefore(indicadorInstance.tema.eje.nombre, ' ')}">
                    <div class="pull-right margensocial">
                        <div class="fb-like "
                             data-href="${createLink(controller: 'publico', absolute: true, action: 'mostrarIndicador', id: indicadorInstance?.id)}"
                             data-layout="button"
                             data-action="like"
                             data-show-faces="false"
                             data-share="true"
                             style="vertical-align:top;">
                        </div>
                        <a class="twitter-share-button"
                           href="https://twitter.com/share"
                           data-url="${createLink(controller: 'publico', absolute: true, action: 'mostrarIndicador', id: indicadorInstance?.id)}"
                           data-count-url="https://dev.twitter.com/web/tweet-button">
                            Tweet
                        </a>
                    </div>
                    <h4 class="panel-title">${indicadorInstance.toString()}</h4>

                    <div class="panel-title">

                    </div>

                </div>

                <div class="panel-body">
                    <div class="row">

                        <div class="col-md-12">
                            <div class="chart_wrapper">
                                <g:render template="grafica" model="${
                                    [indicadorInstance: indicadorInstance,
                                     categories       : categories,
                                     chartData        : chartData]
                                }"/>
                            </div>
                        </div>

                        %{--<div class="col-md-4">--}%
                        %{--<div id="tacometro"></div>--}%
                        %{--</div>--}%

                    </div>

                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th rowspan="2" class="col_center">Metodo de cálculo</th>
                            <th rowspan="2" class="col_center">Sentido esperado</th>
                            <th rowspan="2" class="col_center">Unidad de expresión</th>
                            <th colspan="${listaDeAnios.size()}" class="col_center">Año</th>
                        </tr>
                        <tr>
                            <g:each in="${listaDeAnios}" var="anio">
                                <th class="col_small col_center"><strong>${anio}</strong></th>
                            </g:each>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="col_center">${indicadorInstance?.metodoCalculo}</td>
                            <td class="col_center">${indicadorInstance?.sentido}</td>
                            <td class="col_center">${indicadorInstance?.unidadExpresion}</td>
                            <g:if test="${datos}">
                                <g:each in="${datos}" var="dato">
                                    <td class="col_center">
                                        <g:formatNumber number="${dato?.valor}" type="number" maxFractionDigits="2"/>

                                    </td>
                                </g:each>
                            </g:if>
                            <g:else>
                                <g:each in="${listaDeAnios}">
                                    <td class="col_center"></td>
                                </g:each>
                            </g:else>

                        </tr>
                        </tbody>
                    </table>

                    <p>${indicadorInstance?.descripcion}</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>