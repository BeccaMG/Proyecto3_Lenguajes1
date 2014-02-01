class Fabrica

    attr_accessor :numCiclos, :cebada, :arrozMaiz, :levadura, :lupulo

    def initialize(numCiclos, cebada, arrozMaiz, levadura, lupulo)
        @numCiclos = numCiclos
        @cebada    = cebada
        @arrozMaiz = arrozMaiz
        @levadura  = levadura
        @lupulo    = lupulo
    end

    def activar
        
        puts "Inicio Planta"
        puts "#{@numCiclos}"

        #FALTA PONER LAS MAQUINAS SIGUIENTES

        silosCebada    = MaquinaCompleja.new
        molino         = Maquina.new("Molino", 0.02, 0, 100, 100, 1, nil, nil)
        pailaMezcla    = MaquinaCompleja.new
        cubaFiltracion = Maquina.new("Cuba de Filtracion", 0.35, 0, 135, 100, 2, nil, nil)
        pailaCoccion   = MaquinaCompleja.new
        tanque         = Maquina.new("Tanque Pre-Clarificador", 0.01, 0, 35, 100, 1, nil, nil)
        enfriador      = Maquina.new("Enfriador", 0.0, 0, 60, 100, 2, nil, nil)
        tcc            = MaquinaCompleja.new
        filtroCerveza  = Maquina.new("Filtro de Cerveza", 0.0, 0, 100, 100, 1, nil, nil)
        tanqueFiltrada = Maquina.new("Tanque para Cerveza Filtrada", 0.0, 0, 100, 100, 0, nil, nil)
        llenaTapa      = Maquina.new("Llenadora y Tapadora", 0.0, 0, 50, 100, 2, nil, nil)


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

        puts "Cerveza Total: "
        puts "Cebada Sobrante: "
        puts "Lupulo Sobrante: "
        puts "Levadura Sobrante: "
        puts "Mezcla Arroz Maiz Sobrante: "

    end

end

numCiclos = ARGV[0].to_i
cebada    = ARGV[1].to_i
arrozMaiz = ARGV[2].to_i
levadura  = ARGV[3].to_i
lupulo    = ARGV[4].to_i


glaciar = Fabrica.new(numCiclos, cebada, arrozMaiz, levadura, lupulo)
glaciar.activar
