require 'rspec'
require '../lib/calibration_digits_calculator'

describe CalibrationDigitsCalculator do
  describe '.execute' do
    it 'should use the numbers if present' do
      result = CalibrationDigitsCalculator.execute('./spec//fixtures/number_calculation.txt')
      expect(result).to eq 33
    end
  
    it 'should use the lh numbers to textif present' do
      result = CalibrationDigitsCalculator.execute('./spec//fixtures/lh_text_calculation.txt')
      expect(result).to eq 100
    end
  
    it 'should use the rh numbers to text if present' do
      result = CalibrationDigitsCalculator.execute('./spec//fixtures/rh_text_calculation.txt')
      expect(result).to eq 109
    end
  
    it 'should use the rh numbers to text if present' do
      result = CalibrationDigitsCalculator.execute('./spec//fixtures/provided_example.txt')
      expect(result).to eq 281
    end
  
    it 'should use single matches if present' do
      result = CalibrationDigitsCalculator.execute('./spec//fixtures/single_matches.txt')
      expect(result).to eq 44
    end
  
    it 'should use single matches if present' do
      result = CalibrationDigitsCalculator.execute('./spec//fixtures/mixed_values.txt')
      expect(result).to eq 169
    end
  end
end
