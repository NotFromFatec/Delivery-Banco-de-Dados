package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.Pedido;
import com.delivery.DeliveryApp.persistence.PedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class PedidoController {
    @Autowired
    private PedidoService service;

    @GetMapping("/dashboard/pedidos")
    public String list(Model model) {
        model.addAttribute("pedidos", service.findAll());
        return "pedidos/list";
    }

    @GetMapping("/dashboard/pedidos/novo")
    public String novoForm(Model model) {
        model.addAttribute("pedido", new Pedido());
        return "pedidos/form";
    }

    @PostMapping("/dashboard/pedidos")
    public String salvar(@ModelAttribute Pedido pedido) {
        service.save(pedido);
        return "redirect:/dashboard/pedidos";
    }

    @GetMapping("/dashboard/pedidos/editar/{id}")
    public String editarForm(@PathVariable Long id, Model model) {
        model.addAttribute("pedido", service.findById(id).orElse(new Pedido()));
        return "pedidos/form";
    }

    @GetMapping("/dashboard/pedidos/deletar/{id}")
    public String deletar(@PathVariable Long id) {
        service.deleteById(id);
        return "redirect:/dashboard/pedidos";
    }
}
