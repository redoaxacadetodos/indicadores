<%@ page import="mx.gob.redoaxaca.Tema; mx.gob.redoaxaca.Eje" %>
<form id="modalForm" class="form-horizontal">
    <fieldset>
        <div class="form-group">
            <label for="nombre" class="col-sm-2 control-label">Nombre</label>

            <div class="col-sm-10">
                <input type="text" name="nombre" id="nombre" class="form-control"
                       required
                       data-fv-notempty-message="Requerido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="tituloGrafica" class="col-sm-2 control-label">Titulo de la gráfica</label>

            <div class="col-sm-10">
                <input type="text" name="tituloGrafica" id="tituloGrafica" class="form-control"
                       required
                       data-fv-notempty-message="Requerido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="metodoCalculo" class="col-sm-2 control-label">Metodo de cálculo</label>

            <div class="col-sm-10">
                <input type="text" name="metodoCalculo" id="metodoCalculo" class="form-control"
                       required
                       data-fv-notempty-message="Requerido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="unidadMedida" class="col-sm-2 control-label">Unidad de medida</label>

            <div class="col-sm-10">
                <input type="text" name="unidadMedida" id="unidadMedida" class="form-control"
                       required
                       data-fv-notempty-message="Requerido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="sentido" class="col-sm-2 control-label">Sentido</label>

            <div class="col-sm-10">
                <g:select name="sentido" id="sentido" from="${['Ascendente', 'Descendente']}" class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label for="unidadExpresion" class="col-sm-2 control-label">Unidad de expresión</label>

            <div class="col-sm-10">
                <g:select id="unidadExpresion" from="${['Acumulado', 'Promedio', 'Maximo Alcanzado', 'Valor Actual']}" class="form-control" name="unidadExpresion"/>
            </div>
        </div>

        <div class="form-group">
            <label for="fuente" class="col-sm-2 control-label">Fuente</label>

            <div class="col-sm-10">
                <input type="text" name="fuente" id="fuente" class="form-control"
                       required
                       data-fv-notempty-message="Requerido"/>
            </div>
        </div>

        <div class="form-group">
            <label for="descripcion" class="col-sm-2 control-label">Descripción</label>

            <div class="col-sm-10">
                <textarea rows="8" cols="50" name="descripcion" id="descripcion" class="form-control">
                </textarea>
            </div>
        </div>

        %{--<div class="form-group">--}%
        %{--<label for="valorDelTacometro" class="col-sm-2 control-label">Valor Del Tacómetro</label>--}%

        %{--<div class="col-sm-2">--}%
        %{--<input id="valorDelTacometro" type="number" min="0" max="100" class="form-control"--}%
        %{--name="valorDelTacometro"--}%
        %{--required--}%
        %{--data-bv-greaterthan-message="Debe ser mayor a 0"--}%
        %{--data-bv-lessthan-message="Debe ser menor a 100"--}%
        %{--data-bv-notempty-message="Requerido"--}%
        %{--data-bv-integer-message="Tiene que ser un numero entero"--}%
        %{--data-bv-digits-message="Solo numeros"/>--}%
        %{--</div>--}%
        %{--</div>--}%

        <div class="form-group">
            <label for="Tema" class="col-sm-2 control-label">Tema</label>

            <div class="col-sm-10">
                <g:select id="tema" name="tema.id" from="${Tema.list()}" optionKey="id" required="" class="many-to-one form-control"/>
            </div>
        </div>

        <input type="hidden" id="domain-id" name="id" value=""/>
    </fieldset>
</form>