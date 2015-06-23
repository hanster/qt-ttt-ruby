require 'Qt'

module TicTacToeGui
  module Ui
    class GuiBoard < Qt::GridLayout
      INDEX_OFFSET = 1
      X_MARKER_COLOR = "color: red"
      O_MARKER_COLOR = "color: blue"

      def initialize
        super(nil)
      end

      def register_panel_on_click(object, slot)
        @object = object
        @slot = slot
      end

      def new_board(dimension)
        clear_panels(@panels) if @panels
        create_board(dimension)
      end

      def click_panel(panel_number)
        find_panel(panel_number).click
      end

      def update(board)
        @panels.each_index do |index|
          @panels[index].text = board.move_available?(index) ? index + INDEX_OFFSET : board.marker_at_position(index)
          colour_panel(@panels[index])
        end
      end

      private

      def find_panel(panel_number)
        @panels.find do |panel|
          panel.text == (panel_number + 1).to_s
        end
      end

      def create_board(dimension)
        @panels = []
        (0...(dimension * dimension)).each do |position|
          @panels << create_panel(position, dimension)
        end
      end

      def clear_panels(panels)
        panels.each do |panel|
          panel.hide
          removeWidget(panel)
          panel.dispose
        end
      end

      def create_panel(position, dim)
        panel = Qt::PushButton.new((position + INDEX_OFFSET).to_s)
        panel.setSizePolicy(Qt::SizePolicy::Expanding,Qt::SizePolicy::Expanding)
        row, col = position.divmod(dim)
        connect(panel, SIGNAL(:clicked), @object, SLOT(@slot))
        addWidget(panel, row, col)
        panel
      end

      def colour_panel(panel)
        panel.setStyleSheet(X_MARKER_COLOR) if panel.text == TicTacToe::Marker::X_MARKER
        panel.setStyleSheet(O_MARKER_COLOR) if panel.text == TicTacToe::Marker::O_MARKER
      end
    end
  end
end
