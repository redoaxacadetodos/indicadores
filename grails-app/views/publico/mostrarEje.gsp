<%@ page import="org.apache.commons.lang.StringUtils" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" name="publico">
    <title>Gubernatura del Estado - Indicadores</title>
</head>

<body>
<div class="container margentopaccordion">
    <ol class="breadcrumb bread_${Ascii.quitarAcentos(StringUtils.substringBefore(eje.nombre, ' ').toLowerCase())}">
        <li>
            <g:link controller="publico" action="index">
                Inicio
            </g:link>
        </li>
        <li class="active">${eje?.nombre}</li>
    </ol>

    <div class="row">
        <div id="freewall">
            <div class="col-md-12">
                <div class="row masonry-grid">
                    <g:each in="${temas}" var="tema">
                        <div class="col-xs-12 col-sm-4 col-md-4 column">
                            <div class="boxcaja1">
                                <h4>${tema?.nombre}</h4>
                                <ul class="list-group">
                                    <g:each in="${tema?.indicadores?.sort { it.nombre }}" var="indicador">

                                        <li class="list-group-item">
                                            <g:link controller="publico" action="mostrarIndicador" id="${indicador.id}">
                                                ${indicador?.nombre}
                                            </g:link>
                                        </li>
                                    </g:each>
                                </ul>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$('.masonry-grid').masonry({
    // options
    itemSelector: '.column'
});
</script>
</body>
</html>