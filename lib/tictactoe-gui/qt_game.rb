require 'Qt'
require 'tic_tac_toe_core/game'
require 'tictactoe-gui/ui/graphical_ui'

module TicTacToeGui
  class QtGame < Qt::Widget
    TICTACTOE = 'TicTacToe'
    GAME_BOARD_NAME = 'game_board'
    GAME_TYPES_TEXT = 'Game Types'
    BOARD_TYPES_TEXT = 'Board Types'

    slots :play_new_game, :clicked

    def initialize
      super(nil)
      setObjectName(TICTACTOE)
      setWindowTitle(TICTACTOE)
      resize(600, 600)
      @ui = Ui::GraphicalUi.new(self)
    end

    private

    attr_reader :game, :ui

    def play_new_game
      setup_game
      update_game
    end

    def setup_game
      game_setup = TicTacToeCore::GameSetup.new(ui)
      @game = game_setup.build_game
      board = game.board
      ui.new_gui_board(board)
    end

    def get_player_move
      game.get_current_player_move
    end

    def clicked
      return if cannot_make_move(sender)
      make_move(sender)
      update_game
    end

    def update_game
      if game.running?
        next_move = get_player_move
        ui.click_board_panel(next_move) if next_move
      end
      game.draw
    end

    def cannot_make_move(sender)
      game.game_over? || invalid_button_move?(sender)
    end

    def make_move(sender)
      game.make_move(sender.text.to_i - 1)
    end

    def invalid_button_move?(button)
      button.text != button.text.to_i.to_s
    end
  end
end
