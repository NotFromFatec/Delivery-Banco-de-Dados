<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Porções</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h1>Porções</h1>
                <a href="/dashboard/porcoes/novo" class="btn btn-success mb-3">Nova Porção</a>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>Valor</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty porcoes}">
                                <tr>
                                    <td colspan="4" class="text-center">Nenhuma porção cadastrada.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="porcao" items="${porcoes}">
                                    <tr>
                                        <td>${porcao.id}</td>
                                        <td>${porcao.nome}</td>
                                        <td>R$ ${porcao.valor}</td>
                                        <td>
                                            <a href="/dashboard/porcoes/editar/${porcao.id}"
                                                class="btn btn-primary btn-sm">Editar</a>
                                            <a href="/dashboard/porcoes/deletar/${porcao.id}"
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