RSpec.describe HtmlToTiptap::Nodes::BulletList do
  it "renders bullet list correctly" do
    html = '<ul><li><p>First Example</p></li><li><p>Second Example</p></li></ul>';
    json = {
      type: 'doc',
      content: [{
        type: 'bulletList',
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
