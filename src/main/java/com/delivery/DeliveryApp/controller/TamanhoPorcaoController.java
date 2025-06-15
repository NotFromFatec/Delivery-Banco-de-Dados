package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.TamanhoPorcao;
import com.delivery.DeliveryApp.persistence.TamanhoPorcaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/dashboard/porcoes")
public class TamanhoPorcaoController {
    @Autowired
    private TamanhoPorcaoService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("porcoes", service.findAll());
        return "porcoes/list";
    }

    @GetMapping("/novo")
    public String novoForm(Model model) {
        model.addAttribute("porcao", new TamanhoPorcao());
        return "porcoes/form";
    }

    @PostMapping
    public String salvar(@ModelAttribute TamanhoPorcao porcao) {
        service.save(porcao);
        return "redirect:/dashboard/porcoes";
    }

    @GetMapping("/editar/{id}")
    public String editarForm(@PathVariable int id, Model model) {
        model.addAttribute("porcao", service.findById(id).orElse(new TamanhoPorcao()));
        return "porcoes/form";
    }

    @GetMapping("/deletar/{id}")
    public String deletar(@PathVariable int id) {
        service.deleteById(id);
        return "redirect:/dashboard/porcoes";
    }
}
