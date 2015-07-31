<%@ page import="mx.gob.redoaxaca.InfoElem; mx.gob.redoaxaca.Eje; org.apache.commons.lang.StringUtils" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" name="publico">
    <title>Gubernatura del Estado - Indicadores</title>
</head>


<body class="container">
    <section class="  seccionSlider carousel slide" data-ride="carousel">
        <div class="container">
           <div id="da-slider" class="continer-fluid da-slider" style="width: 100% ">

                <g:each in="${InfoElem.list(sort: 'indice')}" var="infoElem">
                    <div class="da-slide">
                        <p>${infoElem.texto}</p>
                        <a href="${infoElem.href}"
                            <g:if test="${infoElem.abrirEnTab}">
                                target="_blank"
                            </g:if>
                            class="da-link btn btn-default">${infoElem.hrefLabel}</a>

                        <div class="da-img">
                            <ii:imageTag indirect-imagename="${infoElem.imgFileName}"/>
                        </div>
                    </div>
                </g:each>

                <nav class="da-arrows">
                    <span class="da-arrows-prev"></span>
                    <span class="da-arrows-next"></span>
                </nav>
            </div> 
        </div>
    </section>
<div class="row">
    <div class="container">
        <div id="MainMenu">
            <div class="list-group margentopaccordion">
                <g:each in="${ejesInfo}" var="info">
                    <g:if test="${info.eje.status == 1}">

                        <a href="#${Ascii.quitarAcentos(StringUtils.substringBefore(info.eje.nombre, ' ').toLowerCase())}"
                           class="list-group-item list-group-item-${Ascii.quitarAcentos(StringUtils.substringBefore(info.eje.nombre, ' ').toLowerCase())}" data-toggle="collapse"
                           data-parent="#MainMenu">

                            <i class="icon icon-${Ascii.quitarAcentos(StringUtils.substringBefore(info.eje.nombre, ' ').toLowerCase())}2"></i>${info.eje.nombre}
                            <div class="numindi pull-right">
                                <div class="numindicadores">${info.indicadores.size() < 10 ? '0' + info.indicadores.size() : info.indicadores.size()}</div>

                                <div class="txtindicadores">Número de <br>indicadores</div>
                            </div>
                        </a>

                        <div class="collapse" id="${Ascii.quitarAcentos(StringUtils.substringBefore(info.eje.nombre, ' ').toLowerCase())}">
                            <g:each in="${info.indicadores}" var="indicador">
                                <g:link controller="publico" action="mostrarIndicador" id="${indicador?.id}"
                                        class="list-group-item">
                                    ${indicador?.nombre}
                                </g:link>
                            </g:each>
                        </div>
                    </g:if>
                </g:each>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(function () {
            $('#da-slider').cslider({
                autoplay: true,
                bgincrement: 450,
                interval: ${segundos}
            });
        });
    </script>

</div>
</body>
</html>