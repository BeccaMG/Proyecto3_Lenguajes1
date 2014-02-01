#!/usr/bin/env ruby
require_relative 'producto'

#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE MAQUINA --------------------------
#*******************************************************************************
class Maquina

    #---------- Variables de instancia de la clase Maquina ------------
    attr_accessor :nombre, :desecho, :productoAnterior, :cantidadMax, 
                  :porcentajePA, :ciclosProcesamiento,:estado, :maquinaAnterior
    
    #----------- Constructor de la clase Maquina ------------
    def initialize(nombre,desecho,cantidadMax,porcentajePA,ciclosProcesamiento,
                   productoAnterior,productoProcesado)
                   
        #--- Variables de instancia obligatorias al invocar el constructor
        @nombre   = nombre
        @desecho  = desecho

        @cantidadMax         =  cantidadMax
        @porcentajePA        =  porcentajePA
        @ciclosProcesamiento =  ciclosProcesamiento
        
        @productoAnterior    =  productoAnterior
        @productoProcesado   =  productoProcesado
        
        #--- Variables de instancia opcionales al invocar el constructor
        @estado              =  "Inactiva"
        @cicloActual         =  ciclosProcesamiento
        @productoHecho            =  0.0
        @productoAnteriorRestante =  0.0
    end

    #---------- Metodo que ejecuta un ciclo de procesamiento ----------
    def procesamiento
    
        case @estado       
            when "Inactiva"
                cicloInactiva
            when "Procesando"
                cicloProcesamiento
            when "Espera"
                cicloEspera
            when "Llena"
                cicloLlena
        end
        imprimir
    end  

     
    #------ Metodo que procesa un ciclo en estado "inactiva". -----
    def cicloInactiva
        productoAnteriorRequerido = @porcentajePA * @cantidadMax
        cantidadAObtener = productoAnteriorRequerido - @productoAnteriorRestante 

        if @productoAnterior.cantidad >= cantidadAObtener
            @productoAnterior.cantidad -= cantidadAObtener
            @productoAnteriorRestante = 0.0
            @estado = "Llena"
        else
            @productoAnteriorRestante += @productoAnterior.cantidad
            @productoAnterior.cantidad = 0
        end
        
    end
    
    #------ Metodo que procesa un ciclo en estado "procesando". -----
    def cicloProcesamiento
        #-- Caso en el que aun no acaba de procesarse el producto ---
        if @cicloActual > 0
        # Se decrementa el numero de ciclos
            @cicloActual = @cicloActual - 1
        
        #-- Caso en el que los ciclos de procesamiento fueron cumplidos    
        else
            # El numero de ciclo era 0, por lo que se reinicia, se obtiene la
            # cantidad de producto manufacturado y se en una variable antes de
            # ser transferido a la siguiente maquina.
            @cicloActual = @ciclosProcesamiento
            @productoHecho = @cantidadMax * (1 - @desecho)            
            @estado = "Espera"
        end        
    end    
    
    #------ Metodo que procesa un ciclo en estado "espera". -----
    def cicloEspera
        if @productoProcesado.cantidad == 0
            # Solamente debe transferir si la maquina siguiente esta lista para
            # recibir, esto es, si la maquina siguiente esta inactiva y yo
            # tengo producto para transferir.
            if @productoHecho == 0
                @estado = "Inactiva"
            else
                @productoProcesado.cantidad = @productoHecho
                @productoHecho = 0
            end
        end
    end    
    
    #------ Metodo que procesa un ciclo en estado "llena". -----
    def cicloLlena
       #Es un ciclo de transicion, si la maquina estaba en estado "llena" debe
       #comenzar a procesar en el siguiente ciclo.
       @estado = "Procesando"
    end    
    
       
    #------ Representacion en String de la clase Maquina. -----
    #-- Imprime en pantalla dicha representacion
    def imprimir
        maquina = "Maquina " + @nombre + "\n" + "Estado: " + @estado +""
        
        puts maquina
        #-- Solo se imprimen los insumos asociados a la maquina en caso de 
        #-- que esta se encuentre en estado inactiva o llena
        case @estado
            when "Llena","Inactiva"
                unless @productoAnterior.nil?
                    puts "Insumos:"
                    @productoAnterior.imprimir
                end
        end
    end
#--Fin de la clase Maquina
end