<script>
    $(document).ready(function () {

        function populateForm(data) {
            $('#anio').val(data.anio);
            $('#valor').val(data.valor);
            $('#indicador').find('option[value="' + data.indicador.id + '"]').prop('selected', 'selected');
        }

        var bootstrapValidationOptions = {
            fields: {
                anio: {
                    validators: {
                        remote: {
                            message: 'Ese año ya esta capturado',
                            url: '${createLink(controller: 'dato', action: 'validarAnio')}',
                            data: function () {
                                return {
                                    indicadorId: $('#indicador').val()
                                };
                            },
                            type: 'POST'
                        }
                    }
                }
            }
        };

        TABLE_CRUD.init({
            table: '#tabla',
            $modalForm: $('#modalForm'),
            $modal: $('#modal'),
            columnDefs: [
                {"targets": 0, "title": "Año", "data": "anio"},
                {"targets": 1, "title": "Valor", "data": "valor"},
                {"targets": 2, "title": "Indicador", "data": "indicador"}
            ],

            serverSideUrl: '${createLink(controller: 'dato', action: 'datosJSONData')}',
            formModalTemplateUrl: '${createLink(controller: 'dato', action: 'fetchTemplate', params: [templateName : 'form'])}',
            domainDataUrl: '${createLink(controller: 'dato', action: 'datoData')}',
            updateUrl: '${createLink(controller: 'dato', action: 'update')}',
            saveUrl: '${createLink(controller: 'dato', action: 'save')}',
            deleteUrl: '${createLink(controller: 'dato', action: 'delete')}',
            validationOptions: bootstrapValidationOptions,
            withButtons: {
                edit: false,
                remove: true
            },
            populateFormCallback: populateForm
        });
    });
</script>

<div id="datosMainContent">
    <h1 class="page-header">Datos</h1>

    <div class="row">
        <div class="container-fluid">
            <div id="list-datos" class=" scaffold-list" role="main">
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
                <g:render template="/dato/form"/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="close-button" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="save-button">Guardar</button>
            </div>
        </div>
    </div>
</div>
