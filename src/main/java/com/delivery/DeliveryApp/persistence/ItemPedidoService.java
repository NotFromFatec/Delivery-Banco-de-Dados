package com.delivery.DeliveryApp.persistence;

import com.delivery.DeliveryApp.model.ItemPedido;
import com.delivery.DeliveryApp.repository.ItemPedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

/**
 * SRP: Esta classe é responsável apenas pela lógica de negócio de ItemPedido.
 * OCP: Pode ser estendida para novas regras sem modificar o código existente.
 */
@Service
public class ItemPedidoService {
    @Autowired
    private ItemPedidoRepository repository;

    public List<ItemPedido> findAll() {
        return repository.findAll();
    }

    public Optional<ItemPedido> findById(Long id) {
        return repository.findById(id);
    }

    public ItemPedido save(ItemPedido entity) {
        return repository.save(entity);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
