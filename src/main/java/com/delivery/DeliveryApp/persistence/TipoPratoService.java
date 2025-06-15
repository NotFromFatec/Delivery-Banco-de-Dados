package com.delivery.DeliveryApp.persistence;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.delivery.DeliveryApp.model.TipoPrato;
import com.delivery.DeliveryApp.repository.TipoPratoRepository;

@Service
public class TipoPratoService {
    @Autowired
    private TipoPratoRepository repository;

    // Função para listar os Tipos de Pratos
    public List<TipoPrato> findAll() {
        return repository.findAll();
    }

    public Optional<TipoPrato> findById(int id) {
        return repository.findById(id);
    }

    // Função para buscar um Tipo de Prato em específico
    public TipoPrato getTipoPratoById(int id) {
        return repository.getReferenceById(id);
    }

    // Método para salvar ou atualizar o Tipo de Prato
    public TipoPrato save(TipoPrato entity) {
        return repository.save(entity);
    }

    // Método para deletar Tipo de Prato
    public void deleteById(int id) {
        repository.deleteById(id);
    }

    // SRP (SOLID): Serviço apenas para lógica de Tipo de Prato
}
