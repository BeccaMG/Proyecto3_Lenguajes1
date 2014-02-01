#!/usr/bin/env ruby
require_relative 'insumo'

#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE INSUMO ---------------------------
#*******************************************************************************

class InsumoBasico < Insumo
    
    # ---- Constructor para la Subclase InsumoBasico ---- #
    def initialize(nombre,cantidad)
        @nombre = nombre
        @cantidad = cantidad
    end 
end