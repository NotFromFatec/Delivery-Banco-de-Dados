package com.delivery.DeliveryApp.persistence;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.delivery.DeliveryApp.model.Cliente;
import com.delivery.DeliveryApp.repository.ClienteRepository;

@Service
public class ClienteService {
    @Autowired
    private ClienteRepository repository;

    // Função para listar todos os clientes
    public List<Cliente> listarClientes() {
        return repository.findAll();
    }

    public List<Cliente> findAll() {
        return repository.findAll();
    }

    // Função para buscar um cliente em específico
    public Cliente getClienteById(String cpf) {
        return repository.getReferenceById(cpf);
    }

    public Optional<Cliente> findById(String cpf) {
        return repository.findById(cpf);
    }

    // Método para salvar ou atualizar o cliente
    public void saveCliente(Cliente c) {
        repository.save(c);
    }

    public Cliente save(Cliente entity) {
        return repository.save(entity);
    }

    // Método para deletar o cliente
    public void deleCliente(String cpf) {
        repository.deleteById(cpf);
    }

    public void deleteById(String cpf) {
        repository.deleteById(cpf);
    }

    // SRP (SOLID): Serviço apenas para lógica de cliente
}
