<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="pt">

    <head>
        <meta charset="UTF-8">
        <title>Ingrediente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <div class="container mt-5">
            <h1>Ingrediente</h1>
            <form method="post" action="/dashboard/ingredientes">
                <div class="mb-3">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" class="form-control" id="nome" name="nome" value="${ingrediente.nome}" required>
                </div>
                <div class="mb-3">
                    <label for="formatoApresentacao" class="form-label">Formato de Apresentação</label>
                    <input type="text" class="form-control" id="formatoApresentacao" name="formatoApresentacao"
                        value="${ingrediente.formatoApresentacao}" required>
                </div>
                <button type="submit" class="btn btn-primary">Salvar</button>
                <a href="/dashboard/ingredientes" class="btn btn-link">Voltar</a>
            </form>
        </div>
    </body>

    </html>