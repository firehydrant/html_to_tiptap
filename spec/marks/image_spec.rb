RSpec.describe HtmlToProsemirror::Nodes::Image do
  it "renders images as links" do
    html = '<img src="https://example.com/eggs.png" alt="The Finished Dish" />';
    json = {
      type: 'doc',
      content: [{
        type: 'image',
        attrs: {
          src: 'https://example.com/eggs.png',
          alt: 'The Finished Dish'
        }
      }]
    }

    renderer = HtmlToProsemirror::Renderer.new()
    expect(json).to eq renderer.render(html)
  end
end
