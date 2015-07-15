<%@ page import="mx.gob.redoaxaca.Tema" %>
<script>
    $(document).ready(function () {
        function populateForm(data) {
            $('#nombre').val(data.nombre);
            $('#tituloGrafica').val(data.tituloGrafica);
            $('#metodoCalculo').val(data.metodoCalculo);
            $('#unidadMedida').val(data.unidadMedida);
            $('#sentido').val(data.sentido);
            $('#unidadExpresion').val(data.unidadExpresion);
            $('#fuente').val(data.fuente);
            $('#descripcion').val(data.descripcion);
//            $('#valorDelTacometro').val(data.valorDelTacometro);
            $('#tema').find('option[value="' + data.tema.id + '"]').prop('selected', 'selected');
        }

        TABLE_CRUD.init({
            table: '#tabla',
            $modalForm: $('#modalForm'),
            $modal: $('#modal'),
            columnDefs : [
                {
                    "targets": 0, "title": "", "data": "id",
                    "render": function (data, type, full, meta) {
                        return "<button type='button' class='btn btn-info' onclick='redirectToController(" + data + ")'>Ver</button>";
                    }
                },
                {"targets": 1, "title": "Nombre", "data": "nombre"},
                {"targets": 2, "title": "Fuente", "data": "fuente"},
                {"targets": 3, "title": "Tema", "data": "tema"}
//                {"targets": 5, "title": "Tacómetro", "data": "valorDelTacometro"}
            ],

            serverSideUrl : '${createLink(controller: 'indicador', action: 'indicadoresJSONData')}',
            formModalTemplateUrl : '${createLink(controller: 'indicador', action: 'fetchTemplate', params: [templateName : 'form'])}',
            domainDataUrl : '${createLink(controller: 'indicador', action: 'indicadorData')}',
            updateUrl : '${createLink(controller: 'indicador', action: 'update')}',
            saveUrl : '${createLink(controller: 'indicador', action: 'save')}',
            deleteUrl : '${createLink(controller: 'indicador', action: 'delete')}',
            populateFormCallback : populateForm
        });
    });

    function redirectToController(id) {
        window.location.href = CONTEXT_ROOT + '/publico/mostrarIndicador/' + id;
    }

</script>

<div id="ejesMainContent">
    <h1 class="page-header">Indicadores</h1>

    <div class="row">
        <div class="col-lg-12">
            <div id="list-indicadores" class="content scaffold-list" role="main">
                <button type="button" class="btn btn-primary" id="crear-button" data-target="#modal" data-toggle="modal">Nuevo</button>
                <br/>
                <br/>

                <div class="table-responsive">
                    <table id="tabla" class="table table-striped table-bordered table-hover fondoblanco" cellspacing="0" width="100%"></table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalTitle"></h4>
            </div>
            <div class="modal-body">
                <g:render template="/indicador/form"/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="close-button" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="save-button">Guardar</button>
            </div>
        </div>
    </div>
</div>