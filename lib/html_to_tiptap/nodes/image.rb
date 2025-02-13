module HtmlToTiptap
  module Nodes
    class Image < Node

      def matching
        @node.name === 'img'
      end

      def data
        attrs = {
          src: @node.attribute("src").value
        }

        alt = @node.attribute("alt")
        attrs[:alt] = alt.value if alt

        title = @node.attribute("title")
        attrs[:title] = title.value if title

        {
          type: "image",
          attrs: attrs
        }
      end
    end
  end
end
