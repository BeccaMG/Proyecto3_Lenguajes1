#!/usr/bin/env ruby

#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE MAQUINA --------------------------
#*******************************************************************************
module MaquinaCompleja

    attr_accessor :insumoBasico, :porcentajeIB

     
    #------ Metodo que procesa un ciclo en estado "inactiva". -----
    def cicloInactiva
        #Lo que hay que hacer es chupar del tanque compartido, y si no alcanza
        #guardarlo en la variable de productoAnteriorRestante, la funcion 
        #cicloEspera debe chequear que el tanque sea 0 para pasar a inactiva,
        # me refiero al cicloEspera de la maquina anterior. 
        insumoRequerido = @porcentajeIB * @cantidadMax
        
        if @insumoRequerido >= insumoBasico.cantidad     
        
            if @productoAnterior != nil
                productoAnteriorRequerido = @porcentajePA * @cantidadMax
                       
                    if @productoAnterior.cantidad >= cantidadAObtener
                        @productoAnterior.cantidad -= cantidadAObtener
                        insumoBasico.cantidad      -= insumoRequerido
                        @productoAnteriorRestante = 0.0
                        @estado = "Llena"
                    else
                        @productoAnteriorRestante = @productoAnterior.cantidad
                        @productoAnterior.cantidad = 0
                    end
            else
                insumoBasico.cantidad      -= insumoRequerido
                @estado = "Llena"
            end
        end
    end
#--Fin de la clase Maquina
end


