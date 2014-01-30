#!/usr/bin/env ruby
#*******************************************************************************
#----------------- IMPLEMENTACION DE LA CLASE MAQUINA --------------------------
#*******************************************************************************
class Maquina

    #----------- Constructor de la clase Maquina ------------
    #-- @param nombre {string correspondiente al nombre de la maquina}
    def initialize(nombre)
        @nombre=nombre
        @cantidadMax=cantMax
        @desecho=desecho
        @ciclosProc=ciclosProc
        @estado=estado
        @maquinaAnterior
        @maquinaSiguiente
    end


    #--------- Modifica el estado actual de la Maquina -------
    #-- @param estado {string correspondiente al estado de la maquina}
    def setEstado(estado)
        @estado_maquina=estado
    end

    #--------- Retorna el estado actual de la Maquina --------
    #-- @return estado_maquina {string correspondiente al estado de la maquina}
    def getEstado
        puts @estado_maquina
    end
    
    #------ Representacion en String de la clase Maquina. -----
    #-- Imprime en pantalla dicha representacion
    def print
        puts ("[" + @nombre_maquina + " : " + @estado_maquina+"]")
    end
    
#--Fin de la clase Maquina
end
