<%@ page import="mx.gob.redoaxaca.Status; mx.gob.redoaxaca.Eje" %>
<form id="modalForm"  class="form-horizontal">
    <fieldset>
        <div class="form-group">
            <label for="prefijo" class="col-sm-2 control-label">Prefijo</label>

            <div class="col-sm-10">
                <input type="text" name="prefijo" id="prefijo" class="form-control"
                             required
                             data-fv-notempty-message="Requerido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="nombre" class="col-sm-2 control-label">Nombre</label>

            <div class="col-sm-10">
                <input type="text" name="nombre" id="nombre" class="form-control"
                       required
                       data-fv-notempty-message="Requerido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="descripcion" class="col-sm-2 control-label">Descripción</label>

            <div class="col-sm-10">
                <input type="text" name="descripcion" id="descripcion" class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label for="status" class="col-sm-2 control-label">Status</label>

            <div class="col-sm-10">
                <g:select class="form-control" id="status" name="status" from="${Status.list()}" optionKey="clave" optionValue="descripcion" required=""/>
            </div>
        </div>

        <input type="hidden" id="domain-id" name="id" value=""/>

    </fieldset>
</form>





