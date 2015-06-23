require 'spec_helper'
require 'tictactoe-gui/qt_game'
require 'Qt'

module TicTacToeGui
  describe QtGame do
    before(:all) do
      app = Qt::Application.new(ARGV)
    end

    let(:window) { QtGame.new }

    it 'is a window' do
      expect(window).to be_kind_of(Qt::Widget)
      expect(window.parent).to be_nil
    end

    it "has the same number of objects each time play is clicked"  do
      find_widget('play_button').click
      num_children = window.children.size
      find_widget('play_button').click
      after_num_children = window.children.size
      expect(num_children).to eq(after_num_children)
    end

    it 'plays a full computer game' do
      find_widget('Computer vs Computer').click
      find_widget('3x3').click
      find_widget('play_button').click
      expect(find_widget('info_label').text).to eq("Game Over\n\nIt's a draw!")
    end

    it 'plays a 2x2 computer game which will end in an X win' do
      find_widget('Computer vs Computer').click
      find_widget('2x2').click
      find_widget('play_button').click
      expect(find_widget('info_label').text).to eq("Game Over\n\nX wins!")
    end

    it 'displays the correct player turn text' do
      find_widget('play_button').click
      expect(find_widget('info_label').text).to eq("Turn = Player X")
    end

    def find_widget(name)
      window.findChild(Qt::Widget, name)
    end

  end
end
