class Application

  def call(env)
    # /items/<ITEM NAME>
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    # binding.pry
    unless req.path.match(/items/)
      resp.write "Route not found"
      resp.status = 404
    else
      item_name = req.path.split("/items/").last
      if Item.names.include?(item_name)
        found_item = Item.all.find{|i| i.name == item_name}
        resp.write found_item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    end
    resp.finish
  end

end
