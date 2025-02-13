require "html_to_tiptap/version"
require "html_to_tiptap/marks/mark"
require "html_to_tiptap/marks/bold"
require "html_to_tiptap/marks/code"
require "html_to_tiptap/marks/italic"
require "html_to_tiptap/marks/link"
require "html_to_tiptap/nodes/node"
require "html_to_tiptap/nodes/bullet_list"
require "html_to_tiptap/nodes/code_block_wrapper"
require "html_to_tiptap/nodes/code_block"
require "html_to_tiptap/nodes/hard_break"
require "html_to_tiptap/nodes/heading"
require "html_to_tiptap/nodes/image"
require "html_to_tiptap/nodes/list_item"
require "html_to_tiptap/nodes/ordered_list"
require "html_to_tiptap/nodes/paragraph"
require "html_to_tiptap/nodes/text"
require "html_to_tiptap/nodes/user"
require 'nokogiri'

module HtmlToTiptap
  class Error < StandardError; end
  # Your code goes here...
  class Renderer
    def initialize()
      @storedMarks = []
      @marks = [
        HtmlToTiptap::Marks::Bold,
        HtmlToTiptap::Marks::Code,
        HtmlToTiptap::Marks::Italic,
        HtmlToTiptap::Marks::Link
      ]
      @nodes = [
        HtmlToTiptap::Nodes::BulletList,
        HtmlToTiptap::Nodes::CodeBlockWrapper,
        HtmlToTiptap::Nodes::CodeBlock,
        HtmlToTiptap::Nodes::HardBreak,
        HtmlToTiptap::Nodes::Heading,
        HtmlToTiptap::Nodes::Image,
        HtmlToTiptap::Nodes::ListItem,
        HtmlToTiptap::Nodes::OrderedList,
        HtmlToTiptap::Nodes::Paragraph,
        HtmlToTiptap::Nodes::Text,
        HtmlToTiptap::Nodes::User
      ]
    end

    def render(value)
      minified = minify_html(value.strip! || value)
      @document = Nokogiri::HTML.fragment(minified)
      content = render_children(@document)
      return {
        type: 'doc',
        content: content,
      }
    end
  private

    # def get_document_body
    #   return @document.search('body')[0];
    # end

    def render_children(node)
      nodes = []
      node.children.each do |child|
        child_node = get_matching_node(child)
        if( child_node)
          item = child_node.data()
          if (item === nil)
            if (child.children.length > 0)
              nodes = nodes + render_children(child)
            end
            next
          end
          if (child.children.length > 0)
            item = item.merge({
              content: render_children(child),
            })
          end
          if (@storedMarks.count > 0)
              item = item.merge({
                marks: @storedMarks,
              })
              @storedMarks = [];
          end
          # if (child_node.wrapper)
          #   item['content'] = [
          #     instance.wrapper.merge({
          #       content: item['content'],
          #     }),
          #   ]
          # end
          nodes.push(item)
        end

        child_mark = get_matching_mark(child)
        if (child_mark)
          @storedMarks.push(child_mark.data())
          if (child.children.length > 0)
            nodes = nodes + render_children(child)
          end
        end
      end
      return nodes;
    end
    # Find which Node matches the Html Node
    def get_matching_node(item)
      return get_matching_class(item, @nodes)
    end
    # Find which Mark matches the HtmlElement
    def get_matching_mark(item)
      return get_matching_class(item, @marks)
    end
    # Find which class matches the HtmlElement
    def get_matching_class(node, classes)
      found = classes.select do |clazz|
        instance = clazz.new(node)
        if (instance.matching())
          return instance
        end
      end
      found.first
    end

    def minify_html(html)
      # 1. Remove all comments: gsub(/(<!--(\w|\s|:|!|#|<|>|'|"|=|;|,|\.|\?)*-->|\/\*[^\*]*\*\/|^(\t|\s)*\/\/.*)/, '')
      # 1.1 html comments without special characters: <!--(\w|\s|:|!|#|<|>|'|"|=|;|,|\.|\?)*-->
      # 1.2. Remove javascript comments e.g. /* */ and // \/\*[^\*]*\*\/ and ^(\t|\s)*\/\/.*
      # 3. Replace all carrier return and all tabs by a single space gsub(/(\n|\t)/, ' ').
      # 4. Replace any consecutive spaces by a single space gsub(/\s{2,}/, ' ')
      # 5. Remove space between tags gsub(/>\s+</, '><').strip.
      html.gsub(/(<!--(\w|\s|:|!|#|<|>|'|"|=|;|,|\.|\?)*-->|\/\*[^\*]*\*\/|^(\t|\s)*\/\/.*)/, '').
        gsub(/(\n|\t)/, ' ').
        gsub(/\s{2,}/, ' ').
        gsub(/>\s+</, '><').strip
    end
  end
end
