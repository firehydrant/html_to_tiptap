module HtmlToTiptap
  module Nodes
    class ListItem < Node
      def initialize(dom_node)
        super(dom_node)
        @wrapper = { type: 'paragraph' }
      end

      def matching
        @node.name === 'li'
      end

      def data
        if(@node.children.length === 1 && @node.children[0].name === 'p')
          @wrapper = nil
        end

        {
          type: "listItem"
        }
      end
    end
  end
end
