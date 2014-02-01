#!/usr/bin/env ruby

#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE INSUMO ---------------------------
#*******************************************************************************

class Insumo
    
    # ---------- Variables de Instancia de la Clase Insumo ---------------- #
    attr_accessor :nombre, :cantidad
    
    # ---------- Constructor de la Clase Insumo ------------- #
    #   El constructor estara implementado en las subclases   #
    def initialize
    end
    
    # ---------- Funcion para imprimir un Insumo ------------ #
    def imprimir
        puts "#{@nombre} #{@cantidad}"
    end
end