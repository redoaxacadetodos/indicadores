<%@ page import="mx.gob.redoaxaca.Eje" %>
<form id="modalForm" class="form-horizontal">
    <fieldset>
        <div class="form-group">
            <label for="nombre" class="col-sm-2 control-label">Nombre</label>

            <div class="col-sm-10">
                <input type="text" id="nombre" name="nombre" class="form-control"
                       required
                       data-fv-notempty-message="Requerido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="descripcion" class="col-sm-2 control-label">Descripción</label>

            <div class="col-sm-10">
                <input type="text" id="descripcion" name="descripcion" class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label for="descripcion" class="col-sm-2 control-label">Eje</label>

            <div class="col-sm-10">
                <g:select id="eje" name="eje" from="${Eje.list()}" optionKey="id" required="" class="many-to-one form-control"/>
            </div>
        </div>

        <input type="hidden" id="domain-id" name="id" value=""/>
    </fieldset>
</form>






