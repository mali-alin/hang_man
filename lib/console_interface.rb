class ConsoleInterface
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"].
    sort.
    map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~GAMESTATUS
    #{"Слово:".colorize(:blue)} #{word_to_show.colorize(:blue)}
    #{figure.colorize(:yellow)}
    #{"Ошибки".colorize(:red)} #{"(#{@game.errors_made}):".colorize(:red)} #{errors_to_show.colorize(:red)}
    У вас осталось ошибок: #{@game.errors_allowed}

    GAMESTATUS

    if @game.won?
      puts "Поздравляем! Вы выиграли!".colorize(:green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:green)
    end
  end

  def figure
    return FIGURES[@game.errors_made]
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter == nil
          "__"
        else
          letter
        end
      end
    result.join(" ")
  end

  def errors_to_show
    @game.errors.join(", ")
  end

  def get_input
    print "Введите следующую букву:"
    letter = gets[0].upcase
    return letter
  end
end
