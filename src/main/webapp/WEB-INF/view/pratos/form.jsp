<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>Prato</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <script>
                function getUsedSizes() {
                    const selects = document.querySelectorAll('#tamanhos-container select[name="tamanhosNomes"]');
                    return Array.from(selects).map(s => s.value);
                }
                function addTamanhoRowDropdown() {
                    const container = document.getElementById('tamanhos-container');
                    const usados = getUsedSizes();
                    const all = ['PEQUENO', 'MEDIO', 'GRANDE'];
                    const disponiveis = all.filter(t => !usados.includes(t));
                    if (disponiveis.length === 0) return;
                    const row = document.createElement('div');
                    row.className = 'row mb-2';
                    let options = '';
                    disponiveis.forEach(function (t) {
                        let label = t.charAt(0) + t.slice(1).toLowerCase();
                        if (t === 'PEQUENO') label = 'Pequeno';
                        if (t === 'MEDIO') label = 'Médio';
                        if (t === 'GRANDE') label = 'Grande';
                        options += '<option value="' + t + '">' + label + '</option>';
                    });
                    row.innerHTML = `
                <div class="col">
                    <select class="form-select" name="tamanhosNomes" required>${options}</select>
                </div>
                <div class="col">
                    <input type="number" step="0.01" class="form-control" name="tamanhosValores" placeholder="Valor" required />
                </div>
                <div class="col-auto">
                    <button type="button" class="btn btn-danger" onclick="removeTamanhoRow(this)">Remover</button>
                </div>
            `;
                    container.appendChild(row);
                    updateAllDropdowns();
                }
                function removeTamanhoRow(btn) {
                    btn.parentElement.parentElement.remove();
                    updateAllDropdowns();
                }
                function updateAllDropdowns() {
                    const all = ['PEQUENO', 'MEDIO', 'GRANDE'];
                    const selects = document.querySelectorAll('#tamanhos-container select[name="tamanhosNomes"]');
                    const usados = getUsedSizes();
                    selects.forEach(select => {
                        const current = select.value;
                        select.innerHTML = '';
                        all.forEach(function (t) {
                            let label = t.charAt(0) + t.slice(1).toLowerCase();
                            if (t === 'PEQUENO') label = 'Pequeno';
                            if (t === 'MEDIO') label = 'Médio';
                            if (t === 'GRANDE') label = 'Grande';
                            // Show if not used or is the current value
                            if (usados.indexOf(t) === -1 || t === current) {
                                select.innerHTML += '<option value="' + t + '"' + (t === current ? ' selected' : '') + '>' + label + '</option>';
                            }
                        });
                    });
                }
                document.addEventListener('DOMContentLoaded', updateAllDropdowns);
            </script>
        </head>

        <body>
            <div class="container mt-5">
                <h1>Prato</h1>
                <form method="post" action="/dashboard/pratos">
                    <div class="mb-3">
                        <label for="nome" class="form-label">Nome</label>
                        <input type="text" class="form-control" id="nome" name="nome" value="${prato.nome}" required>
                    </div>
                    <div class="mb-3">
                        <label for="tipo" class="form-label">Tipo</label>
                        <select class="form-select" id="tipo" name="tipo.id" required>
                            <option value="">Selecione o tipo</option>
                            <c:forEach var="tipo" items="${tipos}">
                                <option value="${tipo.id}" ${prato.tipo !=null && prato.tipo.id==tipo.id ? 'selected'
                                    : '' }>${tipo.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ingredientes</label><br />
                        <c:forEach var="ingrediente" items="${ingredientes}" varStatus="status">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" name="ingredientesIds"
                                    value="${ingrediente.id}" id="ingr${status.index}" <c:if
                                    test="${prato.ingredientes != null && prato.ingredientes.contains(ingrediente)}">checked
                                </c:if> />
                                <label class="form-check-label" for="ingr${status.index}">${ingrediente.nome}</label>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tamanhos e Preços</label>
                        <div id="tamanhos-container">
                            <c:forEach var="tamanho" items="${prato.tamanhos}" varStatus="status">
                                <div class="row mb-2">
                                    <div class="col">
                                        <select class="form-select" name="tamanhosNomes" required>
                                            <option value="PEQUENO" ${tamanho.nome=='PEQUENO' ? 'selected' : '' }>
                                                Pequeno</option>
                                            <option value="MEDIO" ${tamanho.nome=='MEDIO' ? 'selected' : '' }>Médio
                                            </option>
                                            <option value="GRANDE" ${tamanho.nome=='GRANDE' ? 'selected' : '' }>Grande
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <input type="number" step="0.01" class="form-control" name="tamanhosValores"
                                            value="${tamanho.valor}" placeholder="Valor" required />
                                    </div>
                                    <div class="col-auto">
                                        <button type="button" class="btn btn-danger"
                                            onclick="removeTamanhoRow(this)">Remover</button>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty prato.tamanhos}">
                                <div class="row mb-2">
                                    <div class="col">
                                        <select class="form-select" name="tamanhosNomes" required>
                                            <option value="PEQUENO">Pequeno</option>
                                            <option value="MEDIO">Médio</option>
                                            <option value="GRANDE">Grande</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <input type="number" step="0.01" class="form-control" name="tamanhosValores"
                                            placeholder="Valor" required />
                                    </div>
                                    <div class="col-auto">
                                        <button type="button" class="btn btn-danger"
                                            onclick="removeTamanhoRow(this)">Remover</button>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        <button type="button" class="btn btn-secondary mt-2" onclick="addTamanhoRowDropdown()">Adicionar
                            Tamanho</button>
                    </div>
                    <button type="submit" class="btn btn-primary">Salvar</button>
                    <a href="/dashboard/pratos" class="btn btn-link">Voltar</a>
                </form>
            </div>
        </body>

        </html>