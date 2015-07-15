<asset:javascript src="highcharts.js"/>

<script>
    $(document).ready(function () {
        $('#grafica').highcharts({
            title: {
                text: '',
                x: -20 //center
            },
            subtitle: {
                text: 'Fuente: ${Ascii.quitarAcentos(indicadorInstance?.fuente)}',
                x: -20
            },
            yAxis: {
                title: {
                    text: '${Ascii.quitarAcentos(indicadorInstance?.unidadMedida)}'
                },
                <g:if test="${indicadorInstance?.sentido == 'Descendente'}">
                reversed: true
                </g:if>
                <g:else>
                reversed: false
                </g:else>
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: true
                }
            },
            legend: {
//                layout: 'vertical',
//                align: 'right',
//                verticalAlign: 'middle',
//                borderWidth: 0,
//                floating : true,
                enabled: false
            },
//            tooltip: {
//                valueSuffix: '°C'
//            },
            xAxis: {
                //categories: [2010, 2011, 2012, 2013]
                categories: ${categories}
            },
            series: [{
                name: '${Ascii.quitarAcentos(indicadorInstance?.tituloGrafica)}',
                //data: [0, 6000, 9500, 13548]
                data: ${chartData}
            }]
        });
    });
</script>

<div id="grafica"></div>

