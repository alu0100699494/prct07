require "gcd.rb"

class Fraccion
	# Métodos principales
	def initialize(x,y)
		raise ArgumentError , 'Argumentos no enteros.' unless x.is_a? Integer and y.is_a? Integer
        raise ArgumentError , 'Denominador nulo.' unless y != 0

		@num, @den = x, y
		reducir
		
		# En caso de ser negativa, la fracción será -a/b, y no a/(-b)
		if(@num < 0 && @den < 0)
			@num = -@num
			@den = -@den
		elsif(@den < 0)
			@den = -@den
			@num = -@num
		end
	end
	
	def num()
		@num
	end
	
	def den()
		@den
	end
	
	def to_s
		"#{@num}/#{@den}"
	end
	
	def reducir
		mcd = gcd(@num,@den)
		@num = @num / mcd
		@den = @den / mcd
	end
	
	def to_f
		@num.to_f/@den.to_f
	end
	
	# Operadores unarios
	def abs
		if @num < 0
			@num = @num * (-1)
		end
		if @den < 0
			@den = @den * (-1)
		end
		Fraccion.new(@num,@den)
	end
	
	def reciprocal
		aux = @num
		@num = @den
		@den = aux
		Fraccion.new(@num,@den)
	end
	
	def -@ # Operación negación
		Fraccion.new(-@num, @den)
	end

	# Operadores aritméticos
	def +(other) # Operación suma
		# Si no es un numero racional, genera una excepcion
		raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	 
		Fraccion.new(@num*other.den + @den*other.num, @den*other.den) # a/b + c/d = (a*d + b*c)/(b*d)
	end
	
	def -(other) # Operación resta
		raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		Fraccion.new(@num*other.den - @den*other.num, @den*other.den) # a/b - c/d = (a*d - b*c)/(b*d)
	end
	
	def *(other) # Operación producto
		raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		Fraccion.new(@num*other.num, @den*other.den) # a/b * c/d = (a*c)/(b*d)
	end

	def /(other) # Operación división
		raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		Fraccion.new(@num*other.den, @den*other.num) # a/b / c/d = (a*d)/(b*c)
	end
	
	# Operadores comparacionales
	def <(other) # Comparación menor que
		raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		# (@num.to_f/@den) < (other.num.to_f/other.den)
		(@num * other.den) < (@den * other.num) # a/b < c/d -> (a*d)/(b*d) < (c*b) /(b*d) -> a*d < c*b
	end
	
	def >(other) # Comparación mayor que
		raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		# (@num.to_f/@den) > (other.num.to_f/other.den) 
		(@num * other.den) > (@den * other.num) # a/b > c/d -> (a*d)/(b*d) > (c*b) /(b*d) -> a*d > c*b
	end
	
	def ==(other) # Comparación igual 
		raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		(@num == other.num) and (@den == other.den) # a/b == c/d -> a == c && b == d # Se consideran a/b y c/d reducidas por initialize
	end

end