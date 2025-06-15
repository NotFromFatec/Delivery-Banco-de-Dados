<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="pt">

    <head>
        <meta charset="UTF-8">
        <title>Criar Conta</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <div class="container mt-5">
            <h1>Criar Conta</h1>
            <form method="post" action="/app/criar-conta" id="criarContaForm">
                <div class="mb-3">
                    <label for="cpf" class="form-label">CPF</label>
                    <input type="text" class="form-control" id="cpf" name="cpf" value="${cliente.cpf}" required
                        maxlength="14" pattern="\d{3}\.\d{3}\.\d{3}-\d{2}" placeholder="000.000.000-00">
                </div>
                <div class="mb-3">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" class="form-control" id="nome" name="nome" value="${cliente.nome}" required>
                </div>
                <div class="mb-3">
                    <label for="telefone" class="form-label">Telefone</label>
                    <input type="text" class="form-control" id="telefone" name="telefone" value="${cliente.telefone}"
                        required maxlength="15" pattern="\(\d{2}\) \d{5}-\d{4}" placeholder="(11) 91234-5678">
                </div>
                <div class="mb-3">
                    <label for="logradouro" class="form-label">Logradouro</label>
                    <input type="text" class="form-control" id="logradouro" name="logradouro"
                        value="${cliente.logradouro}" required>
                </div>
                <div class="mb-3">
                    <label for="numero" class="form-label">Número</label>
                    <input type="text" class="form-control" id="numero" name="numero" value="${cliente.numero}" required
                        pattern="\d+" maxlength="6" placeholder="123">
                </div>
                <div class="mb-3">
                    <label for="cep" class="form-label">CEP</label>
                    <input type="text" class="form-control" id="cep" name="cep" value="${cliente.cep}" required
                        maxlength="9" pattern="\d{5}-\d{3}" placeholder="00000-000">
                </div>
                <div class="mb-3">
                    <label for="pontoReferencia" class="form-label">Ponto de Referência</label>
                    <input type="text" class="form-control" id="pontoReferencia" name="pontoReferencia"
                        value="${cliente.pontoReferencia}">
                </div>
                <button type="submit" class="btn btn-primary">Criar Conta</button>
                <a href="/app" class="btn btn-link">Voltar</a>
            </form>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
            <script>
                $(function () {
                    $('#cpf').mask('000.000.000-00');
                    $('#telefone').mask('(00) 00000-0000');
                    $('#cep').mask('00000-000');
                });
            </script>
        </div>
    </body>

    </html>