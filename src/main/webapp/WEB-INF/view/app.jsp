<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="pt">

        <head>
            <meta charset="UTF-8">
            <title>DeliveryApp - Cliente</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                .dish-card {
                    border-radius: 18px;
                    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
                    transition: box-shadow 0.2s;
                    min-height: 350px;
                }

                .dish-card:hover {
                    box-shadow: 0 4px 24px rgba(0, 0, 0, 0.16);
                }

                .dish-img {
                    width: 100%;
                    height: 160px;
                    object-fit: cover;
                    border-radius: 12px 12px 0 0;
                    background: #f8f9fa;
                }

                .input-group-text {
                    min-width: 120px;
                }
            </style>
        </head>

        <body>
            <div class="container mt-4 mb-5">
                <h1 class="mb-4 text-center">Cardápio <i class="fa-solid fa-utensils"></i></h1>
                <form id="pedidoForm" method="post" action="/app">
                    <input type="hidden" name="cpf" id="cpfHidden" value="">
                    <div class="row g-4">
                        <c:forEach var="prato" items="${pratos}">
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="card dish-card">
                                    <img class="dish-img"
                                        src="https://cdn.dribbble.com/userupload/22570626/file/original-379b4978ee41eeb352e0ddacbaa6df96.jpg?resize=752x564&vertical=center"
                                        alt="Imagem do prato">
                                    <div class="card-body">
                                        <h5 class="card-title">${prato.nome}</h5>
                                        <span class="badge bg-secondary mb-2">${prato.tipo.nome}</span>
                                        <p class="card-text mb-1">
                                            <strong>Ingredientes:</strong>
                                            <span>
                                                <c:forEach var="ingrediente" items="${prato.ingredientes}">
                                                    <span
                                                        class="badge bg-light text-dark border">${ingrediente.nome}</span>
                                                </c:forEach>
                                            </span>
                                        </p>
                                        <div class="mb-2">
                                            <strong>Porções:</strong>
                                            <c:forEach var="porcao" items="${porcoes}">
                                                <div class="input-group input-group-sm mb-1 align-items-center">
                                                    <span class="input-group-text">${porcao.nome} <i
                                                            class="fa-solid fa-bowl-food ms-1"></i> - R$
                                                        ${porcao.valor}</span>
                                                    <button type="button"
                                                        class="btn btn-outline-secondary btn-sm btn-qty"
                                                        data-action="decrease" data-prato="${prato.id}"
                                                        data-porcao="${porcao.id}"><i class="fa fa-minus"></i></button>
                                                    <input type="text" readonly
                                                        class="form-control text-center qty-input"
                                                        name="qtd_${prato.id}_${porcao.id}" value="0"
                                                        style="max-width:40px;" data-prato="${prato.nome}"
                                                        data-porcao="${porcao.nome}" data-preco="${porcao.valor}">
                                                    <button type="button"
                                                        class="btn btn-outline-secondary btn-sm btn-qty"
                                                        data-action="increase" data-prato="${prato.id}"
                                                        data-porcao="${porcao.id}"><i class="fa fa-plus"></i></button>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="mt-4 d-flex flex-wrap gap-2 justify-content-center">
                        <button type="button" class="btn btn-primary d-none" id="loginBtn"><i
                                class="fa-solid fa-sign-in-alt"></i> Login</button>
                        <button type="button" class="btn btn-secondary d-none" id="logoutBtn"><i
                                class="fa-solid fa-sign-out-alt"></i> Logout</button>
                        <button type="button" class="btn btn-success d-none" id="criarContaBtn"><i
                                class="fa-solid fa-user-plus"></i> Criar Conta</button>
                        <button type="submit" class="btn btn-warning" id="fazerPedidoBtn"><i
                                class="fa-solid fa-basket-shopping"></i> Fazer Pedido</button>
                        <button type="button" class="btn btn-info d-none" id="verPedidosBtn"><i
                                class="fa-solid fa-list"></i> Ver Meus Pedidos</button>
                    </div>
                </form>
                <!-- Login Modal (reused for order login prompt) -->
                <div class="modal fade" id="orderLoginModal" tabindex="-1" aria-labelledby="orderLoginModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="orderLoginModalLabel">Login para Fazer Pedido</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="orderLoginForm">
                                    <div class="mb-3">
                                        <label for="orderLoginCpf" class="form-label">CPF</label>
                                        <input type="text" class="form-control" id="orderLoginCpf" name="cpf"
                                            maxlength="14" required placeholder="000.000.000-00">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Entrar</button>
                                    <button type="button" class="btn btn-link" id="orderCriarContaBtn">Criar
                                        Conta</button>
                                </form>
                                <div id="orderLoginError" class="text-danger mt-2" style="display:none"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Criar Conta Modal (reused for order flow) -->
                <div class="modal fade" id="orderCriarContaModal" tabindex="-1"
                    aria-labelledby="orderCriarContaModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="orderCriarContaModalLabel">Criar Conta</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="orderCriarContaForm">
                                    <div class="mb-3">
                                        <label for="orderCriarCpf" class="form-label">CPF</label>
                                        <input type="text" class="form-control" id="orderCriarCpf" name="cpf" required
                                            maxlength="14" pattern="\d{3}\.\d{3}\.\d{3}-\d{2}"
                                            placeholder="000.000.000-00">
                                    </div>
                                    <div class="mb-3">
                                        <label for="orderCriarNome" class="form-label">Nome</label>
                                        <input type="text" class="form-control" id="orderCriarNome" name="nome"
                                            required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="orderCriarTelefone" class="form-label">Telefone</label>
                                        <input type="text" class="form-control" id="orderCriarTelefone" name="telefone"
                                            required maxlength="15" pattern="\(\d{2}\) \d{5}-\d{4}"
                                            placeholder="(11) 91234-5678">
                                    </div>
                                    <div class="mb-3">
                                        <label for="orderCriarLogradouro" class="form-label">Logradouro</label>
                                        <input type="text" class="form-control" id="orderCriarLogradouro"
                                            name="logradouro" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="orderCriarNumero" class="form-label">Número</label>
                                        <input type="text" class="form-control" id="orderCriarNumero" name="numero"
                                            required pattern="\d+" maxlength="6" placeholder="123">
                                    </div>
                                    <div class="mb-3">
                                        <label for="orderCriarCep" class="form-label">CEP</label>
                                        <input type="text" class="form-control" id="orderCriarCep" name="cep" required
                                            maxlength="9" pattern="\d{5}-\d{3}" placeholder="00000-000">
                                    </div>
                                    <div class="mb-3">
                                        <label for="orderCriarPontoReferencia" class="form-label">Ponto de
                                            Referência</label>
                                        <input type="text" class="form-control" id="orderCriarPontoReferencia"
                                            name="pontoReferencia">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Criar Conta</button>
                                </form>
                                <div id="orderCriarContaError" class="text-danger mt-2" style="display:none"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Order Summary Modal -->
                <div class="modal fade" id="orderSummaryModal" tabindex="-1" aria-labelledby="orderSummaryModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="orderSummaryModalLabel">Resumo do Pedido</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div id="orderSummaryContent"></div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Editar</button>
                                <button type="button" class="btn btn-success" id="confirmarPedidoBtn">Confirmar
                                    Pedido</button>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/js/app.js"></script>
                <script>
                    $(function () {
                        $('#loginCpf, #cpf').mask('000.000.000-00');
                        $('#telefone').mask('(00) 00000-0000');
                        $('#cep').mask('00000-000');
                    });
                    // Mask for login/creation modals
                    $(function () {
                        $('#orderLoginCpf, #orderCriarCpf').mask('000.000.000-00');
                        $('#orderCriarTelefone').mask('(00) 00000-0000');
                        $('#orderCriarCep').mask('00000-000');
                    });
                    function isLoggedIn() {
                        return !!localStorage.getItem('cpfCliente');
                    }
                    function updateAuthButtons() {
                        const logged = isLoggedIn();
                        document.getElementById('loginBtn').classList.toggle('d-none', logged);
                        document.getElementById('criarContaBtn').classList.toggle('d-none', logged);
                        document.getElementById('logoutBtn').classList.toggle('d-none', !logged);
                        document.getElementById('verPedidosBtn').classList.toggle('d-none', !logged);
                    }
                    updateAuthButtons();
                    // Quantity selector logic (robust)
                    document.querySelectorAll('.btn-qty').forEach(btn => {
                        btn.addEventListener('click', function () {
                            const group = this.closest('.input-group');
                            const input = group ? group.querySelector('.qty-input') : null;
                            if (!input) return;
                            let val = parseInt(input.value) || 0;
                            if (this.getAttribute('data-action') === 'increase') val++;
                            if (this.getAttribute('data-action') === 'decrease' && val > 0) val--;
                            input.value = val;
                        });
                    });
                    // Ensure all qty-inputs start at zero
                    document.querySelectorAll('.qty-input').forEach(input => { input.value = 0; });
                    // Conditional buttons
                    function updateAuthButtons() {
                        const logged = isLoggedIn();
                        document.getElementById('loginBtn').classList.toggle('d-none', logged);
                        document.getElementById('criarContaBtn').classList.toggle('d-none', logged);
                        document.getElementById('logoutBtn').classList.toggle('d-none', !logged);
                        document.getElementById('verPedidosBtn').classList.toggle('d-none', !logged);
                    }
                    updateAuthButtons();
                    // Order summary modal logic
                    let allowOrderSubmit = false;
                    document.getElementById('fazerPedidoBtn').type = 'button';
                    document.getElementById('fazerPedidoBtn').onclick = function (e) {
                        var cpf = localStorage.getItem('cpfCliente');
                        if (!cpf) {
                            e.preventDefault();
                            // Save the intended action to run after login
                            window._pendingOrderAction = () => document.getElementById('fazerPedidoBtn').click();
                            var modal = new bootstrap.Modal(document.getElementById('orderLoginModal'));
                            modal.show();
                            return;
                        }
                        let debugOrder = [];
                        let total = 0;
                        document.querySelectorAll('.qty-input').forEach(function (input) {
                            const val = parseInt(input.value);
                            if (val > 0) {
                                let prato = input.getAttribute('data-prato') || '-';
                                let porcao = input.getAttribute('data-porcao') || '-';
                                let preco = input.getAttribute('data-preco') || '0';
                                const precoNum = parseFloat((preco || '0').replace(',', '.')) || 0;
                                total += precoNum * val;
                                debugOrder.push({ prato, porcao, preco: precoNum, quantidade: val });
                            }
                        });
                        let summary = '<ul class="list-group">';
                        if (debugOrder.length === 0) {
                            summary += `<li class='list-group-item text-center text-muted'>Nenhum prato selecionado.</li>`;
                        } else {
                            for (const item of debugOrder) {
                                summary += '<li class="list-group-item d-flex justify-content-between align-items-center"><span>' + item.prato + ' - ' + item.porcao + '</span><span class="badge bg-primary rounded-pill">x' + item.quantidade + '</span></li>';
                            }
                        }
                        summary += '</ul><div class="mt-3 text-end"><strong>Total: R$ ' + total.toFixed(2) + '</strong></div>';
                        document.getElementById('orderSummaryContent').innerHTML = summary;
                        document.getElementById('orderSummaryContent').style.border = '';
                        document.getElementById('orderSummaryContent').style.background = '';
                        var modal = new bootstrap.Modal(document.getElementById('orderSummaryModal'));
                        modal.show();
                    };
                    // Login modal logic for order
                    document.getElementById('orderLoginForm').onsubmit = function (e) {
                        e.preventDefault();
                        var cpf = document.getElementById('orderLoginCpf').value;
                        fetch('/app/validar-cpf?cpf=' + encodeURIComponent(cpf))
                            .then(r => r.json())
                            .then(data => {
                                if (data.valido) {
                                    var modal = bootstrap.Modal.getInstance(document.getElementById('orderLoginModal'));
                                    modal.hide();
                                    handleLoginSuccess(cpf);
                                } else {
                                    document.getElementById('orderLoginError').innerText = 'CPF não encontrado. Crie uma conta.';
                                    document.getElementById('orderLoginError').style.display = '';
                                }
                            });
                    };
                    // Show create account modal from login modal
                    document.getElementById('orderCriarContaBtn').onclick = function () {
                        var modal = new bootstrap.Modal(document.getElementById('orderCriarContaModal'));
                        modal.show();
                    };
                    // Create account logic for order
                    document.getElementById('orderCriarContaForm').onsubmit = function (e) {
                        e.preventDefault();
                        var form = e.target;
                        var data = {};
                        for (var i = 0; i < form.elements.length; i++) {
                            var el = form.elements[i];
                            if (el.name) data[el.name] = el.value;
                        }
                        fetch('/app/criar-conta', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: Object.keys(data).map(k => encodeURIComponent(k) + '=' + encodeURIComponent(data[k])).join('&')
                        })
                            .then(r => {
                                if (r.redirected || r.ok) {
                                    var modal = bootstrap.Modal.getInstance(document.getElementById('orderCriarContaModal'));
                                    modal.hide();
                                    var loginModal = bootstrap.Modal.getInstance(document.getElementById('orderLoginModal'));
                                    if (loginModal) loginModal.hide();
                                    handleLoginSuccess(data.cpf);
                                } else {
                                    document.getElementById('orderCriarContaError').innerText = 'Erro ao criar conta. Tente novamente.';
                                    document.getElementById('orderCriarContaError').style.display = '';
                                }
                            });
                    };
                    // Fix: Ensure 'verPedidosBtn' works if logged in
                    document.getElementById('verPedidosBtn').onclick = function () {
                        var cpf = localStorage.getItem('cpfCliente');
                        if (cpf) {
                            window.location.href = '/app/pedidos/' + encodeURIComponent(cpf);
                        } else {
                            var modal = new bootstrap.Modal(document.getElementById('orderLoginModal'));
                            modal.show();
                        }
                    };
                    // Confirm order: submit form only if logged in
                    document.getElementById('confirmarPedidoBtn').onclick = function () {
                        var cpf = localStorage.getItem('cpfCliente');
                        if (!cpf) {
                            var modal = new bootstrap.Modal(document.getElementById('orderLoginModal'));
                            modal.show();
                            return;
                        }
                        document.getElementById('pedidoForm').submit();
                    };
                    // Update auth buttons after login/logout
                    function handleLoginSuccess(cpf) {
                        localStorage.setItem('cpfCliente', cpf);
                        var cpfHidden = document.getElementById('cpfHidden');
                        if (cpfHidden) cpfHidden.value = cpf;
                        updateAuthButtons();
                        // If order summary was blocked, show it now
                        var pendingOrder = window._pendingOrderAction;
                        if (pendingOrder) {
                            window._pendingOrderAction = null;
                            pendingOrder();
                        }
                    }
                    document.getElementById('logoutBtn').onclick = function () {
                        localStorage.removeItem('cpfCliente');
                        updateAuthButtons();
                    };
                    // Set hidden CPF field from localStorage on page load
                    document.addEventListener('DOMContentLoaded', function () {
                        var cpf = localStorage.getItem('cpfCliente') || '';
                        var cpfHidden = document.getElementById('cpfHidden');
                        if (cpfHidden) cpfHidden.value = cpf;
                        // Show Java-side error if present
                        var erro = "${erro}";
                        if (erro && erro !== 'null' && erro !== '') {
                            alert(erro);
                        }
                    });
                </script>
            </div>
        </body>

        </html>