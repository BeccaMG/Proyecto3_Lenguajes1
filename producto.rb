#!/usr/bin/env ruby
require_relative 'insumo'

#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE INSUMO ---------------------------
#*******************************************************************************

class Producto < Insumo

    # ---- Constructor para la Subclase Producto ---- #
    def initialize(cantidad)
        @nombre = 'Producto Anterior'
        @cantidad = cantidad
    end
end