require "English"
#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content,         - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
  def initialize(line_of_text, line_number)
    @content = line_of_text
    @line_number = line_number    
    calculate_word_frequency
  end

  def calculate_word_frequency()
    word_frequencies = []
    temp_arr = []
    words_counted = @content.strip.downcase.split(/[^\w']+/).group_by(&:to_s).map{|w| {w[0]=>w[1].count}}
    words_counted.each do |word|
      word_frequencies << word.values
      word_frequencies = word_frequencies.flatten
    end
    @highest_wf_count = word_frequencies.max
    words_counted.reject! do |word|
      word.values.first < @highest_wf_count
    end
    words_counted.each do |word|
      temp_arr << word.keys.first
    end
    @highest_wf_words = temp_arr
  end

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* highest_count_across_lines - a number with the value of the highest frequency of a word
  #* highest_count_words_across_lines - an array with the words with the highest frequency
  
  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers

  def initialize
    @analyzers = []
  end

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers
  #* calculate_line_with_highest_frequency() - determines which line of
  #text has the highest number of occurrence of a single word
  #* print_highest_word_frequency_across_lines() - prints the words with the 
  #highest number of occurrences and their count
  
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file
  def analyze_file
    temp_arr = []
    File.foreach( 'test.txt' ) do |line|
      analyzer = LineAnalyzer.new(line, $INPUT_LINE_NUMBER)
      temp_arr << analyzer 
    end
    @analyzers = temp_arr
  end

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the highest number of occurences of a word across all lines
  #and stores this result in the highest_count_across_lines attribute.
  #* identifies the words that were used with the highest number of occurrences
  #and stores them in print_highest_word_frequency_across_lines.
  def calculate_line_with_highest_frequency
    @highest_count_across_lines = @analyzers.max_by { |analyzer| analyzer.highest_wf_count }.highest_wf_count
    @highest_count_words_across_lines =
      @analyzers.reject{ |analyzer| analyzer.highest_wf_count < @highest_count_across_lines }
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the result in the following format
  def print_highest_word_frequency_across_lines
    puts ["The following words have the highest word frequency per line:",
            "[\"word1\"] (appears in line #)",
            "[\"word2\", \"word3\"] (appear in line #)"
         ].join("\n") 
  end
end
