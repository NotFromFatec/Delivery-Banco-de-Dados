<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="pt">

    <head>
        <meta charset="UTF-8">
        <title>Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <div class="container mt-5">
            <h1>Cliente</h1>
            <form method="post" action="/dashboard/clientes">
                <div class="mb-3">
                    <label for="cpf" class="form-label">CPF</label>
                    <input type="text" class="form-control" id="cpf" name="cpf" value="${cliente.cpf}" required
                        maxlength="14">
                </div>
                <div class="mb-3">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" class="form-control" id="nome" name="nome" value="${cliente.nome}" required>
                </div>
                <div class="mb-3">
                    <label for="telefone" class="form-label">Telefone</label>
                    <input type="text" class="form-control" id="telefone" name="telefone" value="${cliente.telefone}"
                        required>
                </div>
                <div class="mb-3">
                    <label for="logradouro" class="form-label">Logradouro</label>
                    <input type="text" class="form-control" id="logradouro" name="logradouro"
                        value="${cliente.logradouro}" required>
                </div>
                <div class="mb-3">
                    <label for="numero" class="form-label">Número</label>
                    <input type="text" class="form-control" id="numero" name="numero" value="${cliente.numero}"
                        required>
                </div>
                <div class="mb-3">
                    <label for="cep" class="form-label">CEP</label>
                    <input type="text" class="form-control" id="cep" name="cep" value="${cliente.cep}" required>
                </div>
                <div class="mb-3">
                    <label for="pontoReferencia" class="form-label">Ponto de Referência</label>
                    <input type="text" class="form-control" id="pontoReferencia" name="pontoReferencia"
                        value="${cliente.pontoReferencia}">
                </div>
                <button type="submit" class="btn btn-primary">Salvar</button>
                <a href="/dashboard/clientes" class="btn btn-link">Voltar</a>
            </form>
        </div>
    </body>

    </html>