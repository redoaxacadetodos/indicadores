<%@ page import="mx.gob.redoaxaca.Tema; mx.gob.redoaxaca.Eje" %>
<form id="modalForm" class="form-horizontal">
    <fieldset>
        <div class="form-group">
            <div class="row">
                <label for="nombre" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Nombre</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <input type="text" name="nombre" id="nombre" class="form-control"
                           required
                           data-fv-notempty-message="Requerido"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="tituloGrafica" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Titulo de la gráfica</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <input type="text" name="tituloGrafica" id="tituloGrafica" class="form-control"
                           required
                           data-fv-notempty-message="Requerido"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="metodoCalculo" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Metodo de cálculo</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <input type="text" name="metodoCalculo" id="metodoCalculo" class="form-control"
                           required
                           data-fv-notempty-message="Requerido"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="unidadMedida" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Unidad de medida</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <input type="text" name="unidadMedida" id="unidadMedida" class="form-control"
                           required
                           data-fv-notempty-message="Requerido"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="sentido" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Sentido</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <g:select name="sentido" id="sentido" from="${['Ascendente', 'Descendente']}" class="form-control"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="unidadExpresion" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Unidad de expresión</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <g:select id="unidadExpresion" from="${['Acumulado', 'Promedio', 'Maximo Alcanzado', 'Valor Actual']}" class="form-control" name="unidadExpresion"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="fuente" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Fuente</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <input type="text" name="fuente" id="fuente" class="form-control"
                           required
                           data-fv-notempty-message="Requerido"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <label for="descripcion" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Descripción</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <textarea rows="8" cols="50" name="descripcion" id="descripcion" class="form-control">
                    </textarea>
                </div>
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
            <div class="row">
                <label for="Tema" class="col-lg-2 col-md-2 col-sm-2 col-xs-2 control-label">Tema</label>

                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <g:select id="tema" name="tema.id" from="${Tema.list()}" optionKey="id" required="" class="many-to-one form-control"/>
                </div>
            </div>
        </div>

        <input type="hidden" id="domain-id" name="id" value=""/>
    </fieldset>
</form>