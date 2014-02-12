class Relation < ActiveRecord::Base
  @keep_word = [:top100]
  # @keep_word = [:ba]
  @all_code  = [('0'..'9'), ('a'..'z'), ('A'..'Z'), '!@$%^&*()_+|}{'.split('')].map { |i| i.to_a }.flatten
  # @all_code  = [('a'..'c')].map { |i| i.to_a }.flatten

  def self.get_code
    length = self.get_length
    count  = self.where(key: KEY_COUNT).first
    if count.present?
      current_count = count.value

      code = ''
      while true
        length.times do |i|
          code = @all_code[current_count % @all_code.size] + code
          current_count /= @all_code.size
        end
        if @keep_word.include?(:"#{code}")
          count.increment!(:value)
          current_count = count.value
          code = ''
        else
          break
        end
      end

      if count.value == @all_code.size ** length - 1
        length = self.add_length
        count.value = 0
        count.save
      else
        count.increment!(:value)
      end
    else
      # first time
      count = self.new({key: KEY_COUNT, value: 1})
      count.save
      code = @all_code.first
    end
    return code
  end

  private
    KEY_LENGTH = 'LENGTH'
    KEY_COUNT  = 'COUNT'

    def self.get_length
      length = self.where({key: KEY_LENGTH}).first
      length = self.new({key: KEY_LENGTH, value: 1}) if length.blank?
      length.save
      length.value
    end

    def self.add_length
      length = self.where({key: KEY_LENGTH}).first
      length.increment!(:value) if length.present?
      length.value
    end
end
