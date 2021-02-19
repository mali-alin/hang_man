class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(normalize_letter(letter))
          letter
        else
          nil
        end
      end
   result
  end

  def normalize_letter(letter)
    case letter
    when "Ё" then "Е"
    when "Й" then "И"
    else letter
    end
  end

  def normalized_letters(letters)
    letters.map { |letter| normalize_letter(letter) }
  end

  def errors
    return @user_guesses - normalized_letters(@letters)
  end

  def over?
    return won? || lost?
  end

  def play!(letter)
    normalize_letter = normalize_letter(letter)

    if !over? && !@user_guesses.include?(normalize_letter)
    @user_guesses << normalize_letter
    end
  end

  def word
    return @letters.join
  end

  def won?
    return (normalized_letters(@letters) - @user_guesses).empty?
  end

  def lost?
    return errors_allowed == 0
  end
end
