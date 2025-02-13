RSpec.describe HtmlToTiptap::Marks::Code do
  it "renders inline code correctly" do
    html = '<p><code>Example Text</code></p>';
    json = {
      type: 'doc',
      content: [{
        type: 'paragraph',
        content: [{
          type: 'text',
          text: 'Example Text',
          marks: [{
            type: 'code',
          }]
        }]
      }]
    }

    renderer = HtmlToTiptap::Renderer.new()
    expect(json).to eq renderer.render(html)
  end
end
