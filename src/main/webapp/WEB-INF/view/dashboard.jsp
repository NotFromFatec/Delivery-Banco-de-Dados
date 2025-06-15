<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="pt">

    <head>
        <meta charset="UTF-8">
        <title>DeliveryApp - Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <div class="container mt-5">
            <h1 class="mb-4">Painel Administrativo</h1>
            <div class="list-group mb-4">
                <a href="/dashboard/clientes" class="list-group-item list-group-item-action">Clientes</a>
                <a href="/dashboard/pratos" class="list-group-item list-group-item-action">Pratos</a>
                <a href="/dashboard/ingredientes" class="list-group-item list-group-item-action">Ingredientes</a>
                <a href="/dashboard/tipos" class="list-group-item list-group-item-action">Tipos de Prato</a>
                <a href="/dashboard/porcoes" class="list-group-item list-group-item-action">Porções</a>
                <a href="/dashboard/relatorios" class="list-group-item list-group-item-action">Relatórios (PDF)</a>
                <a href="/dashboard/pedidos" class="list-group-item list-group-item-action">Pedidos</a>
            </div>
            <a href="/" class="btn btn-link">Voltar</a>
        </div>
    </body>

    </html>