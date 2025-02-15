RSpec.describe HtmlToTiptap::Nodes::OrderedList do
  it "renders ordered list correctly" do
    html = '<ol><li><p>First Example</p></li><li><p>Second Example</p></li></ol>';
    json = {
      type: 'doc',
      content: [{
        type: 'orderedList',
        attrs: {
          order: 1,
        },
        content: [{
          type: 'listItem',
          content: [{
            type: 'paragraph',
            content: [{
              type: 'text',
              text: 'First Example',
            }]
          }]
        },{
          type: 'listItem',
          content: [{
            type: 'paragraph',
            content: [{
              type: 'text',
              text: 'Second Example',
            }]
          }]
        }]
      }]
    }

    renderer = HtmlToTiptap::Renderer.new()
    expect(json).to eq renderer.render(html)
  end
end
