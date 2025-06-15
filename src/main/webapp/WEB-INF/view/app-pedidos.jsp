<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Meus Pedidos</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h1>Meus Pedidos</h1>
                <c:choose>
                    <c:when test="${empty pedidos}">
                        <div class="alert alert-info">Nenhum pedido encontrado.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="accordion" id="pedidosAccordion">
                            <c:forEach var="pedido" items="${pedidos}" varStatus="status">
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="heading${status.index}">
                                        <button class="accordion-button collapsed" type="button"
                                            data-bs-toggle="collapse" data-bs-target="#collapse${status.index}"
                                            aria-expanded="false" aria-controls="collapse${status.index}">
                                            Pedido #${pedido.id} - ${pedido.data} - R$ ${pedido.valorTotal}
                                        </button>
                                    </h2>
                                    <div id="collapse${status.index}" class="accordion-collapse collapse"
                                        aria-labelledby="heading${status.index}" data-bs-parent="#pedidosAccordion">
                                        <div class="accordion-body">
                                            <table class="table table-sm">
                                                <thead>
                                                    <tr>
                                                        <th>Prato</th>
                                                        <th>Tamanho</th>
                                                        <th>Quantidade</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${pedido.itens}">
                                                        <tr>
                                                            <td>${item.prato.nome}</td>
                                                            <td>${item.porcao.nome}</td>
                                                            <td>${item.quantidade}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
                <a href="/app" class="btn btn-link mt-3">Voltar</a>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>