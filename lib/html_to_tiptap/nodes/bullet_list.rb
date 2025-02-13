module HtmlToTiptap
  module Nodes
    class BulletList < Node

      def matching
        @node.name === 'ul'
      end

      def data
        {
          type: "bulletList"
        }
      end
    end
  end
end
