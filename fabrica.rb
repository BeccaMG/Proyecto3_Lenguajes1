#!/usr/bin/env ruby
require_relative 'maquina'
require_relative 'maquinaFinal'
require_relative 'maquinaCompleja'


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

        cervezas = Producto.new(0)
        
        # ---- Se crea cada una de las maquinas ---- #
        contenedor1 = Producto.new(0)
        contenedor2 = Producto.new(0)
        contenedor3 = Producto.new(0)
        contenedor4 = Producto.new(0)
        contenedor5 = Producto.new(0)
        contenedor6 = Producto.new(0)
        contenedor7 = Producto.new(0)
        contenedor8 = Producto.new(0)
        contenedor9 = Producto.new(0)
        contenedor10 = Producto.new(0)
        
        contenedorCebada   = InsumoBasico.new("Cebada",@cebada)
        contenedorMezclaArrozMaiz = InsumoBasico.new("Mezcla de Arroz/Maiz",@arrozMaiz)
        contenedorLupulo   = InsumoBasico.new("Lupulo",@lupulo)        
        contenedorLevadura = InsumoBasico.new("Levadura",@levadura)

        llenaTapa = Maquina.new("Llenadora y Tapadora", 0.0, 50, 1, 2, nil,
                                contenedor1, cervezas)
        llenaTapa.extend MaquinaFinal
        
        tanqueFiltrada = Maquina.new("Tanque para Cerveza Filtrada", 0.0, 100,
                                    1, 0, llenaTapa, contenedor2, contenedor1)
        
        filtroCerveza = Maquina.new("Filtro de Cerveza", 0.0, 100, 1, 1,
                                    tanqueFiltrada, contenedor3, contenedor2)

        tcc = Maquina.new("TCC", 0.1, 200, 0.99, 10, filtroCerveza, contenedor4,
                           contenedor3)
        tcc.extend MaquinaCompleja
        tcc.insumoBasico = contenedorLevadura
        tcc.porcentajeIB = 0.01

        enfriador = Maquina.new("Enfriador", 0.0, 60, 1, 2, tcc, contenedor5,
                                contenedor4)
        
        tanque = Maquina.new("Tanque Pre-Clarificador", 0.01, 35, 1, 1,
                            enfriador, contenedor6, contenedor5)

        pailaCoccion = Maquina.new("Paila de Coccion", 0.1, 70, 0.975, 3,
                                    tanque, contenedor7, contenedor6)
        pailaCoccion.extend MaquinaCompleja
        pailaCoccion.insumoBasico = contenedorLupulo
        pailaCoccion.porcentajeIB = 0.025
        
        cubaFiltracion = Maquina.new("Cuba de Filtracion", 0.35, 135, 1, 2,
                                    pailaCoccion, contenedor8, contenedor7)
        
        pailaMezcla = Maquina.new("Paila de Mezcla", 0, 150, 0.6, 2,
                                  cubaFiltracion, contenedor9, contenedor8)
        pailaMezcla.extend MaquinaCompleja
        pailaMezcla.insumoBasico = contenedorMezclaArrozMaiz
        pailaMezcla.porcentajeIB = 0.4
        
        
        molino = Maquina.new("Molino", 0.02, 100, 1, 1, pailaMezcla,
                            contenedor10, contenedor9)

        silosCebada = Maquina.new("Silos de Cebada", 0, 400, 0, 0,
                                  molino, nil, contenedor10)
        
        silosCebada.extend MaquinaCompleja
        silosCebada.insumoBasico = contenedorCebada
        silosCebada.porcentajeIB = 1
        

        # ---- Se ejecutan los ciclos especificados ---- #
        for i in 1..@numCiclos
            puts "Inicio Ciclo #{i}\n"
            silosCebada.procesamiento
            molino.procesamiento
            pailaMezcla.procesamiento
            cubaFiltracion.procesamiento
            pailaCoccion.procesamiento
            tanque.procesamiento
            enfriador.procesamiento
            tcc.procesamiento
            filtroCerveza.procesamiento
            tanqueFiltrada.procesamiento
            llenaTapa.procesamiento   
            puts "Fin Ciclo #{i}\n\n"
        end

        # ---- Se imprimen los resultados ---- #
        puts "Cerveza Total: #{cervezas.cantidad}"
        puts "Cebada Sobrante: #{contenedorCebada.cantidad}"
        puts "Lupulo Sobrante: #{contenedorLupulo.cantidad}"
        puts "Levadura Sobrante: #{contenedorLevadura.cantidad}"
        puts "Mezcla Arroz Maiz Sobrante: #{contenedorMezclaArrozMaiz.cantidad}"

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
