
// Função para salvar o CPF do cliente no localStorage
function loginCliente() {
    const cpf = prompt('Digite seu CPF:');
    if (cpf && cpf.length >= 11) {
        localStorage.setItem('cpfCliente', cpf);
        alert('Login realizado!');
        restaurarPedidoDoLocalStorage();
    } else {
        alert('CPF inválido!');
    }
}

function logoutCliente() {
    localStorage.removeItem('cpfCliente');
    localStorage.removeItem('pedidoTemp');
    alert('Logout realizado!');
}

document.getElementById('loginBtn').onclick = loginCliente;
document.getElementById('logoutBtn').onclick = logoutCliente;

document.getElementById('pedidoForm').onsubmit = function (e) {
    const cpf = localStorage.getItem('cpfCliente');
    if (!cpf) {
        salvarPedidoNoLocalStorage();
        alert('Você precisa fazer login com seu CPF para realizar o pedido!');
        e.preventDefault();
        return false;
    }
    // Adicionar um input oculto com o CPF
    let inputCpf = document.createElement('input');
    inputCpf.type = 'hidden';
    inputCpf.name = 'cpf';
    inputCpf.value = cpf;
    this.appendChild(inputCpf);
    localStorage.removeItem('pedidoTemp');

    return true;
};

// Função para salvar o estado do pedido no localStorage
function salvarPedidoNoLocalStorage() {
    const form = document.getElementById('pedidoForm');
    const data = {};
    Array.from(form.elements).forEach(el => {
        if (el.name && (el.type === 'number' || el.type === 'hidden')) {
            data[el.name] = el.value;
        }
    });
    localStorage.setItem('pedidoTemp', JSON.stringify(data));
}

function restaurarPedidoDoLocalStorage() {
    const data = localStorage.getItem('pedidoTemp');
    if (!data) return;
    const obj = JSON.parse(data);
    const form = document.getElementById('pedidoForm');
    Object.keys(obj).forEach(name => {
        const el = form.elements.namedItem(name);
        if (el) el.value = obj[name];
    });
}

// Restaurar pedido ao carregar página
window.addEventListener('DOMContentLoaded', restaurarPedidoDoLocalStorage);
