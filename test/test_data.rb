# Copyright (C) 2016 Colin Fulton
# All rights reserved.
#
# This software may be modified and distributed under the
# terms of the three-clause BSD license. See LICENSE.txt

require './test_setup'
require './../data'
require 'tet'

group 'Choice Functions' do
  group 'AND' do
    assert 'returns a FIRST when given two FIRSTs' do
      AND[FIRST, FIRST][true, false]
    end

    assert 'returns a SECOND when given a FIRST and a SECOND' do
      AND[FIRST, SECOND][false, true]
    end

    assert 'returns a SECOND when given two SECONDs' do
      AND[SECOND, SECOND][false, true]
    end
  end

  group 'OR' do
    assert 'returns a FIRST when given two FIRSTs' do
      OR[FIRST, FIRST][true, false]
    end

    assert 'returns a FIRST when given a FIRST and a SECOND' do
      OR[FIRST, SECOND][true, false]
    end

    assert 'returns a SECOND when given two SECONDs' do
      OR[SECOND, SECOND][false, true]
    end
  end
end

group 'Pair Functions' do
  group 'NTH' do
    example = [:A, :B, :C].to_linked_list

    assert 'gets the first element when given 0' do
      :A == NTH[example, 0.to_peano]
    end

    assert 'gets the third element when given 2' do
      :C == NTH[example, 2.to_peano]
    end
  end

  group 'LIST_MAP' do
    assert 'maps function across board and returns a new board' do
      incremented = LIST_MAP[
                      index_array.to_linked_list,
                      64.to_peano,
                      ->(x, _) { x + 1 }
                    ].to_a(64)

      incremented == index_array.map { |x| x + 1 }
    end

    assert 'second argument gives current position index' do
      empty_board   = ([nil] * 64).to_linked_list
      given_indexes = LIST_MAP[
                        empty_board,
                        64.to_peano,
                        ->(_, i) { i.to_i }
                      ].to_a(64)

      given_indexes == index_array
    end
  end
end

group 'Math Functions' do
  group 'ADD' do
    assert 'adds two numbers together' do
      11 == ADD[8.to_peano, 3.to_peano].to_i
    end

    assert 'works with zero' do
      36 == ADD[0.to_peano, 36.to_peano].to_i
    end
  end

  group 'DECREMENT' do
    assert 'subtracts one from the given number' do
      99 == DECREMENT[100.to_peano].to_i
    end

    assert 'given zero returns zero' do
      0 == DECREMENT[0.to_peano].to_i
    end
  end

  group 'SUBTRACT' do
    assert 'subtracts the second number from the first number' do
      10 == SUBTRACT[20.to_peano, 10.to_peano].to_i
    end

    assert 'floors at zero' do
      0 == SUBTRACT[3.to_peano, 5.to_peano].to_i
    end
  end

  group 'MULTIPLY' do
    assert 'multiplies two numbers together' do
      8 == MULTIPLY[2.to_peano, 4.to_peano].to_i
    end

    assert 'works with zero' do
      0 == MULTIPLY[0.to_peano, 23.to_peano].to_i
    end
  end

  group 'DIVIDE' do
    assert 'divides two integers' do
     6 == DIVIDE[30.to_peano, 5.to_peano].to_i
    end

    assert 'rounds down' do
     6 == DIVIDE[32.to_peano, 5.to_peano].to_i
    end
  end

  group 'MODULUS' do
    assert 'returns the remainder of division' do
     2 == MODULUS[12.to_peano, 5.to_peano].to_i
    end

    assert 'returns the first argument when the second argument is larger' do
     4 == MODULUS[4.to_peano, 10.to_peano].to_i
    end
  end

  group 'ABSOLUTE_DIFFERENCE' do
    assert 'returns difference when second argument is smaller' do
      7 == ABSOLUTE_DIFFERENCE[10.to_peano, 3.to_peano].to_i
    end

    assert 'returns absolute value of difference when second argument is larger' do
      18 == ABSOLUTE_DIFFERENCE[2.to_peano, 20.to_peano].to_i
    end
  end
end

group 'Comparison Functions' do
  group 'IS_ZERO' do
    assert 'returns FIRST when given zero' do
      IS_ZERO[0.to_peano][true, false]
    end

    assert 'returns SECOND when given a non-zero number' do
      IS_ZERO[9.to_peano][false, true]
    end
  end

  group 'IS_GREATER_OR_EQUAL' do
    assert 'returns FIRST when greater' do
      IS_GREATER_OR_EQUAL[2.to_peano, 1.to_peano][true, false]
    end

    assert 'returns FIRST when equal' do
      IS_GREATER_OR_EQUAL[5.to_peano, 5.to_peano][true, false]
    end

    assert 'returns SECOND when less' do
      IS_GREATER_OR_EQUAL[4.to_peano, 9.to_peano][false, true]
    end
  end

  group 'IS_EQUAL' do
    assert 'returns FIRST when equal' do
      IS_EQUAL[6.to_peano, 6.to_peano][true, false]
    end

    assert 'returns SECOND when greater' do
      IS_EQUAL[7.to_peano, 2.to_peano][false, true]
    end

    assert 'returns SECOND when less' do
      IS_EQUAL[1.to_peano, 4.to_peano][false, true]
    end
  end

  group 'COMPARE' do
    assert 'returns first option when first argument is less than the second' do
      COMPARE[2.to_peano, 9.to_peano][true, false, false]
    end

    assert 'returns second option when first argument is equal to the second' do
      COMPARE[4.to_peano, 4.to_peano][false, true, false]
    end

    assert 'returns third option when first argument is equal to the second' do
      COMPARE[8.to_peano, 3.to_peano][false, false, true]
    end
  end
end