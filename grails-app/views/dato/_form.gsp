<%@ page import="mx.gob.redoaxaca.Indicador; mx.gob.redoaxaca.Dato" %>

<form id="modalForm" class="form-horizontal">
    <fieldset>
        <div class="form-group">
            <label for="anio" class="col-lg-3 control-label">Año</label>

            <div class="col-lg-6">
                <input id="anio" type="number" min="2010" max="2030" class="form-control"
                       name="anio"
                       required
                       data-fv-greaterthan-message="Debe ser mayor a 2010"
                       data-fv-lessthan-message="Debe ser menor a 2030"
                       data-fv-notempty-message="Requerido"
                       data-fv-integer-message="Tiene que ser un numero entero"
                       data-fv-digits-message="Solo numeros"/>
            </div>
        </div>

        <div class="form-group">
            <label for="valor" class="col-lg-3 control-label">Valor</label>

            <div class="col-lg-6">
                <input id="valor" type="number" step="0.1" class="form-control" name="valor"
                       required
                       data-fv-notempty-message="Requerido"
                       data-fv-numeric-message="Tiene que ser un numero valido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="indicador" class="col-lg-3 control-label">Indicador</label>

            <div class="col-lg-6">
                <g:select id="indicador" name="indicador.id" from="${Indicador.list()}" optionKey="id" required="" class="many-to-one form-control"/>
            </div>
        </div>

        %{--<div class="form-group">--}%
        %{--<label for="tema" class="col-lg-3 control-label">Tema</label>--}%

        %{--<div class="col-lg-6">--}%
        %{--<p id="tema" class="form-control">${datoTempInstance?.indicador?.id}</p>--}%
        %{--</div>--}%
        %{--</div>--}%

    </fieldset>

</form>



