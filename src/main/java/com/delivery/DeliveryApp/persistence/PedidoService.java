package com.delivery.DeliveryApp.persistence;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.delivery.DeliveryApp.model.Pedido;
import com.delivery.DeliveryApp.repository.PedidoRepository;

@Service
public class PedidoService {
    @Autowired
    private PedidoRepository repository;

    // Função para listar os pedidos
    public List<Pedido> listar() {
        return repository.findAll();
    }

    public Optional<Pedido> findById(Long id) {
        return repository.findById(id);
    }

    // Função para buscar um predido em específico
    public Pedido getPedidoById(Long id) {
        return repository.getReferenceById(id);
    }

    // Método para salvar ou atualizar o pedido
    public Pedido save(Pedido entity) {
        return repository.save(entity);
    }

    public void savePedido(Pedido p) {
        repository.save(p);
    }

    // Método para deletar pedido
    public void deleteById(Long id) {
        repository.deleteById(id);
    }

    public void deletePedido(Long id) {
        repository.deleteById(id);
    }

    // SRP (SOLID): Serviço apenas para lógica de pedido

    public java.util.List<Pedido> findAll() {
        return repository.findAll();
    }

    public List<Pedido> findByDone(boolean done) {
        return repository.findByDone(done);
    }
}
