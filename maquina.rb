#!/usr/bin/env ruby
require_relative 'producto'
require_relative 'maquinaFinal'

#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE MAQUINA --------------------------
#*******************************************************************************
class Maquina

    #---------- Variables de instancia de la clase Maquina ------------
    attr_accessor :nombre, :desecho, :productoAnterior, :cantidadMax, 
                  :porcentajePA, :ciclosProcesamiento,:estado, :maquinaAnterior
    
    #----------- Constructor de la clase Maquina ------------
    #-- @param nombre  {string correspondiente al nombre de la maquina}
    #-- @param desecho {numero correspondiente al desecho que produce la maquina}
    #-- @param productoAnterior {instancia de Insumo correspondiente al contenedor
    #-- del Insumo PA de la maquina. A su vez, indica el contenedor en el que
    #-- la maquina anterior deposita el producto manufacturado
    #--
    #-- estado de la maquina, una
    #--        maquina recien cerada es inactiva por defecto}
    #-- @param cantidadMax {numero correspondiente a la cantidad maxima de 
    #--        insumos soportado por la maquina}
    #-- @param porcentajePA {numero correspondiente al porcentaje
    #--        de insumo soportado por de la maquina}
    #-- @param ciclosProcesamiento {numero correspondiente a los ciclos de
    #--        procesamiento requeridos por la maquina}
    #-- @param maquinaAnterior {Maquina.class un apuntador a la maquina previa}
    #-- @param productoProcesado {Instancia de Producto PA correspondiente al
    #--        contenedor de insumos de la siguiente maquina del proceso. Si es
    #--        nil se trata de la ultima maquina}
    def initialize(nombre,desecho,cantidadMax,porcentajePA,ciclosProcesamiento,
                    maquinaSiguiente,productoAnterior,productoProcesado)
                   
        #--- Variables de instancia obligatorias al invocar el constructor
        @nombre   = nombre
        @desecho  = desecho

        @cantidadMax         =  cantidadMax
        @porcentajePA        =  porcentajePA
        @ciclosProcesamiento =  ciclosProcesamiento
        
        @maquinaSiguiente    =  maquinaSiguiente
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
            when "Llenando"
                cicloLlenando
        end
        imprimir
    end  
 
    #------ Metodo que procesa un ciclo en estado "llenando". -----
    def cicloLlenando
        
    end
     
    #------ Metodo que procesa un ciclo en estado "inactiva". -----
    def cicloInactiva
        #Lo que hay que hacer es chupar del tanque compartido, y si no alcanza
        #guardarlo en la variable de productoAnteriorRestante, la funcion cicloEspera debe
        #chequear que el tanque sea 0 para pasar a inactiva, me refiero al
        #cicloEspera de la maquina anterior. si no se entiende escribir al guasap.
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
        
        puts "[Maquina: #{@nombre} Lleva en su tanque anterior" 
        @productoProcesado.imprimir
        puts "\n"
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
        maquina = "\nMaquina " + @nombre + "\n" + "Estado: " + @estado +"\n\n"
        
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
