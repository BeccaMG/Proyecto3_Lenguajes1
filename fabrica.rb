#!/usr/bin/env ruby

#*****************************************************************************
#-------------------- IMPLEMENTACION DE LA CLASE FABRICA ---------------------
#*****************************************************************************
class Fabrica

    # ---- Atributos de la Clase ---- #
    attr_accessor :numCiclos, :cebada, :arrozMaiz, :levadura, :lupulo

    # ---- Constructor de la Clase ---- #
    def initialize(numCiclos, cebada, arrozMaiz, levadura, lupulo)
        @numCiclos = numCiclos
        @cebada    = cebada
        @arrozMaiz = arrozMaiz
        @levadura  = levadura
        @lupulo    = lupulo
    end

    # ---- Metodo para activar la funcionalidad de la Fabrica ---- #
    # Toma las entradas proporcionadas e imprime la cerveza total y#
    # tambien las cantidades sobrantes de los insumos particulares #
    def activar
        
        puts "Inicio Planta"
        puts "#{@numCiclos}"

        
        # ---- Se crea cada una de las maquinas ---- #

        llenaTapa      = Maquina.new("Llenadora y Tapadora", 0.0, 0, 50, 100, 2, nil, nil)
        tanqueFiltrada = Maquina.new("Tanque para Cerveza Filtrada", 0.0, 0, 100, 100, 0, llenaTapa, nil)
        filtroCerveza  = Maquina.new("Filtro de Cerveza", 0.0, 0, 100, 100, 1, tanqueFiltrada, nil)
        tcc            = MaquinaCompleja.new
        enfriador      = Maquina.new("Enfriador", 0.0, 0, 60, 100, 2, tcc, nil)
        tanque         = Maquina.new("Tanque Pre-Clarificador", 0.01, 0, 35, 100, 1, enfriador, nil)
        pailaCoccion   = MaquinaCompleja.new
        cubaFiltracion = Maquina.new("Cuba de Filtracion", 0.35, 0, 135, 100, 2, pailaCoccion, nil)
        pailaMezcla    = MaquinaCompleja.new
        molino         = Maquina.new("Molino", 0.02, 0, 100, 100, 1, pailaMezcla, nil)
        silosCebada    = MaquinaCompleja.new


        # ---- Se ejecutan los ciclos especificados ---- #
        for i in 1..@numCiclos
            silosCebada.procesamiento
            molino.procesamiento
            pailaMezcla.procesamiento
            cubaFiltracion.procesamiento
            pailaCoccion.procesamiento
            tanque.procesamiento
            enfriador.procesamiento
            ttc.procesamiento
            filtroCerveza.procesamiento
            tanqueFiltrada.procesamiento
            llenaTapa.procesamiento   
        end

        # ---- Se imprimen los resultados ---- #
        puts "Cerveza Total: "
        puts "Cebada Sobrante: "
        puts "Lupulo Sobrante: "
        puts "Levadura Sobrante: "
        puts "Mezcla Arroz Maiz Sobrante: "

    end

end


# ---- Se obtienen los argumentos de la linea de comandos ---- #
numCiclos = ARGV[0].to_i
cebada    = ARGV[1].to_i
arrozMaiz = ARGV[2].to_i
levadura  = ARGV[3].to_i
lupulo    = ARGV[4].to_i

# ---- Se crea la Fabrica y se pone en marcha ---- #
glaciar = Fabrica.new(numCiclos, cebada, arrozMaiz, levadura, lupulo)
glaciar.activar
