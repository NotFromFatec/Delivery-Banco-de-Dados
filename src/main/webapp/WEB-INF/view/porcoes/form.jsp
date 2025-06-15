<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="pt">

    <head>
        <meta charset="UTF-8">
        <title>Porção</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <div class="container mt-5">
            <h1>Porção</h1>
            <form method="post" action="/dashboard/porcoes">
                <div class="mb-3">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" class="form-control" id="nome" name="nome" value="${porcao.nome}" required>
                </div>
                <div class="mb-3">
                    <label for="valor" class="form-label">Valor</label>
                    <input type="number" step="0.01" class="form-control" id="valor" name="valor"
                        value="${porcao.valor}" required>
                </div>
                <button type="submit" class="btn btn-primary">Salvar</button>
                <a href="/dashboard/porcoes" class="btn btn-link">Voltar</a>
            </form>
        </div>
    </body>

    </html>