package com.delivery.DeliveryApp.persistence;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.delivery.DeliveryApp.model.Ingrediente;
import com.delivery.DeliveryApp.repository.IngredienteRepository;

@Service
public class IngredienteService {
    @Autowired
    private IngredienteRepository repository;

    // Função para listar os ingredientes
    public List<Ingrediente> findAll() {
        return repository.findAll();
    }

    public Optional<Ingrediente> findById(int id) {
        return repository.findById(id);
    }

    // Função para buscar um ingrediente em específico
    public Ingrediente getIngredienteById(int id) {
        return repository.getReferenceById(id);
    }

    // Método para salvar ou atualizar o ingrediente
    public Ingrediente save(Ingrediente entity) {
        return repository.save(entity);
    }

    // Método para deletar ingrediente
    public void deleteIngrediente(int id) {
        repository.deleteById(id);
    }

    public void deleteById(int id) {
        repository.deleteById(id);
    }

    // SRP (SOLID): Serviço apenas para lógica de ingrediente
}
