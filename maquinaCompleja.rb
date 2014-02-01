#!/usr/bin/env ruby
require_relative 'insumoBasico'

#*******************************************************************************
#-------------- IMPLEMENTACION DEL MIX-IN MAQUINA COMPLEJA ---------------------
#*******************************************************************************
module MaquinaCompleja

    attr_accessor :insumoBasico, :porcentajeIB

     
    #------ Metodo que procesa un ciclo en estado "inactiva". -----
    def cicloInactiva
        
        #-- Se calcula la cantidad de insumo basico requerido por la maquina C 
        insumoRequerido = @porcentajeIB * @cantidadMax
        
        #-- Unicamente si se tiene la cantidad requerida de insumo basico
        #-- en el contenedor, se procede a analizar el resto de la mezcla
        if @insumoBasico.cantidad >= insumoRequerido  
        
            #-- Caso en el que la maquina posee un contenedor de enlace
            #-- con una maquina anterior.
            if @productoAnterior != nil
                #-- Se calcula la cantidad de producto anterior requerido
                #-- por la maquina Compleja
                productoAnteriorRequerido = @porcentajePA * @cantidadMax
                cantidadAObtener = productoAnteriorRequerido - @productoAnteriorRestante 
                       
                    #-- Caso en el que el producto encontrado en el contenedor
                    #-- es suficiente para comenzar el procesamiento de 
                    #-- la maquina
                    if @productoAnterior.cantidad >= cantidadAObtener
                    
                        #-- Se resta la cantidad necesaria para comenzar a 
                        #-- procesar de la cantidad encontrada en el contenedor
                        @productoAnterior.cantidad -= cantidadAObtener
                        
                        #-- Se disminuye la cantidad de insumo basico del 
                        #-- contenedor
                        insumoBasico.cantidad      -= insumoRequerido
                        @productoAnteriorRestante = 0.0
                        
                        #-- La maquina pasa al estado LLena
                        @estado = "Llena"
                        
                    #-- Caso en el que el producto encontrado en el contenedor
                    #-- no es el suficiente para comenzar el procesamiento de
                    #-- de la maquina
                    else
                        #-- Se recolecta en su totalidad la fraccion restante 
                        #-- de producto anterior del contenedor
                        @productoAnteriorRestante = @productoAnterior.cantidad
                        @productoAnterior.cantidad = 0
                    end
                    
            #-- Caso en el que la maquina corresponde a la primera dentro
            #-- del proceso de produccion. Unicamente se verifica el insumo
            #-- basico, pues no se depende de ningun producto anterior.
            else
                insumoBasico.cantidad      -= insumoRequerido
                
                #-- La maquina pasa al estado LLena
                @estado = "Llena"
            end
        end
    end
#--Fin de la clase Maquina
end
