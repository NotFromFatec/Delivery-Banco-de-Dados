package com.delivery.DeliveryApp.model;

import java.util.List;
import java.util.UUID;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Prato {
    @Id
    private String id;
    private String nome;
    private Double valor;
    @ManyToOne
    private TipoPrato tipo;

    @OneToMany(mappedBy = "prato", fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TamanhoPorcao> tamanhos;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "prato_ingrediente",
        joinColumns = @JoinColumn(name = "prato_id"),
        inverseJoinColumns = @JoinColumn(name = "ingrediente_id")
    )
    private List<Ingrediente> ingredientes;


    @PrePersist
    private void gerarId() {
        if (this.id == null) {
            this.id = "P" + UUID.randomUUID().toString().replace("-", "").substring(0, 10).toUpperCase();
        }
    }
}
