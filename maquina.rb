#!/usr/bin/env ruby


class Insumo
    attr_accessor :nombre, :cantidad
    
    def initialize
    end

    def imprimir
        puts "<#{@nombre}> = #{@cantidad}"
    end
end

class InsumoBasico < Insumo
    def initialize(nombre,cantidad)
        @nombre = nombre
        @cantidad = cantidad
    end 
end

class Producto < Insumo
    def initialize(cantidad)
        @nombre = 'Producto Actual'
        @cantidad = cantidad
    end
end


#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE MAQUINA --------------------------
#*******************************************************************************
class Maquina

    #---------- Variables de instancia de la clase Maquina ------------
    attr_accessor :nombre, :desecho, :productoActual, :cantidadMax, :porcentajePA,
                  :ciclosProcesamiento,:estado, :maquinaAnterior
    
    #----------- Constructor de la clase Maquina ------------
    #-- @param nombre  {string correspondiente al nombre de la maquina}
    #-- @param desecho {numero correspondiente al desecho que produce la maquina}
    #-- @param productoActual {instancia de Insumo correspondiente al contenedor
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
    def initialize(nombre,desecho,productoActual,cantidadMax,porcentajePA,
                   ciclosProcesamiento,maquinaSiguiente=nil,productoProcesado=nil)
                   
        #--- Variables de instancia obligatorias al invocar el constructor
        @nombre   = nombre
        @desecho  = desecho
        
        @productoActual      =  productoActual
        @cantidadMax         =  cantidadMax
        @porcentajePA        =  porcentajePA
        @ciclosProcesamiento =  ciclosProcesamiento
        
        #--- Variables de instancia opcionales al invocar el constructor
        @estado              =  "Inactiva"
        @cicloActual         =  ciclosProcesamiento
        @maquinaSiguiente    =  maquinaSiguiente
        @productoProcesado   =  productoProcesado
        @productoHecho       =  0.0
        @PA_Restante         =  0.0
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
    
    end  
 
    #------ Metodo que procesa un ciclo en estado "llenando". -----
    def cicloLlenando
        
    end
     
    #------ Metodo que procesa un ciclo en estado "inactiva". -----
    def cicloInactiva
        #TOODO ESTO CAMBIARA BRUTALMENTE
        #Lo que hay que hacer es chupar del tanque compartido, y si no alcanza
        #guardarlo en la variable de PA_Restante, la funcion cicloEspera debe
        #chequear que el tanque sea 0 para pasar a inactiva, me refiero al
        #cicloEspera de la maquina anterior. si no se entiende escribir al guasap.
        productoActualRequerido = @porcentajePA * @cantidadMax
        
        if @productoActual.cantidad == productoActualRequerido
            @estado = "Llena"
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
            if (@maquinaSiguiente.estado == "Inactiva") && (@productoHecho != 0)
                # Se coloca el material producido por la maquina actual
                # en el contenedor de insumos de la maquina siguiente
                # (recordar que este tanque es el mismo que el de la maquina siguiente
                # son compartidos).
                @productoProcesado.cantidad = @productoHecho
                @productoHecho = 0
            end        
        else

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
        maquina = "Maquina <" + @nombre + ">\n" + "Estado: <" + @estado +">\n"
        
        puts maquina
        #-- Solo se imprimen los insumos asociados a la maquina en caso de 
        #-- que esta se encuentre en estado inactiva o llena
        case @estado
            when "Llena","Inactiva"
                puts "Insumos:"
        end
    end
#--Fin de la clase Maquina
end

ins = Insumo.new
maquina = Maquina.new("M1",1,1,1,1,1)
maquina.imprimir
maquina.cicloLlena
maquina.imprimir
