require_relative 'enumerable'

describe Enumerable do

  let(:seletive_block)  { -> (x, i=nil) { x.even? } }
  let(:operation_block) { -> (acc=nil, x) { x**x    } }
  
  describe '#my_each' do
    it 'returns the same as Array#each' do
      expect([1, 2, 3].each &operation_block ).to eq [1, 2, 3].my_each &operation_block
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_each &b }.to yield_control
    end

    it 'yields each element' do
      expect { |b| [1, 2, 3].my_each &b }.to yield_successive_args(1, 2, 3)
    end
  end

  describe '#my_each_with_index' do
    it 'returns the same as Array#each_with_index' do
      expect([1, 2, 3].each_with_index &seletive_block)
        .to eq [1, 2, 3].my_each_with_index &seletive_block
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_each_with_index &b }.to yield_control
    end

    it 'yields each element and its index' do
      expect { |b| [1, 2, 3].my_each_with_index &b }.to yield_successive_args([1,0], [2,1], [3,2])
    end

  end

  describe '#my_select' do
    it 'returns the same as Array#select' do
      expect([1, 2, 3, 4].select &seletive_block).to eq [1, 2, 3, 4].my_select &seletive_block
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_select &b }.to yield_control
    end

    it 'yields each element' do
      expect { |b| [1, 2, 3, 4].my_select &b }.to yield_successive_args(1, 2, 3, 4)
    end
  end

  describe '#my_all?' do
    it 'returns the same as Array#all?' do
      expect([2, 4, 8].all? &seletive_block).to eq [2, 4, 8].my_all? &seletive_block
      expect(['x','y','z', 1, 2, 3].all?  { |x| x.is_a? Fixnum })
        .to eq ['x','y','z', 1, 2, 3].my_all?  { |x| x.is_a? Fixnum }
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_all? &b }.to yield_control
    end

    it 'yields each element' do
      expect { |b| [1, 2, 3].my_all? &b }.to yield_successive_args(1, 2, 3)
    end
  end

  describe '#my_any?' do
    it 'returns the same as Array#any?' do
      expect([1, 3, 7].any? &seletive_block).to eq [1, 3, 7].my_any? &seletive_block
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_any? &b }.to yield_control
    end

    it 'yields each element' do
      expect { |b| [1, 2, 3].my_any? &b }.to yield_successive_args(1, 2, 3)
    end
  end

  describe '#my_none?' do
    it 'returns the same as Array#none?' do
      expect([1, 2, 3].none? &seletive_block).to eq [1, 2, 3].my_none? &seletive_block
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_none? &b }.to yield_control
    end

    it 'yields each element' do
      expect { |b| [1, 2, 3].my_none? &b }.to yield_successive_args(1, 2, 3)
    end
  end

  describe '#my_count' do
    it 'returns the same as Array#count' do
      expect([1, 2, 3].count &seletive_block).to eq [1, 2, 3].my_count &seletive_block
      expect([1, 2, 3, 1].count(1)).to eq [1, 2, 3, 1].my_count(1)
      expect([1, 2, 3].count).to eq [1, 2, 3].my_count
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_count &b }.to yield_control
    end

    it 'yields each element' do
      expect { |b| [1, 2, 3].my_count &b }.to yield_successive_args(1, 2, 3)
    end
  end

  describe '#my_map' do
    it 'returns the same as Array#map' do
      expect([1, 2, 3].map &operation_block).to eq [1, 2, 3].my_map &operation_block
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_map &b }.to yield_control
    end

    it 'yields each element' do
      expect { |b| [1, 2, 3].my_map &b }.to yield_successive_args(1, 2, 3)
    end
  end

  describe '#my_inject' do
    it 'returns the same as Array#none?' do
      expect([1, 2, 3].my_inject &operation_block)
        .to eq [1, 2, 3].inject &operation_block

      expect([1, 2, 3].my_inject(2) { |acc, elem| acc += elem })
        .to eq [1, 2, 3].inject(2) { |acc, elem| acc += elem }

      expect([1, 2, 3].my_inject(:*))
        .to eq [1, 2, 3].inject(:*)

      expect([1, 2, 3].my_inject(1, :*))
        .to eq [1, 2, 3].inject(1, :*)
    end

    it 'uses a block' do
      expect { |b| [1, 2, 3].my_inject &b }.to yield_control
    end

    it 'yields each element with the accumulator' do
      expect { |b| [1, 2, 3].my_inject &b }.to yield_successive_args([1, 1], [nil, 2], [nil, 3])
    end

  end

  describe '#multiply_els' do
    it 'multiplies all the elements of the array' do
      expect([1, 2, 3, 4].multiply_els).to eq 24
    end

    it 'accepts an array of integers' do
      expect { ['x', 'y', 2, 3].multiply_els }
        .to raise_error ArgumentError
    end
  end
end