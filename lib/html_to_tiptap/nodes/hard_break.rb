module HtmlToTiptap
  module Nodes
    class HardBreak < Node

      def matching
        @node.name === 'br'
      end

      def data
        {
          type: "hardBreak"
        }
      end
    end
  end
end
