class Hangman

  def intitialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def run_game
    num_guesses_left = 10

    until game_over?
      @checking_player.pick_secret_word
      @guessing_player.receive_secret_word
      @guessing_player.guess
      @checking_player.handle_guess_response
      return
    end

  end

  def game_over?
    return true if @guessing_player.receive_secret_length == correctly_placed_letters
    return true if num_guesses_left == 0
  end

  def winner?
    if num_guesses_left == 0 && (not @guessing_player.receive_secret_length == correctly_placed_letters)
      return @checking_player
    else
      return @guessing_player
    end
  end

end

class HumanPlayer

  def intitialize
    @stored_guesses = []
  end

  def pick_secret_word
    puts "Think of a secret word. How long is the word?"
    Integer(gets.chomp)
  end

  def receive_secret_length
    puts "I'm thinking of a word that is #{@checking_player.pick_secret_word.length} letters long."
  end

  def guess
    puts "Please guess a letter."
    current_guess = gets.chomp

    until false
      puts "Please guess a letter."
      current_guess = gets.chomp

      if not @stored_guesses.include?(current_guess)
        return false
      else
        puts "You already guessed that letter!"
      end
    end

    @stored_guesses << current_guess
    @stored_guesses.last
  end

  def check_guess
    puts "Is #{@guessing_player.guess} in your word?"

    return false if gets.chomp.include?("n")
    return true
  end

  def handle_guess_response
    if check_guess
      puts "Which letter(s)? Please use the format num,num,etc"
      return gets.chomp
    end
  end

end

class ComputerPlayer

  def intitialize
    @stored_guesses = []
    @dictionary = []
    File.open("dictionary.txt").each_line {|word| @dictionary << word.chomp}
  end

  def pick_secret_word
    secret_word = @dictionary.sample.split('')
  end

  def receive_secret_length
    @checking_player.pick_secret_word
  end

  def guess
    current_guess = (a..z).sample
    until false
      if not @stored_guesses.include?(current_guess)
        return false
      end
    end


    @stored_guesses << current_guess
    @stored_guesses.last
  end

  def check_guess
    return true if secret_word.include(@guessing_player.guess)
  end

  def handle_guess_response
    if check_guess
      secret_word.each_with_idx do |letter, idx|
        if letter == @guessing_player.guess
          @guessing_player.receive_secret_length[idx] = letter
        end
      end
    end
  end

end
