<script>
    $(document).ready(function () {
        var $passwordChangeForm = $('#password-change-form');
        $passwordChangeForm.formValidation({
            live: 'disabled',
            fields: {
                username: {
                    validators: {
                        notEmpty: {
                            message: 'Requerido'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: 'Requerido'
                        },
                        remote: {
                            url: '${createLink(controller: 'password', action: 'validatePassword')}',
                            type: 'POST',
                            message: 'La contraseña actual es incorrecta'
                        }
                    }
                },
                password_new: {
                    validators: {
                        notEmpty: {
                            message: 'Requerido'
                        }
                    }
                },
                password_new_2: {
                    validators: {
                        notEmpty: {
                            message: 'Requerido'
                        },
                        callback: {
                            message: 'Las contraseñas no concuerdan',
                            callback: function (value) {
                                var pass = $('#password_new').val();
                                return value == pass;
                            }
                        }
                    }
                }
            }
        }).on('success.form.fv', function(e) {
            // Prevent form submission
            e.preventDefault();

            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'password', action: 'updatePassword')}',
                data: {
                    newPassword: $('#password_new').val(),
                    newUsername: $('#username').val()
                },
                statusCode: {
                    204: function () {
                        toastr.success('Contraseña actualizada');
                        document.location.reload(true);
                    }
                }
            });
        });
    });

</script>

<hr/>

<form id="password-change-form" class="form-horizontal">

    <div class="form-group">
        <label for="username" class="col-sm-3 control-label">Nuevo nombre de usuario</label>

        <div class="col-sm-8">
            <input type="text" class="form-control" id="username" name="username" placeholder="Requerido">
        </div>
    </div>

    <hr/>

    <div class="form-group">
        <label for="password" class="col-sm-offset-1 col-sm-2 control-label">Contraseña actual</label>

        <div class="col-sm-8">
            <input type="password" class="form-control" id="password" name="password" placeholder="Requerido">
        </div>
    </div>

    <div class="form-group">
        <label for="password_new" class="col-sm-offset-1 col-sm-2 control-label">Nueva contraseña</label>

        <div class="col-sm-8">
            <input type="password" class="form-control" id="password_new" name="password_new" placeholder="Requerido">
        </div>
    </div>

    <div class="form-group">
        <label for="password_new_2" class="col-sm-3 control-label">Repite la nueva contraseña</label>

        <div class="col-sm-8">
            <input type="password" class="form-control" id="password_new_2" name="password_new_2" placeholder="Requerido">
        </div>
    </div>


    <div class="form-group">
        <div class="col-sm-offset-3 col-sm-10">
            <button type="submit" class="btn btn-primary" id="cambiar-pass-button">Actualizar</button>
        </div>
    </div>
</form>
