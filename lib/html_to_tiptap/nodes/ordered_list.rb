module HtmlToTiptap
  module Nodes
    class OrderedList < Node

      def matching
        @node.name === 'ol'
      end

      def data
        {
          type: "orderedList",
          attrs: {
            order: 1
          }
        }
      end
    end
  end
end
