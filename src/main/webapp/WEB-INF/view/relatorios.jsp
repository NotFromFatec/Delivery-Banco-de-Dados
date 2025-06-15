<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Relatórios</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h1>Relatórios</h1>
                <form method="get" action="/dashboard/relatorios/pratos-por-tipo" target="_blank">
                    <div class="mb-3">
                        <label for="tipoId" class="form-label">Tipo de Prato</label>
                        <select class="form-select" id="tipoId" name="tipoId" required>
                            <c:forEach var="tipo" items="${tipos}">
                                <option value="${tipo.id}">${tipo.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Gerar PDF de Pratos por Tipo</button>
                </form>
                <hr>
                <form method="get" action="/dashboard/relatorios/pedido-cliente" target="_blank">
                    <div class="mb-3">
                        <label for="pedidoId" class="form-label">Pedido</label>
                        <input type="number" class="form-control" id="pedidoId" name="pedidoId" required
                            placeholder="ID do Pedido">
                    </div>
                    <button type="submit" class="btn btn-primary">Gerar PDF de Pedido do Cliente</button>
                </form>
                <hr>
                <form method="get" action="/dashboard/relatorios/por-dia" target="_blank">
                    <div class="mb-3">
                        <label for="data" class="form-label">Data</label>
                        <input type="date" class="form-control" id="data" name="data" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Gerar PDF de Pedidos por Dia</button>
                </form>
                <a href="/dashboard" class="btn btn-link mt-3">Voltar</a>
            </div>
        </body>

        </html>