RSpec.describe HtmlToTiptap::Marks::Link do
  it "renders links correctly" do
    html = '<a href="https://input.com">Example Link</a>';
    json = {
      type: 'doc',
      content: [{
        type: 'text',
        text: 'Example Link',
        marks: [{
          type: 'link',
          attrs: {
            href: 'https://input.com'
          }
        }]
      }]
    }

    renderer = HtmlToTiptap::Renderer.new()
    expect(json).to eq renderer.render(html)
  end
end
