<%@ page import="mx.gob.redoaxaca.Status" %>
<script>
    $(document).ready(function () {
        function populateForm(data) {
            $('#prefijo').val(data.prefijo);
            $('#nombre').val(data.nombre);
            $('#descripcion').val(data.descripcion);

            $('#status').find('option[value="' + data.status + '"]').prop('selected', 'selected');
        }

        TABLE_CRUD.init({
            table: '#tabla',
            $modalForm: $('#modalForm'),
            $modal: $('#modal'),
            columnDefs: [
                {"targets": 0, "title": "Nombre", "data": "nombre"},
                {"targets": 1, "title": "Descripcion", "data": "descripcion"}
            ],

            serverSideUrl: '${createLink(controller: 'eje', action: 'ejeJSONData')}',
            formModalTemplateUrl: '${createLink(controller: 'eje', action: 'fetchTemplate', params: [templateName : 'form'])}',
            domainDataUrl: '${createLink(controller: 'eje', action: 'ejeData')}',
            updateUrl: '${createLink(controller: 'eje', action: 'update')}',
            saveUrl: '${createLink(controller: 'eje', action: 'save')}',
            deleteUrl: '${createLink(controller: 'eje', action: 'delete')}',
            populateFormCallback: populateForm
        });
    });
</script>

<div id="ejesMainContent">
    <h1 class="page-header">Ejes</h1>

    <div class="row">
        <div class="container-fluid">
            <div id="list-ejes" class="content scaffold-list" role="main">
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
                <g:render template="/eje/form"/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="close-button" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="save-button">Guardar</button>
            </div>
        </div>
    </div>
</div>