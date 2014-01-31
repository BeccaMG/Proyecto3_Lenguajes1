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


