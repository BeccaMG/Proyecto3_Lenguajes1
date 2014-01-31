#!/usr/bin/env ruby
$LOAD_PATH << '.'
include "insumo"
#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE MAQUINA --------------------------
#*******************************************************************************
class Maquina

    #---------- Variables de instancia de la clase Maquina ------------
    attr_accessor :nombre, :desecho, :productoAactual, :cantidadMax, :porcentajeMezcla,
                  :ciclosProcesamiento,:estado, :maquinaAnterior
    
    #----------- Constructor de la clase Maquina ------------
    #-- @param nombre  {string correspondiente al nombre de la maquina}
    #-- @param desecho {numero correspondiente al desecho que produce la maquina}
    #-- @param cantidadMax {numero correspondiente a la cantidad maxima de 
    #--        insumos soportado por la maquina}
    #-- @param porcentajeMezcla {numero correspondiente al porcentaje
    #--        de insumo soportado por de la maquina}
    #-- @param ciclosProcesamiento {numero correspondiente a los ciclos de
    #--        procesamiento requeridos por la maquina}
    #-- @param estado {string correspondiente al estado de la maquina, una
    #--        maquina recien cerada es inactiva por defecto}
    #-- @param maquinaAnterior {Maquina.class un apuntador a la maquina previa}
    def initialize(nombre,desecho,productoActual,cantidadMax,porcentajeMezcla,
                   ciclosProcesamiento,estado="Inactiva",maquinaAnterior=nil)
                   
        #--- Variables de instancia obligatorias al invocar el constructor
        @nombre   = nombre
        @desecho  = desecho
        
        @productoActual      =  productoActual
        @cantidadMax         =  cantidadMax
        @porcentajeMezcla    =  porcentajeMezcla
        @ciclosProcesamiento =  ciclosProcesamiento
        
        #--- Variables de instancia opcionales al invocar el constructor
        @estado              = estado
        @maquinaAnterior     =  maquinaAnterior
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
        
    end
    
    #------ Metodo que procesa un ciclo en estado "procesando". -----
    def cicloProcesamiento
                
    end    
    
    #------ Metodo que procesa un ciclo en estado "espera". -----
    def cicloEspera
        
    end    
    
    #------ Metodo que procesa un ciclo en estado "llena". -----
    def cicloLlena
       
    end    
    
       
    #------ Representacion en String de la clase Maquina. -----
    #-- Imprime en pantalla dicha representacion
    def imprimir
        maquina = "Maquina <" + @nombre + ">\n" + "Estado: <" + @estado +">\n"
        
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
maquina = Maquina.new("M1",1,1,1,1,"Espera",ins)
maquina.imprimir
maquina.cicloLlena
