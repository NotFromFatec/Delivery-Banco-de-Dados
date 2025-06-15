package com.delivery.DeliveryApp.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.delivery.DeliveryApp.model.Ingrediente;

public interface IngredienteRepository extends JpaRepository<Ingrediente, Integer> {
    
}
