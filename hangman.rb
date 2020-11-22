class Hangman
  def initialize
    puts "Hangman Initialized!"
    puts ''
    generate_word
    @board = Array.new(@word.length, '_')
    @chances = 6
    @used_chars = []
  end

  def start_game
    loop do
      show_restricted
      visual_counter
      display_board
      break if game_over?
      char = make_guess
      update_board(char)
    end
  end

  def generate_word
    dictionary = File.readlines "5desk.txt"
    @word = dictionary.map{ |w| w.gsub(/[^[:print:]]/, '') }
                     .select { |w| w.length.between?(5,12) }
                     .sample
                     .downcase
                     .split('')
  end

  def display_board
    puts @board.join(' ')
    puts ''
  end

  def show_restricted
    puts "Used: #{@used_chars.join(',')}"
  end

  def update_board(char)
    @used_chars << char
    if !@word.include?(char)
      @chances -= 1
      return
    end
    @word.each_with_index do |letter, index|
      if @word[index] == char 
        @board[index] = char
      end
    end
  end

  def make_guess
    guess = gets.chomp
    return make_guess unless valid_input?(guess)
    guess
  end

  def valid_input?(input)
    if input.match(/[^a-z]/)
      puts "alphabetical letters only"
      false
    elsif input.length > 1
      puts "only one letter at a time"
      false
    elsif @used_chars.include?(input)
      puts "you've already guess that one"
      false
    else
      true
    end
  end

  def visual_counter
    case @chances
    when 6
      puts "  _____     "
      puts " |     |    "
      puts " |          "
      puts " |          "
      puts " |          "
      puts " ~~~~~~~~~~~"
    when 5
      puts "  _____     "
      puts " |     |    "
      puts " |     O    "
      puts " |          "
      puts " |          "
      puts " ~~~~~~~~~~~"
    when 4
      puts "  _____     "
      puts " |     |    "
      puts " |     O    "
      puts " |     |    "
      puts " |          "
      puts " ~~~~~~~~~~~"
    when 3
      puts "  _____     "
      puts " |     |    "
      puts " |     O    "
      puts " |    /|    "
      puts " |          "
      puts " ~~~~~~~~~~~"
    when 2
      puts "  _____     "
      puts " |     |    "
      puts " |     O    "
      puts " |    /|\\  "
      puts " |          "
      puts " ~~~~~~~~~~~"
    when 1
      puts "  _____     "
      puts " |     |    "
      puts " |     O    "
      puts " |    /|\\  "
      puts " |      \\  "
      puts " ~~~~~~~~~~~"
    when 0
      puts "  _____     "
      puts " |     |  R.I.P. "
      puts " |     O    "
      puts " |    /|\\  "
      puts " |    / \\  "
      puts " ~~~~~~~~~~~"
    end
  end

  def game_over?
    win? || lose?
  end

  def win?
    if @board.none?('_')
      puts "You won!"
      true
    end
  end

  def lose?
    if @chances == 0
      puts "You lost!"
      puts "The word was #{@word.join}"
      true
    end
  end

end

hangman = Hangman.new
hangman.start_game

