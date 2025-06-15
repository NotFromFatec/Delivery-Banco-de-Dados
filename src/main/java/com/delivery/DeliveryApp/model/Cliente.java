package com.delivery.DeliveryApp.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Cliente {
    @Id
    private String cpf;
    private String nome;
    private String telefone;
    private String logradouro;
    private String numero;
    private String cep;
    private String pontoReferencia;
}
