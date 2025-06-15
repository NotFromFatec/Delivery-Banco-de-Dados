package com.delivery.DeliveryApp.controller;

import com.delivery.DeliveryApp.model.Prato;
import com.delivery.DeliveryApp.model.TipoPrato;
import com.delivery.DeliveryApp.model.Pedido;
import com.delivery.DeliveryApp.persistence.PratoService;
import com.delivery.DeliveryApp.persistence.TipoPratoService;
import com.delivery.DeliveryApp.persistence.PedidoService;
import com.lowagie.text.Document;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import com.lowagie.text.ListItem;

/**
 * SRP: Controla apenas a navegação do dashboard.
 */
@Controller
public class DashboardController {
    @Autowired
    private TipoPratoService tipoPratoService;
    @Autowired
    private PratoService pratoService;
    @Autowired
    private PedidoService pedidoService;

    @GetMapping("/dashboard")
    public String dashboardHome() {
        return "dashboard";
    }

    @GetMapping("/dashboard/relatorios")
    public String relatoriosForm(Model model) {
        model.addAttribute("tipos", tipoPratoService.findAll());
        return "relatorios";
    }

    @GetMapping("/dashboard/relatorios/pratos-por-tipo")
    public void gerarRelatorioPratosPorTipo(@RequestParam Long tipoId, HttpServletResponse response) throws Exception {
        TipoPrato tipo = tipoPratoService.findById(tipoId.intValue()).orElse(null);
        if (tipo == null) return;
        List<Prato> pratos = pratoService.findAll().stream().filter(p -> p.getTipo().getId() == tipoId.intValue()).toList();
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=pratos_tipo.pdf");
        Document doc = new Document();
        PdfWriter.getInstance(doc, response.getOutputStream());
        doc.open();
        doc.add(new Paragraph("Relatório de Pratos do Tipo: " + tipo.getNome()));
        doc.add(new Paragraph(" "));
        for (Prato prato : pratos) {
            doc.add(new Paragraph("Prato: " + prato.getNome()));
            doc.add(new Paragraph("Ingredientes:"));
            com.lowagie.text.List ingList = new com.lowagie.text.List(false, 10);
            for (var ingrediente : prato.getIngredientes()) {
                if (ingrediente != null) {
                    ingList.add(new ListItem(ingrediente.getNome() + " (" + ingrediente.getFormatoApresentacao() + ")"));
                }
            }
            doc.add(ingList);
            doc.add(new Paragraph(" "));
        }
        doc.close();
    }

    @GetMapping("/dashboard/relatorios/pedido-cliente")
    public void gerarRelatorioPedidoCliente(@RequestParam Long pedidoId, HttpServletResponse response) throws Exception {
        Pedido pedido = pedidoService.findById(pedidoId).orElse(null);
        if (pedido == null) return;
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=pedido_cliente.pdf");
        Document doc = new Document();
        PdfWriter.getInstance(doc, response.getOutputStream());
        doc.open();
        doc.add(new Paragraph("Relatório do Pedido #" + pedido.getId()));
        doc.add(new Paragraph("Cliente: " + pedido.getCliente().getNome() + " (" + pedido.getCliente().getCpf() + ")"));
        doc.add(new Paragraph("Data: " + pedido.getData()));
        doc.add(new Paragraph("Valor Total: R$ " + pedido.getValorTotal()));
        doc.add(new Paragraph("Itens:"));
        com.lowagie.text.List itensList = new com.lowagie.text.List(false, 10);
        for (var item : pedido.getItens()) {
            String desc = item.getQuantidade() + "x " + item.getPrato().getNome() + " (" + item.getPorcao().getNome() + ") - R$ " + item.getPorcao().getValor();
            itensList.add(new ListItem(desc));
        }
        doc.add(itensList);
        doc.close();
    }

    @GetMapping("/dashboard/relatorios/por-dia")
    public void gerarRelatorioPorDia(@RequestParam String data, HttpServletResponse response) throws Exception {
        LocalDate dia = LocalDate.parse(data, DateTimeFormatter.ISO_DATE);
        List<Pedido> pedidos = pedidoService.findAll().stream()
            .filter(p -> p.getData().toLocalDate().equals(dia))
            .toList();
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=relatorio_dia.pdf");
        Document doc = new Document();
        PdfWriter.getInstance(doc, response.getOutputStream());
        doc.open();
        doc.add(new Paragraph("Relatório de Pedidos do dia: " + data));
        doc.add(new Paragraph(" "));
        for (Pedido pedido : pedidos) {
            doc.add(new Paragraph("Pedido #" + pedido.getId() + " - Cliente: " + pedido.getCliente().getNome() + " (" + pedido.getCliente().getCpf() + ")"));
            doc.add(new Paragraph("Valor Total: R$ " + pedido.getValorTotal()));
            com.lowagie.text.List itensList = new com.lowagie.text.List(false, 10);
            for (var item : pedido.getItens()) {
                String desc = item.getQuantidade() + "x " + item.getPrato().getNome() + " (" + item.getPorcao().getNome() + ") - R$ " + item.getPorcao().getValor();
                itensList.add(new ListItem(desc));
            }
            doc.add(itensList);
            doc.add(new Paragraph(" "));
        }
        doc.close();
    }
}
