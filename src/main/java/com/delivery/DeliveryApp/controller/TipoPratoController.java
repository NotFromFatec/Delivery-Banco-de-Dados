package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.TipoPrato;
import com.delivery.DeliveryApp.persistence.TipoPratoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/dashboard/tipos")
public class TipoPratoController {
    @Autowired
    private TipoPratoService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("tipos", service.findAll());
        return "tipos/list";
    }

    @GetMapping("/novo")
    public String novoForm(Model model) {
        model.addAttribute("tipoPrato", new TipoPrato());
        return "tipos/form";
    }

    @PostMapping
    public String salvar(@ModelAttribute TipoPrato tipoPrato) {
        service.save(tipoPrato);
        return "redirect:/dashboard/tipos";
    }

    @GetMapping("/editar/{id}")
    public String editarForm(@PathVariable int id, Model model) {
        model.addAttribute("tipoPrato", service.findById(id).orElse(new TipoPrato()));
        return "tipos/form";
    }

    @GetMapping("/deletar/{id}")
    public String deletar(@PathVariable int id) {
        service.deleteById(id);
        return "redirect:/dashboard/tipos";
    }
}
