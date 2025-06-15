package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.Prato;
import com.delivery.DeliveryApp.model.Ingrediente;
import com.delivery.DeliveryApp.model.TamanhoPorcao;
import com.delivery.DeliveryApp.persistence.PratoService;
import com.delivery.DeliveryApp.persistence.TipoPratoService;
import com.delivery.DeliveryApp.persistence.IngredienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/dashboard/pratos")
public class PratoController {
    @Autowired
    private PratoService service;
    @Autowired
    private TipoPratoService tipoService;
    @Autowired
    private IngredienteService ingredienteService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("pratos", service.findAll());
        return "pratos/list";
    }

    @GetMapping("/novo")
    public String novoForm(Model model) {
        model.addAttribute("prato", new Prato());
        model.addAttribute("tipos", tipoService.findAll());
        model.addAttribute("ingredientes", ingredienteService.findAll());
        return "pratos/form";
    }

    @PostMapping
    public String salvar(@ModelAttribute Prato prato, @RequestParam("ingredientesIds") List<Integer> ingredientesIds, @RequestParam("tamanhosNomes") List<String> tamanhosNomes, @RequestParam("tamanhosValores") List<Double> tamanhosValores) {
        // Set ingredientes
        List<Ingrediente> ingredientes = ingredienteService.findAll().stream().filter(i -> ingredientesIds.contains(i.getId())).toList();
        prato.setIngredientes(ingredientes);
        // Set tamanhos
        List<TamanhoPorcao> tamanhos = new java.util.ArrayList<>();
        for (int i = 0; i < tamanhosNomes.size(); i++) {
            TamanhoPorcao tp = new TamanhoPorcao();
            tp.setNome(TamanhoPorcao.Tamanho.valueOf(tamanhosNomes.get(i)));
            tp.setValor(tamanhosValores.get(i));
            tp.setPrato(prato);
            tamanhos.add(tp);
        }
        prato.setTamanhos(tamanhos);
        service.save(prato);
        return "redirect:/dashboard/pratos";
    }

    @GetMapping("/editar/{id}")
    public String editarForm(@PathVariable String id, Model model) {
        Prato prato = service.findById(id).orElse(new Prato());
        model.addAttribute("prato", prato);
        model.addAttribute("tipos", tipoService.findAll());
        model.addAttribute("ingredientes", ingredienteService.findAll());
        return "pratos/form";
    }

    @GetMapping("/deletar/{id}")
    public String deletar(@PathVariable String id) {
        service.deleteById(id);
        return "redirect:/dashboard/pratos";
    }
}
