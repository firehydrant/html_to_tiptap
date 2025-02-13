RSpec.describe HtmlToTiptap::Nodes::CodeBlock do
  it "renders code blocks correctly" do
    html = '<pre><code>Example Text</code></pre>';
    json = {
      type: 'doc',
      content: [{
        type: 'code_block',
        content: [{
          type: 'text',
          text: 'Example Text',
        }]
      }]
    }

    renderer = HtmlToTiptap::Renderer.new()
    expect(json).to eq renderer.render(html)
  end
end
