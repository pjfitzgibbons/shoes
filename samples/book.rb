class Book < Shoes
  url '/', :index
  url '/incidents/(\d+)', :incident

  def index
    incident(0)
  end

  INCIDENTS = YAML.load_file('samples/book.yaml')

  def table_of_contents
    toc = []
    INCIDENTS.each_with_index do |(title, story), i|
      toc.push "(#{i + 1}) ",
        link(title, :url => "/incidents/#{i}"),
        " / "
    end
    toc.pop
    span *toc
  end

  def incident(num)
    num = num.to_i
    flow :margin => 10, :margin_left => 190, :margin_top => 20 do
      banner "Incident\n"
      para strong("No. #{num + 1}: #{INCIDENTS[num][0]}")
    end
    flow :width => 180, :margin_left => 10, :margin_top => 10 do
      para table_of_contents, :font => "Arial 11px", :leading => 0
    end
    flow :width => -190, :margin => 10 do
      para INCIDENTS[num][1]
    end
  end
end

Shoes.app :width => 640, :height => 700,
  :title => "Incidents, a Book"
