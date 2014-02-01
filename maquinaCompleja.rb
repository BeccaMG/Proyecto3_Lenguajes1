#!/usr/bin/env ruby

#*****************************************************************************
#--------------------- IMPLEMENTACION DE LA CLASE INSUMO ---------------------
#*****************************************************************************
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

# ---------------- SUBCLASE INSUMOBASICO (PADRE INSUMO) ------------------ #
class InsumoBasico < Insumo
    
    # ---- Constructor para la Subclase InsumoBasico ---- #
    def initialize(nombre,cantidad)
        @nombre = nombre
        @cantidad = cantidad
    end 
end

# ------------------- SUBCLASE PRODUCTO (PADRE INSUMO) ------------------- #
class Producto < Insumo

    # ---- Constructor para la Subclase Producto ---- #
    def initialize(cantidad)
        @nombre = 'Producto Anterior'
        @cantidad = cantidad
    end
end


#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE MAQUINA --------------------------
#*******************************************************************************
module MaquinaCompleja
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
            @productoAnteriorRestante = @productoAnterior.cantidad
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
        #MENSAJE INCOMPLETO (MENSAJE SIGNIFICA FUNCION)
        if @productoProcesado.cantidad == 0
            # Solamente debe transferir si la maquina siguiente esta lista para
            # recibir, esto es, si la maquina siguiente esta inactiva y yo
            # tengo producto para transferir.
            @productoProcesado.cantidad = @productoHecho
            @productoHecho = 0
        end
    end    
    
    #------ Metodo que procesa un ciclo en estado "llena". -----
    def cicloLlena
       #Es un ciclo de transicion, si la maquina estaba en estado "llena" debe
       #comenzar a procesar en el siguiente ciclo.
       @estado = "Procesando"
       cicloProcesamiento
    end    
    
       
    #------ Representacion en String de la clase Maquina. -----
    #-- Imprime en pantalla dicha representacion
    def imprimir
        maquina = "Maquina " + @nombre + "\n" + "Estado: " + @estado +"\n"
        
        puts maquina
        #-- Solo se imprimen los insumos asociados a la maquina en caso de 
        #-- que esta se encuentre en estado inactiva o llena
        case @estado
            when "Llena","Inactiva"
                puts "Insumos:\n"
                @productoAnterior.imprimir
        end
    end
#--Fin de la clase Maquina
end


