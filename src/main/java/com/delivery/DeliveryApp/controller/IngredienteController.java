package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.Ingrediente;
import com.delivery.DeliveryApp.persistence.IngredienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/dashboard/ingredientes")
public class IngredienteController {
    @Autowired
    private IngredienteService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("ingredientes", service.findAll());
        return "ingredientes/list";
    }

    @GetMapping("/novo")
    public String novoForm(Model model) {
        model.addAttribute("ingrediente", new Ingrediente());
        return "ingredientes/form";
    }

    @PostMapping
    public String salvar(@ModelAttribute Ingrediente ingrediente) {
        service.save(ingrediente);
        return "redirect:/dashboard/ingredientes";
    }

    @GetMapping("/editar/{id}")
    public String editarForm(@PathVariable int id, Model model) {
        model.addAttribute("ingrediente", service.findById(id).orElse(new Ingrediente()));
        return "ingredientes/form";
    }

    @GetMapping("/deletar/{id}")
    public String deletar(@PathVariable int id) {
        service.deleteById(id);
        return "redirect:/dashboard/ingredientes";
    }
}
