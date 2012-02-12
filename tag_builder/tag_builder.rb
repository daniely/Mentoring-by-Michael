require 'pry'

def tag_builder(tag)
  TagBuilder.new(tag)
end

class TagBuilder
  attr_accessor :tag

  def initialize(tag)
    self.tag = tag
  end

  def [](*args)
    markup = ''
    # treat hashes as tag attributes
    attributes = args.map{ |a| a.kind_of?(Hash) ? a : nil }.compact
    # everything else is considered text
    text = args - attributes

    if attributes.empty?
      markup = "<#{tag}>#{text.join(' ')}</#{tag}>"
    else
      att_array = []
      attributes.map! do |a|
        a.each_pair { |key,value| att_array << %~#{key}="#{value}"~ }
      end

      markup = "<#{tag} #{att_array.join(' ')}>#{text.join(' ')}</#{tag}>"
    end

    markup
  end
end

describe "tag_builder" do
  it 'builds simple tags' do
    title = tag_builder("h1")
    title["Test"].should == "<h1>Test</h1>"
  end

  it 'builds anchor tags' do
    link = tag_builder("a")
    link["a link", :href => "http://foo.com"].should == %~<a href="http://foo.com">a link</a>~
  end

  it 'builds nested tags' do
    link = tag_builder("a")
    bold = tag_builder("b")
    markup = bold["Bold text with", link["a link", :href => "http://bar.com"], "inside a paragraph."]
    markup.should == %~<b>Bold text with <a href="http://bar.com">a link</a> inside a paragraph.</b>~
  end

  it 'builds complex tags' do
    para = tag_builder("p")
    link = tag_builder("a")
    bold = tag_builder("b")
    markup = para[bold["Bold text with", link["a link", :href => "http://bar.com"], "inside a paragraph."]]
    markup.should == %~<p><b>Bold text with <a href="http://bar.com">a link</a> inside a paragraph.</b></p>~
  end
end
