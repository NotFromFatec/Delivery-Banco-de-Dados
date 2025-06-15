package com.delivery.DeliveryApp.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class TamanhoPorcao {
    public enum Tamanho {
        PEQUENO, MEDIO, GRANDE
    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Enumerated(EnumType.STRING)
    private Tamanho nome;
    private Double valor;

    @ManyToOne
    @JoinColumn(name = "prato_id")
    private Prato prato;
}
