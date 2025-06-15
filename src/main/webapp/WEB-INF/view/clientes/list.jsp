<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Clientes</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h1>Clientes</h1>
                <a href="/dashboard/clientes/novo" class="btn btn-success mb-3">Novo Cliente</a>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>CPF</th>
                            <th>Nome</th>
                            <th>Telefone</th>
                            <th>Endereço</th>
                            <th>Ponto de Referência</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cliente" items="${clientes}">
                            <tr>
                                <td>${cliente.cpf}</td>
                                <td>${cliente.nome}</td>
                                <td>${cliente.telefone}</td>
                                <td>${cliente.logradouro}, ${cliente.numero}, ${cliente.cep}</td>
                                <td>${cliente.pontoReferencia}</td>
                                <td>
                                    <a href="/dashboard/clientes/editar/${cliente.cpf}"
                                        class="btn btn-primary btn-sm">Editar</a>
                                    <a href="/dashboard/clientes/deletar/${cliente.cpf}" class="btn btn-danger btn-sm"
                                        onclick="return confirm('Tem certeza?')">Deletar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <a href="/dashboard" class="btn btn-link">Voltar</a>
            </div>
        </body>

        </html>