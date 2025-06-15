package com.delivery.DeliveryApp.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.delivery.DeliveryApp.model.Prato;

public interface PratoRepository extends JpaRepository<Prato, String> {
    @Query(value = "SELECT nomePrato, nomeIngrediente FROM fn_listarPratos()", nativeQuery = true)
    List<Object[]> listarPratosComIngredientes();
}
