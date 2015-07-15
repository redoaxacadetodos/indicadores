var TABLE_CRUD = (function ($) {

    var _columnDefs,
        _$table,
        _$dataTable,
        $modalForm,
        $modal,
        _$editarFormBootstrap,
        _config = {},
        _populateFormCallback,
        _withButtons,
        _validationOptions,
        _enEditar = false,
        _id;

    function _setDataTablesColumnDefs(columnDefs) {
        _columnDefs = columnDefs;
        if (_withButtons.edit) {
            _addButton('editarModal-button', 'btn btn-info', 'Editar', 'id');
        }

        if (_withButtons.remove) {
            _addButton('eliminarModal-button', 'btn btn-danger', 'Eliminar', 'id');
        }
    }

    function _addButton(id, className, text, dataThatHolds) {
        var size = _columnDefs.length;

        _columnDefs.push(
            {
                "targets": size, "title": "", "data": dataThatHolds, "orderable": false,
                "render": function () {
                    var $button = $('<button>', {
                        'type': 'button',
                        'class': className,
                        'id': id,
                        'text': text
                    });
                    return $button[0].outerHTML;
                }
            }
        );
    }

    function _createEventHandler() {
        $('#save-button').on('click', function () {
            _$editarFormBootstrap.validate();

            if (_$editarFormBootstrap.isValid()) {
                if (_enEditar) {
                    _update().then(function () {
                        $modal.modal('hide');
                        _$dataTable.ajax.reload(false);
                    });
                }
                else {
                    _create().then(function () {
                        $modal.modal('hide');
                        _$dataTable.ajax.reload(false);
                    });

                }
            }
        });

    }

    function getTemplate() {
        return $.ajax({
            type: 'GET',
            url: _config.formModalTemplateUrl
        });
    }

    function _onHideEventHandler() {
        $modal.on('hide.bs.modal', function () {
            _$editarFormBootstrap.resetForm(true);
            $modalForm[0].reset();
            $('#imagen').fileinput('clear');
            _enEditar = false;
        })
    }

    function _onShownEventHandler() {
        var $modalTile;
        $modal.on('show.bs.modal', function () {
            $modalForm.formValidation(_validationOptions);
            _$editarFormBootstrap = $modalForm.data('formValidation');

            $modalTile = $('#myModalTitle');
            $modalTile.text('Nuevo');

            if (_enEditar) {
                $modalTile.text('Editar');
                $('#domain-id').val(_id);
                _getDomainData(_id).then(function (data) {
                    _populateFormCallback(data);
                    _$editarFormBootstrap.validate();

                });
            }
        })
    }

    function _addEditEventHandler() {
        _$dataTable.on('click', '#editarModal-button', function () {
            _id = _$dataTable.row(this.parentElement.parentElement).data().id;
            _enEditar = true;
            $modal.modal('show');
        });

    }

    function _addDeleteEventHandler() {
        _$dataTable.on('click', '#eliminarModal-button', function () {
            var id = _$dataTable.row(this.parentElement.parentElement).data().id;

            BootstrapDialog.confirm({
                title: 'Eliminar',
                message: '¿Seguro que desea eliminar?',
                closable: true,
                btnCancelLabel: 'Cancelar',
                btnOKLabel: 'OK',
                btnOKClass: 'btn-warning',
                callback: function (result) {
                    if (result) {
                        _eliminar(id).then(function () {
                            _$dataTable.ajax.reload(false);
                        });
                    }
                }
            });
        });
    }

    function _getDomainData(id) {
        return $.ajax({
            type: 'POST',
            data: {id: id},
            url: _config.domainDataUrl
        });
    }

    function _create() {
        var formData = new FormData(document.getElementById('modalForm'));
        return $.ajax({
            type: 'POST',
            processData: false,
            contentType: false,
            data: formData,
            url: _config.saveUrl
        });
    }

    function _eliminar(id) {
        return $.ajax({
            type: 'POST',
            data: {id: id},
            url: _config.deleteUrl,
            statusCode: {
                204: function () {
                    toastr.success('Eliminado');
                }
            }
        });
    }

    function _update() {
        var formData = new FormData(document.getElementById('modalForm'));

        return $.ajax({
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            url: _config.updateUrl
        });

    }

    function init(config) {
        _config = config;

        _$table = $(_config.table);
        $modalForm = _config.$modalForm;
        $modal = _config.$modal;
        _populateFormCallback = config.populateFormCallback;
        _validationOptions = _config.validationOptions || {};
        _withButtons = _config.withButtons || {
                edit: true,
                remove: true
            };
        _setDataTablesColumnDefs(_config.columnDefs);

        _$dataTable = _$table.DataTable({
            "ajax": _config.serverSideUrl,
            "columnDefs": _columnDefs
        });
        if (_withButtons.edit) {
            _addEditEventHandler();
        }

        if (_withButtons.remove) {
            _addDeleteEventHandler();
        }

        _onShownEventHandler();
        _onHideEventHandler();
        _createEventHandler();
    }

    return {
        init: init
    }
})(jQuery);
