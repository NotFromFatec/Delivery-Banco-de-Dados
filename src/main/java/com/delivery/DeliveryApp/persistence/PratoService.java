package com.delivery.DeliveryApp.persistence;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.delivery.DeliveryApp.model.Prato;
import com.delivery.DeliveryApp.repository.PratoRepository;

@Service
public class PratoService {
    @Autowired
    private PratoRepository repository;

    // Função para listar os pratos
    public List<Object[]> getPratosComIngredientes() {
        return repository.listarPratosComIngredientes();
    }

    // Função para buscar um prato em específico
    public Prato getPratoById(String id) {
        return repository.getReferenceById(id);
    }

    // Método para salvar ou atualizar o prato
    public void savePrato(Prato p) {
        repository.save(p);
    }

    // Método para deletar prato
    public void deletePrato(String id) {
        repository.deleteById(id);
    }

    public List<Prato> findAll() {
        return repository.findAll();
    }

    public Optional<Prato> findById(String id) {
        return repository.findById(id);
    }

    public Prato save(Prato entity) {
        return repository.save(entity);
    }

    public void deleteById(String id) {
        repository.deleteById(id);
    }

    // SRP (SOLID): Serviço apenas para lógica de prato
}
