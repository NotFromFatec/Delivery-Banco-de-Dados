<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Pedidos</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h1>Pedidos</h1>
                <a href="/dashboard/pedidos/novo" class="btn btn-success mb-3">Novo Pedido</a>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Data</th>
                            <th>Valor Total</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pedido" items="${pedidos}">
                            <tr>
                                <td>${pedido.id}</td>
                                <td>${pedido.cliente.nome} (${pedido.cliente.cpf})</td>
                                <td>${pedido.data}</td>
                                <td>R$ ${pedido.valorTotal}</td>
                                <td>
                                    <a href="/dashboard/pedidos/editar/${pedido.id}"
                                        class="btn btn-primary btn-sm">Editar</a>
                                    <a href="/dashboard/pedidos/deletar/${pedido.id}" class="btn btn-danger btn-sm"
                                        onclick="return confirm('Tem certeza?')">Deletar</a>
                                    <form method="get" action="/dashboard/relatorios/pedido-cliente" target="_blank"
                                        style="display:inline">
                                        <input type="hidden" name="pedidoId" value="${pedido.id}" />
                                        <button type="submit" class="btn btn-info btn-sm">Gerar Relatório</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <a href="/dashboard" class="btn btn-link">Voltar</a>
            </div>
        </body>

        </html>