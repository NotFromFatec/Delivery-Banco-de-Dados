package com.delivery.DeliveryApp.persistence;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.delivery.DeliveryApp.model.TamanhoPorcao;
import com.delivery.DeliveryApp.repository.TamanhoPorcaoRepository;

@Service
public class TamanhoPorcaoService {
    @Autowired
    private TamanhoPorcaoRepository repository;

    // Função para listar os Tamanhos de Porções
    public List<TamanhoPorcao> findAll() {
        return repository.findAll();
    }

    public Optional<TamanhoPorcao> findById(int id) {
        return repository.findById(id);
    }

    // Método para salvar ou atualizar o Tamanho da Porcao
    public TamanhoPorcao save(TamanhoPorcao entity) {
        return repository.save(entity);
    }

    // Método para deletar Tamanho da Porcao
    public void deleteById(int id) {
        repository.deleteById(id);
    }

    // SRP (SOLID): Serviço apenas para lógica de Tamanho de Porcao
}
