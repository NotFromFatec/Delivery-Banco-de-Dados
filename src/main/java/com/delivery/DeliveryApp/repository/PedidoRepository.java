package com.delivery.DeliveryApp.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.delivery.DeliveryApp.model.Pedido;

import java.util.List;

public interface PedidoRepository extends JpaRepository<Pedido, Long> {
    List<Pedido> findByDone(boolean done);
}
