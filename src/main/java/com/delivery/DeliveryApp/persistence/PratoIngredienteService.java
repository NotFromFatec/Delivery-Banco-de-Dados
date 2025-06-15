package com.delivery.DeliveryApp.persistence;

import com.delivery.DeliveryApp.model.PratoIngrediente;
import com.delivery.DeliveryApp.repository.PratoIngredienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

/**
 * SRP: Esta classe é responsável apenas pela lógica de negócio de PratoIngrediente.
 * OCP: Pode ser estendida para novas regras sem modificar o código existente.
 */
@Service
public class PratoIngredienteService {
    @Autowired
    private PratoIngredienteRepository repository;

    public List<PratoIngrediente> findAll() {
        return repository.findAll();
    }

    public Optional<PratoIngrediente> findById(Long id) {
        return repository.findById(id);
    }

    public PratoIngrediente save(PratoIngrediente entity) {
        return repository.save(entity);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
