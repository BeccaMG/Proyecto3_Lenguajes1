#!/usr/bin/env ruby

#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE MAQUINA --------------------------
#*******************************************************************************
module MaquinaFinal

    #------ Metodo que procesa un ciclo en estado "espera". -----
    def cicloEspera
        @cervezas = (@productoHecho.floor * 4)
        @productoProcesado.cantidad += @cervezas
        @productoHecho = 0
        @estado = "Inactiva"
    end   
    
    def imprimir
         maquina = "Maquina " + @nombre + "\n" + "Estado: " + @estado
        
        puts maquina
        #-- Solo se imprimen los insumos asociados a la maquina en caso de 
        #-- que esta se encuentre en estado inactiva o llena
        case @estado
            when "Llena","Inactiva"
                unless @productoAnterior.nil?
                    @productoAnterior.imprimir
                end
        end
        unless @cervezas==0
            puts "Cervezas salientes: #{@cervezas}"
        end
    end
        
end


