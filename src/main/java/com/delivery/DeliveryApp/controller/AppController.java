package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.Cliente;
import com.delivery.DeliveryApp.model.Prato;
import com.delivery.DeliveryApp.model.TamanhoPorcao;
import com.delivery.DeliveryApp.model.Pedido;
import com.delivery.DeliveryApp.model.ItemPedido;
import com.delivery.DeliveryApp.persistence.ClienteService;
import com.delivery.DeliveryApp.persistence.PratoService;
import com.delivery.DeliveryApp.persistence.TamanhoPorcaoService;
import com.delivery.DeliveryApp.persistence.PedidoService;
import com.delivery.DeliveryApp.persistence.ItemPedidoService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;

/**
 * SRP: Controla apenas a navegação da área do cliente.
 */
@Controller
public class AppController {
    @Autowired
    private PratoService pratoService;
    @Autowired
    private TamanhoPorcaoService porcaoService;
    @Autowired
    private ClienteService clienteService;
    @Autowired
    private PedidoService pedidoService;
    @Autowired
    private ItemPedidoService itemPedidoService;

    @GetMapping("/app")
    public String appHome(Model model) {
        List<Prato> pratos = pratoService.findAll();
        List<TamanhoPorcao> porcoes = porcaoService.findAll();
        model.addAttribute("pratos", pratos);
        model.addAttribute("porcoes", porcoes);
        return "app";
    }

    @GetMapping("/app/criar-conta")
    public String criarContaForm(Model model) {
        model.addAttribute("cliente", new Cliente());
        return "app-criar-conta";
    }

    @PostMapping("/app/criar-conta")
    public String criarConta(@ModelAttribute Cliente cliente, Model model) {
        clienteService.save(cliente);
        model.addAttribute("cliente", cliente);
        return "redirect:/app";
    }

    @GetMapping("/app/pedidos/{cpf}")
    public String pedidosCliente(@PathVariable String cpf, Model model) {
        List<Pedido> pedidos = pedidoService.findAll(); // Filtro por cliente pode ser adicionado
        model.addAttribute("pedidos", pedidos.stream().filter(p -> p.getCliente().getCpf().equals(cpf)).toList());
        return "app-pedidos";
    }

    @PostMapping("/app")
    public String fazerPedido(HttpServletRequest request, Model model) {
        String cpf = request.getParameter("cpf");
        if (cpf == null || cpf.isEmpty()) {
            model.addAttribute("erro", "Você precisa estar logado para fazer um pedido.");
            return "redirect:/app";
        }
        Cliente cliente = clienteService.findById(cpf).orElse(null);
        if (cliente == null) {
            model.addAttribute("erro", "Cliente não encontrado. Faça login ou crie uma conta.");
            return "redirect:/app";
        }
        Pedido pedido = new Pedido();
        pedido.setCliente(cliente);
        pedido.setData(LocalDateTime.now());
        double valorTotal = 0.0;
        // Montar itens do pedido a partir dos parâmetros do formulário
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
        model.addAttribute("mensagem", "Pedido realizado com sucesso!");
        return "redirect:/app/pedidos/" + cpf;
    }

    @GetMapping("/app/validar-cpf")
    @ResponseBody
    public ResponseEntity<?> validarCpf(@RequestParam String cpf) {
        boolean valido = clienteService.findById(cpf).isPresent();
        return ResponseEntity.ok(java.util.Collections.singletonMap("valido", valido));
    }

    @GetMapping("/orders")
    public String allOrders(@RequestParam(value = "done", required = false) Boolean done, Model model) {
        List<Pedido> pedidos = (done == null) ? pedidoService.findAll() : pedidoService.findByDone(done);
        model.addAttribute("pedidos", pedidos);
        model.addAttribute("filterDone", done);
        return "orders";
    }

    @PostMapping("/orders/delete/{id}")
    public String deleteOrder(@PathVariable Long id, @RequestParam(value = "done", required = false) Boolean done) {
        pedidoService.deleteById(id);
        return done == null ? "redirect:/orders" : ("redirect:/orders?done=" + done);
    }

    @PostMapping("/orders/done/{id}")
    public String markOrderDone(@PathVariable Long id, @RequestParam(value = "done", required = false) Boolean done) {
        Pedido pedido = pedidoService.findById(id).orElse(null);
        if (pedido != null) {
            pedido.setDone(true);
            pedidoService.save(pedido);
        }
        return done == null ? "redirect:/orders" : ("redirect:/orders?done=" + done);
    }

    @PostMapping("/orders/undone/{id}")
    public String markOrderUndone(@PathVariable Long id, @RequestParam(value = "done", required = false) Boolean done) {
        Pedido pedido = pedidoService.findById(id).orElse(null);
        if (pedido != null) {
            pedido.setDone(false);
            pedidoService.save(pedido);
        }
        return done == null ? "redirect:/orders" : ("redirect:/orders?done=" + done);
    }
}
