#!/usr/bin/env ruby
require_relative 'insumo'

#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE PRODUCTO -------------------------
#*******************************************************************************

class Producto < Insumo

    # ---- Constructor para la Subclase Producto ---- #
    def initialize(cantidad)
        @nombre = 'Producto Anterior'
        @cantidad = cantidad
    end
end