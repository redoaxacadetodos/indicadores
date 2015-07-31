<script>
    function getSegundosEntreImagenes() {
        $.ajax({
            type: 'GET',
            url: '${createLink(controller: 'infoElem', action: 'segundosEntreImagenes')}',
            success: function (data) {
                $('#segundos').val(data.segundos);
            }
        })
    }

    %{--function setSegundosEntreImagenes() {--}%
        %{--$.ajax({--}%
            %{--type: 'POST',--}%
            %{--url: '${createLink(controller: 'infoElem', action: 'updateSecondDelayInSlider')}',--}%
            %{--statusCode: {--}%
                %{--204: function () {--}%
                    %{--toastr.success('Actualizado');--}%
                %{--}--}%
            %{--}--}%
        %{--})--}%
    %{--}--}%

    $(document).ready(function () {
        getSegundosEntreImagenes();

        function populateForm(data) {
            var fvForm = $('#modalForm').data('formValidation');

            $('#href').val(data['href']);
            $('#texto').val(data.texto);
            $('#hrefLabel').val(data.hrefLabel);
            $('#indice').val(data.indice);
            $('#abrirEnTab').val(data.abrirEnTab ? $('#abrirEnTab').prop('checked', true) : $('#abrirEnTab').prop('checked', false));
            $('#imagen').fileinput('refresh', {
                previewFileType: "image",
                browseClass: "btn btn-success",
                browseLabel: " Seleccionar",
                browseIcon: '<i class="glyphicon glyphicon-picture"></i>',
                removeIcon: '<i class="glyphicon glyphicon-trash"></i>',
                showUpload: false,
                showRemove: false,
                overeriteInitial: true,
                initialCaption: data.imgFileName,
                initialPreview: '<img width="200" height="200" src="' + CONTEXT_ROOT + '/imageIndirect/index?imageName=' + data.imgFileName + '&category=" class"file-preview-image"/>'
            }).on('fileclear', function () {
                fvForm.enableFieldValidators('imagen', true);
            }).on('fileloaded', function (event, file, previewId, index, reader) {
                fvForm.enableFieldValidators('imagen', false);
            });

            fvForm.enableFieldValidators('imagen', false);
        }

        var bootstrapValidationOptions = {
            fields: {
                indice: {
                    validators: {
                        remote: {
                            message: 'Ya existe un elemento con ese indice',
                            url: '${createLink(controller: 'infoElem', action: 'validarIndice')}',
                            data: function () {
                                return {
                                    indice: $('#indice').val(),
                                    id: $('#domain-id').val()
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
                {"targets": 0, "title": "Texto", "data": "texto"},
                {"targets": 1, "title": "Indice (orden)", "data": "indice"},
                {
                    "targets": 2, "title": "Imagen", "data": "imgFileName",
                    "render": function (data, type, full, meta) {
                        return '<img width="200" height="200" src="' + CONTEXT_ROOT + '/imageIndirect/index?imageName=' + data + '&category="/>';
                    }
                }
            ],
            serverSideUrl: '${createLink(controller: 'infoElem', action: 'infoElemJSONData')}',
            formModalTemplateUrl: '${createLink(controller: 'infoElem', action: 'fetchTemplate', params: [templateName : 'form'])}',
            domainDataUrl: '${createLink(controller: 'infoElem', action: 'infoElemData')}',
            updateUrl: '${createLink(controller: 'infoElem', action: 'update')}',
            saveUrl: '${createLink(controller: 'infoElem', action: 'save')}',
            deleteUrl: '${createLink(controller: 'infoElem', action: 'delete')}',
            validationOptions: bootstrapValidationOptions,
            populateFormCallback: populateForm
        });

        $('#segundos-form').formValidation();

        $('#segundos-button').on('click', function () {
            $.ajax({
                type: 'POST',
                data: {seconds: $('#segundos').val()},
                url: '${createLink(controller: 'infoElem', action: 'updateSecondDelayInSlider')}',
                statusCode: {
                    204: function () {
                        toastr.success('Actualizado');
                    }
                }
            })
        });


        $('#imagen').fileinput({
            previewFileType: "image",
            browseClass: "btn btn-success",
            browseLabel: " Seleccionar",
            browseIcon: '<i class="glyphicon glyphicon-picture"></i>',
            removeClass: "btn btn-danger",
            removeLabel: " Quitar",
            removeIcon: '<i class="glyphicon glyphicon-trash"></i>',
            showUpload: false
        }).on('fileclear', function () {
            var fvForm = $('#modalForm').data('formValidation');
            fvForm.enableFieldValidators('imagen', true);
        }).on('fileloaded', function (event, file, previewId, index, reader) {
            var fvForm = $('#modalForm').data('formValidation');
            fvForm.enableFieldValidators('imagen', false);
        });
    });
</script>

<div id="infoElemMainContent">
    <h1 class="page-header">Slider</h1>

    %{--<ii:imageTag indirect-imagename="Color de fondo para leer Adobe Reader.png"/>--}%

    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="list-infoElem" class="content scaffold-list" role="main">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                        <button type="button" class="btn btn-primary" id="crear-button" data-target="#modal" data-toggle="modal">Nuevo</button>
                    </div>

                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
                        <div class="form-group">
                            <form id="segundos-form">
                                <label for="segundos" class="col-lg-4 col-md-4 col-sm-4 col-xs-4 control-label">Segundos entre imágenes</label>

                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                    <input id="segundos" type="number" min="1" class="form-control"
                                           name="segundos"
                                           required
                                           data-fv-greaterthan-message="Debe ser mayor a 0"
                                           data-fv-notempty-message="Requerido"
                                           data-fv-integer-message="Tiene que ser un numero entero"
                                           data-fv-digits-message="Solo numeros"/>
                                </div>

                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                    <button type="button" class="btn btn-primary" id="segundos-button">Guardar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
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
                <g:render template="/infoElem/form"/>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="close-button" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="save-button">Guardar</button>
            </div>
        </div>
    </div>
</div>