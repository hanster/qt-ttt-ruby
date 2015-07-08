require 'tic_tac_toe_core/game_setup'
require 'tictactoe-gui/ui/menu_group'
require 'tictactoe-gui/ui/gui_builder'
require 'tictactoe-gui/ui/gui_board'

module TicTacToeGui
  module Ui
    class GraphicalUi
      WINNER_MESSAGE = "%s wins!"
      DRAW_MESSAGE = "It's a draw!"
      GAME_TYPES_TEXT = 'Game Types'
      BOARD_TYPES_TEXT = 'Board Types'
      PLAY_BUTTON_TEXT = 'Play'
      PLAY_BUTTON_NAME = 'play_button'
      PLAYER_TURN_TEXT = "Turn = Player %s"

      def initialize(parent)
        @parent = parent
        build_gui_objects
      end

      def draw(board, marker)
        draw_board(board)
        display_status(board, marker)
      end

      def get_board_type
        option = @board_menu.selected_option
        TicTacToeCore::GameSetup::BOARD_OPTIONS.key(option)
      end

      def get_players_type
        option = @players_menu.selected_option
        TicTacToeCore::GameSetup::PLAYER_OPTIONS.key(option)
      end

      def new_gui_board(board)
        @gui_board.new_board(board.size)
      end

      def click_board_panel(panel_number)
        @gui_board.click_panel(panel_number) 
      end

      def prompt_for_move(board, marker)

      end

      private

      def draw_board(board)
        @gui_board.update(board)
      end

      def display_status(board, marker)
        @info_label.text = get_status_message(board, marker)
      end

      def get_status_message(board, marker)
        if board.finished?
          "Game Over\n\n" + end_game_message(board)
        else
          PLAYER_TURN_TEXT % marker
        end
      end

      def end_game_message(board)
        if board.tie?
          DRAW_MESSAGE
        else
          WINNER_MESSAGE % board.winner
        end
      end

      def build_gui_objects
        @gui_builder = GuiBuilder.new(@parent)

        @players_menu = Ui::MenuGroup.new(GAME_TYPES_TEXT, TicTacToeCore::GameSetup::get_player_options)
        @board_menu = Ui::MenuGroup.new(BOARD_TYPES_TEXT, TicTacToeCore::GameSetup::get_board_options)
        @gui_board = Ui::GuiBoard.new
        @gui_board.register_panel_on_click(@parent, :clicked)

        @info_label = @gui_builder.create_label
        play_button = @gui_builder.create_button(PLAY_BUTTON_NAME, PLAY_BUTTON_TEXT, :play_new_game)
        set_up_grid = Qt::GridLayout.new(@parent)
        set_up_grid.addLayout(@gui_board, 1, 0, 3, 3)
        set_up_grid.addWidget(@players_menu.group_box, 0, 0)
        set_up_grid.addWidget(@board_menu.group_box, 0, 1)
        set_up_grid.addWidget(play_button, 0, 2)
        set_up_grid.addWidget(@info_label, 4, 0)
      end
    end
  end
end
