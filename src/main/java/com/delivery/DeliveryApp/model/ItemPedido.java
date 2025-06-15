package com.delivery.DeliveryApp.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ItemPedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private Pedido pedido;
    @ManyToOne
    private Prato prato;
    @ManyToOne
    private TamanhoPorcao porcao;
    private Integer quantidade;
    // SRP: ItemPedido representa apenas o item do pedido
}
