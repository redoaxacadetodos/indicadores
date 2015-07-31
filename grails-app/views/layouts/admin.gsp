<!DOCTYPE html>
<html>
<head>
    <title>Administrador</title>

    <asset:javascript src="administrador.js"/>
    <asset:stylesheet src="administrador.css"/>

    <g:layoutHead/>

    <script type="text/javascript">
        var CONTEXT_ROOT = '${request.getContextPath()}';

        var UTILS = {};

        UTILS.renderTemplateFromController = function (controllerName) {
            $.ajax({
                type: 'POST',
                url: CONTEXT_ROOT + '/' + controllerName + '/index',
                success: function (data) {
                    $('#layoutBody').html(data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        };

        $.ajaxSetup({
            statusCode: {
                401: function () {
                    window.location.href = CONTEXT_ROOT + '/logout';
                    toastr.warning('Se ha terminado la sesion, ingresa tu login y password');
                },
                422: function () {
                    toastr.error('El elemento no se pudo guardar, datos incorrectos');
                },
                404: function () {
                    toastr.error('No se encontro el elemento en la base de datos');
                },
                201: function () {
                    toastr.success('Elemento creado');
                },
                204: function () {
                    toastr.success('Operacion realizada con éxito');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
//                toastr.error('Ha ocurrido un error en el servidor');
                console.log(errorThrown);
            },
            beforeSend: function() {
                $('#spinner').show();
            },
            complete: function(){
                $('#spinner').hide();
            }
        });

        $.extend($.fn.dataTable.defaults, {
            "processing": true,
            "serverSide": true,
            "lengthChange": true,
            "ordering": true,
            "language": {
                "url": "${resource(dir: 'js', file: 'dataTables.spanish.txt')}"
            }
        });

        $(document).ready(function () {
            $('#ejesLink').on('click', function () {
                UTILS.renderTemplateFromController('eje');
            });

            $('#temasLink').on('click', function () {
                UTILS.renderTemplateFromController('tema');
            });

            $('#indicadoresLink').on('click', function () {
                UTILS.renderTemplateFromController('indicador');
            });

            $('#datosLink').on('click', function () {
                UTILS.renderTemplateFromController('dato');
            });

            $('#infoElemLink').on('click', function () {
                UTILS.renderTemplateFromController('infoElem');
            });

            $('#cambiarPassLink').on('click', function () {
                UTILS.renderTemplateFromController('password');
            });
        });
    </script>
</head>

<body>
<!-- Header -->
<div id="top-nav top_header" class="navbar-inverse navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <asset:image src="logo_main2.png"/>
        </div>

        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><g:link controller="logout" action="index"><i class="glyphicon glyphicon-lock"></i> Salir</g:link></li>
            </ul>
        </div>
    </div>
</div>

<nav id="top_navigation">
    <div class="container row">

        <div class="col-lg-2 col-sm-2 col-md-2 col-xs-2">
            <!-- Left column -->
            <ul class="nav nav-pills nav-stacked">
                <li class="nav-header"></li>
                <li id="ejesLink"><a href="#"><i class="glyphicon glyphicon-briefcase"></i> Ejes</a></li>
                <li id="temasLink"><a href="#"><i class="glyphicon glyphicon-list"></i> Temas</a></li>
                <li id="indicadoresLink"><a href="#"><i class="glyphicon glyphicon-list-alt"></i> Indicadores</a></li>
                <li id="datosLink"><a href="#"><i class="glyphicon glyphicon-book"></i> Datos</a></li>

            <hr>
                <li id="infoElemLink"><a href="#"><i class="glyphicon glyphicon-blackboard"></i> Texto en Slider</a></li>
                <li id="cambiarPassLink"><a href="#"><i class="glyphicon glyphicon-lock"></i> Usuario</a></li>
            </ul>
        </div>

        <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
            <div id="layoutBody">

                <g:layoutBody/>
            </div>
        </div>
    </div>
</nav>

<footer id="footer">
    <div class="container">
        <div class="container-fluid">
            <asset:image src="poweredbyred.png"/>
        </div>
    </div>
</footer>
<!-- /Main -->
</body>
</html>

