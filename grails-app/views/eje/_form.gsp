<%@ page import="mx.gob.redoaxaca.Status; mx.gob.redoaxaca.Eje" %>
<form id="modalForm"  class="form-horizontal">
    <fieldset>
        <div class="form-group">
            <div class="row">
                <label for="prefijo" class="col-sm-2 col-lg-2 col-md-12 col-xs-12 control-label">Prefijo</label>

                <div class="col-lg-10 col-md-10 col-xs-10 col-sm-10">
                    <input type="text" name="prefijo" id="prefijo" class="form-control"
                                 required
                                 data-fv-notempty-message="Requerido"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="nombre" class="col-lg-2 col-md-12 col-sm-2 col-xs-2 control-label">Nombre</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <input type="text" name="nombre" id="nombre" class="form-control"
                           required
                           data-fv-notempty-message="Requerido"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="descripcion" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Descripción</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <input type="text" name="descripcion" id="descripcion" class="form-control"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="status" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Status</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <g:select class="form-control" id="status" name="status" from="${Status.list()}" optionKey="clave" optionValue="descripcion" required=""/>
                </div>
            </div>
        </div>

        <input type="hidden" id="domain-id" name="id" value=""/>

    </fieldset>
</form>





