package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.Cliente;
import com.delivery.DeliveryApp.persistence.ClienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * SRP: Controla apenas operações de Cliente.
 * OCP: Pode ser estendido para novas regras sem modificar o código existente.
 */
@Controller
@RequestMapping("/dashboard/clientes")
public class ClienteController {
    @Autowired
    private ClienteService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("clientes", service.findAll());
        return "clientes/list";
    }

    @GetMapping("/novo")
    public String novoForm(Model model) {
        model.addAttribute("cliente", new Cliente());
        return "clientes/form";
    }

    @PostMapping
    public String salvar(@ModelAttribute Cliente cliente) {
        service.save(cliente);
        return "redirect:/dashboard/clientes";
    }

    @GetMapping("/editar/{cpf}")
    public String editarForm(@PathVariable String cpf, Model model) {
        model.addAttribute("cliente", service.findById(cpf).orElse(new Cliente()));
        return "clientes/form";
    }

    @GetMapping("/deletar/{cpf}")
    public String deletar(@PathVariable String cpf) {
        service.deleteById(cpf);
        return "redirect:/dashboard/clientes";
    }
}
