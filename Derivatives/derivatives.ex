# finds derivative for equation you supply,
# can only do very simple derivatives e.g 3x^2 + 4x

defmodule Derivatives do
  #definitions on the atoms we use in the derive functions
  #these type and specifications don't impact the code
  #they are used for documentation and readability of code
  @type constant() :: {:final, number() | :final, atom()}
  @type literal() :: constant | {:var, atom()}
  @type expression() :: {:add, literal(), literal()} | {:multiply, literal(), literal()} | {:power, literal(), integer()} | literal()

  #an expression is derived in relation to the variable
  @spec derive(expression(), atom()) :: expression()

  def main do
    equation =
      {:add,
        {:multiply,
          {:final, 3},
          {:power,
            {:var, :x},
            {:final, 2}
          }
        },
        {:final, 4}
      }

    #prints the expression in an ugly manner!
    #the maths is correct though
    derivative = derive(equation, :x)
    Tuple.to_list(derivative)
  end

  #dy/dx c = 0, where c is a real number
  def derive({:final, _}, _) do
    {:const, 0}
  end
  #dy/dx x = 1
  def derive({:var, x}, x) do
    {:final, 1}
  end
  def derive({:power, {:var, x}, {:final, n}}, x) do
    {:multiply,
      {:final, n},
      {:power,
        {:var, x},
        {:final, n-1}
      }
    }
  end
  #product rule: dy/dx ab = a'b + ab'
  def derive({:multiply, a, b}, v) do
    {:add,
      {:multiply,
        derive(a, v),
        b
      },
      {:multiply,
        a,
        derive(b, v)
      }
    }
  end
  #dy/dx a + b = a' + b'
  def derive({:add, a, b}, v) do
    {:add,
      derive(a,v),
      derive(b,v)
    }
  end

end
