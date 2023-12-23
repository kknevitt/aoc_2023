# frozen_string_literal: true

require 'pry'
class CalibrationDigitsCalculator
  LETTERED_NUMBERS = %w[
    one
    two
    three
    four
    five
    six
    seven
    eight
    nine
  ].freeze

  def self.execute(input_path)
    @input_path = input_path
    @total = 0

    File.foreach(input_path) do |line|
      @lh_value,  @lh_cursor, @lh_match_end_position = line_inspection(line: line)
      @rh_value,  @rh_cursor, @rh_match_end_position = line_inspection(line: line, reverse: true)

      # normalise lh_value
      normalised_lh_value = if @lh_value.match?(/[1-9]/)
                              @lh_value.to_i
                            else
                              LETTERED_NUMBERS.index(@lh_value) + 1
                            end

      normalised_rh_value = if @rh_value.match?(/[1-9]/)
                              @rh_value.to_i
                            else
                              LETTERED_NUMBERS.index(@rh_value) + 1
                            end

      line_total = "#{normalised_lh_value}#{normalised_rh_value}".to_i

      @total += line_total
    end
    @total
  end

  def self.line_inspection(line:, reverse: false)
    matchables = LETTERED_NUMBERS.each_with_object({}) do |lettered_number, memo|
      memo[lettered_number] = ''
    end

    matched_number_value = nil
    matched_index_end_position = nil
    line_index = reverse ? line.length - 1 : 0
    comparison_method = reverse ? :end_with? : :start_with?

    while matched_number_value.nil?
      current_character = line[line_index]
      # if number - stop iterating through characters and store value
      if current_character.match?(/[1-9]/)
        matched_number_value = current_character
        matched_index_end_position = line_index
        break
      else
        # if letter
        matchables.each do |lettered_number, rolling_match|
          potential_match = reverse ? "#{current_character}#{rolling_match}" : "#{rolling_match}#{current_character}"
          # if full match - break entirely
          if lettered_number == potential_match
            matched_number_value = potential_match
            matched_index_end_position = line_index
            break
          elsif lettered_number.send(comparison_method, potential_match)
            matchables[lettered_number] = potential_match
          elsif lettered_number.send(comparison_method, current_character)
            matchables[lettered_number] = current_character
          else
            matchables[lettered_number] = ''
          end
        end
        break if matched_number_value
      end
      reverse ? line_index -= 1 : line_index += 1
    end

    [matched_number_value, line_index, matched_index_end_position]
  end
end
