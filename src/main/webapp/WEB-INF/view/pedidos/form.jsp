<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="pt">

    <head>
        <meta charset="UTF-8">
        <title>Pedido</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <div class="container mt-5">
            <h1>Pedido</h1>
            <form method="post" action="/dashboard/pedidos">
                <div class="mb-3">
                    <label for="cliente" class="form-label">CPF do Cliente</label>
                    <input type="text" class="form-control" id="cliente" name="cliente.cpf"
                        value="${pedido.cliente.cpf}" required>
                </div>
                <div class="mb-3">
                    <label for="data" class="form-label">Data</label>
                    <input type="datetime-local" class="form-control" id="data" name="data" value="${pedido.data}"
                        required>
                </div>
                <div class="mb-3">
                    <label for="valorTotal" class="form-label">Valor Total</label>
                    <input type="number" step="0.01" class="form-control" id="valorTotal" name="valorTotal"
                        value="${pedido.valorTotal}" required>
                </div>
                <!-- Para edição de itens do pedido, adicionar campos customizados futuramente -->
                <button type="submit" class="btn btn-primary">Salvar</button>
                <a href="/dashboard/pedidos" class="btn btn-link">Voltar</a>
            </form>
        </div>
    </body>

    </html>