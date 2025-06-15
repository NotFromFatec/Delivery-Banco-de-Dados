package com.delivery.DeliveryApp.model;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Pedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDateTime data;

    @ManyToOne
    private Cliente cliente;

    private Double valorTotal;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable (
        name = "pratoPedidos",
        joinColumns = @JoinColumn(name = "pedido_id"),
        inverseJoinColumns = @JoinColumn(name = "prato_id")
    )
    private List<Prato> pratos;

    @OneToMany(mappedBy = "pedido", fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    private java.util.List<ItemPedido> itens;

    private boolean done = false; // Pedido concluído ou não

    public void setItens(java.util.List<ItemPedido> itens) {
        this.itens = itens;
    }
    public java.util.List<ItemPedido> getItens() {
        return this.itens;
    }
    public void setData(LocalDateTime data) {
        this.data = data;
    }
    public LocalDateTime getData() {
        return this.data;
    }
}
