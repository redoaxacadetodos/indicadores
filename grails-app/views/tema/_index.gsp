<script>
    $(document).ready(function () {
        function populateForm(data) {
            $('#nombre').val(data.nombre);
            $('#descripcion').val(data.descripcion);
            $('#eje').find('option[value="' + data.eje.id + '"]').prop('selected', 'selected');
        }

        TABLE_CRUD.init({
            table: '#tabla',
            $modalForm: $('#modalForm'),
            $modal: $('#modal'),
            columnDefs : [
                {"targets": 0, "title": "Id", "data": "id", "visible": true},
                {"targets": 1, "title": "Nombre", "data": "nombre"},
                {"targets": 2, "title": "Eje", "data": "eje"},
                {"targets": 3, "title": "Descripcion", "data": "descripcion", "orderable": false}],

            serverSideUrl : '${createLink(controller: 'tema', action: 'temasJSONData')}',
            formModalTemplateUrl : '${createLink(controller: 'tema', action: 'fetchTemplate', params: [templateName : 'form'])}',
            domainDataUrl : '${createLink(controller: 'tema', action: 'temaData')}',
            updateUrl : '${createLink(controller: 'tema', action: 'update')}',
            saveUrl : '${createLink(controller: 'tema', action: 'save')}',
            deleteUrl : '${createLink(controller: 'tema', action: 'delete')}',
            populateFormCallback : populateForm
        });
    });
</script>

<div id="temasMainContent">
    <h1 class="page-header">Temas</h1>

    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="list-temas" class="content scaffold-list" role="main">
                <button type="button" class="btn btn-primary" id="crear-button" data-target="#modal" data-toggle="modal">Nuevo</button>
                <br/>
                <br/>

                <div class="table-responsive">
                    <table id="tabla" class="table table-striped table-bordered table-hover fondoblanco" cellspacing="0" width="100%">
                    </table>
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
                <g:render template="/tema/form"/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="close-button" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="save-button">Guardar</button>
            </div>
        </div>
    </div>
</div>
