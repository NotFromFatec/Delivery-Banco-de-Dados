<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Tipos de Prato</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h1>Tipos de Prato</h1>
                <a href="/dashboard/tipos/novo" class="btn btn-success mb-3">Novo Tipo</a>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty tipos}">
                                <tr>
                                    <td colspan="3" class="text-center">Nenhum tipo cadastrado.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="tipo" items="${tipos}">
                                    <tr>
                                        <td>${tipo.id}</td>
                                        <td>${tipo.nome}</td>
                                        <td>
                                            <a href="/dashboard/tipos/editar/${tipo.id}"
                                                class="btn btn-primary btn-sm">Editar</a>
                                            <a href="/dashboard/tipos/deletar/${tipo.id}" class="btn btn-danger btn-sm"
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