<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Pratos</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h1>Pratos</h1>
                <a href="/dashboard/pratos/novo" class="btn btn-success mb-3">Novo Prato</a>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>Tipo</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty pratos}">
                                <tr>
                                    <td colspan="4" class="text-center">Nenhum prato cadastrado.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="prato" items="${pratos}">
                                    <tr>
                                        <td>${prato.id}</td>
                                        <td>${prato.nome}</td>
                                        <td>${prato.tipo.nome}</td>
                                        <td>
                                            <a href="/dashboard/pratos/editar/${prato.id}"
                                                class="btn btn-primary btn-sm">Editar</a>
                                            <a href="/dashboard/pratos/deletar/${prato.id}"
                                                class="btn btn-danger btn-sm"
                                                onclick="return confirm('Tem certeza?')">Deletar</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                <a href="/dashboard" class="btn btn-link">Voltar</a>
            </div>
        </body>

        </html>