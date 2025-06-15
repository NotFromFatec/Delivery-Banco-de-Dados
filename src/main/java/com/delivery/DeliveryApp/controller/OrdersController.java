package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.Cliente;
import com.delivery.DeliveryApp.model.Pedido;
import com.delivery.DeliveryApp.model.Prato;
import com.delivery.DeliveryApp.model.TamanhoPorcao;
import com.delivery.DeliveryApp.model.ItemPedido;
import com.delivery.DeliveryApp.persistence.ClienteService;
import com.delivery.DeliveryApp.persistence.PedidoService;
import com.delivery.DeliveryApp.persistence.PratoService;
import com.delivery.DeliveryApp.persistence.TamanhoPorcaoService;
import com.delivery.DeliveryApp.persistence.ItemPedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;

/**
 * SRP: Controla apenas a navegação da área de pedidos (garçom).
 */
@Controller
public class OrdersController {
    @Autowired
    private PedidoService pedidoService;
    @Autowired
    private ClienteService clienteService;
    @Autowired
    private PratoService pratoService;
    @Autowired
    private TamanhoPorcaoService porcaoService;
    @Autowired
    private ItemPedidoService itemPedidoService;

    // @GetMapping("/orders")
    // public String ordersHome(Model model) {
    //     List<Pedido> pedidos = pedidoService.findAll();
    //     model.addAttribute("pedidos", pedidos);
    //     return "orders";
    // }

    @GetMapping("/orders/novo")
    public String novoPedidoForm(Model model) {
        model.addAttribute("pratos", pratoService.findAll());
        model.addAttribute("porcoes", porcaoService.findAll());
        return "orders-novo";
    }

    @PostMapping("/orders/novo")
    public String novoPedido(HttpServletRequest request, Model model) {
        String cpf = request.getParameter("cpf");
        Cliente cliente = clienteService.findById(cpf).orElse(null);
        if (cliente == null) {
            model.addAttribute("erro", "Cliente não encontrado. Cadastre o cliente antes de fazer o pedido.");
            return "redirect:/orders/novo";
        }
        Pedido pedido = new Pedido();
        pedido.setCliente(cliente);
        pedido.setData(LocalDateTime.now());
        double valorTotal = 0.0;
        List<ItemPedido> itens = new java.util.ArrayList<>();
        List<Prato> pratos = pratoService.findAll();
        List<TamanhoPorcao> porcoes = porcaoService.findAll();
        for (Prato prato : pratos) {
            for (TamanhoPorcao porcao : porcoes) {
                String param = "qtd_" + prato.getId() + "_" + porcao.getId();
                String qtdStr = request.getParameter(param);
                if (qtdStr != null && !qtdStr.isEmpty()) {
                    int qtd = 0;
                    try { qtd = Integer.parseInt(qtdStr); } catch (Exception ignored) {}
                    if (qtd > 0) {
                        ItemPedido item = new ItemPedido();
                        item.setPrato(prato);
                        item.setPorcao(porcao);
                        item.setQuantidade(qtd);
                        item.setPedido(pedido);
                        valorTotal += porcao.getValor() * qtd;
                        itens.add(item);
                    }
                }
            }
        }
        pedido.setItens(itens);
        pedido.setValorTotal(valorTotal);
        pedidoService.save(pedido);
        for (ItemPedido item : itens) {
            itemPedidoService.save(item);
        }
        return "redirect:/orders";
    }

    @GetMapping("/orders/deletar/{id}")
    public String deletarPedido(@PathVariable Long id) {
        pedidoService.deleteById(id);
        return "redirect:/orders";
    }
}
