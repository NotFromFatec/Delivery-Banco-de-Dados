package com.delivery.DeliveryApp.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PratoIngrediente {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private Prato prato;
    @ManyToOne
    private Ingrediente ingrediente;
    @ManyToOne
    private TamanhoPorcao porcao;
    // SRP: Relaciona prato, ingrediente e porção

    public Ingrediente getIngrediente() {
        return this.ingrediente;
    }
}
