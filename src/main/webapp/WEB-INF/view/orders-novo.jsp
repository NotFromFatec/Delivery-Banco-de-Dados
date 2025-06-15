<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Novo Pedido (Garçom)</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h1>Novo Pedido</h1>
                <form method="post" action="/orders/novo">
                    <div class="mb-3">
                        <label for="cpf" class="form-label">CPF do Cliente</label>
                        <input type="text" class="form-control" id="cpf" name="cpf" required maxlength="14">
                    </div>
                    <div class="row">
                        <c:forEach var="prato" items="${pratos}">
                            <div class="col-md-6 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">${prato.nome}</h5>
                                        <h6 class="card-subtitle mb-2 text-muted">Tipo: ${prato.tipo.nome}</h6>
                                        <p class="card-text">
                                            <strong>Ingredientes:</strong>
                                        <ul>
                                            <c:forEach var="pi" items="${prato.ingredientes}">
                                                <li>${pi.ingrediente.nome} (${pi.ingrediente.formatoApresentacao})</li>
                                            </c:forEach>
                                        </ul>
                                        </p>
                                        <div>
                                            <strong>Porções:</strong>
                                            <c:forEach var="porcao" items="${porcoes}">
                                                <div class="input-group mb-1">
                                                    <span class="input-group-text">${porcao.nome} - R$
                                                        ${porcao.valor}</span>
                                                    <input type="number" min="0" value="0" class="form-control"
                                                        name="qtd_${prato.id}_${porcao.id}" placeholder="Qtd">
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <button type="submit" class="btn btn-success">Fazer Pedido</button>
                    <a href="/orders" class="btn btn-link">Voltar</a>
                </form>
            </div>
        </body>

        </html>