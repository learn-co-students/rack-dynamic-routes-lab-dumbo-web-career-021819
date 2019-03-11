class Application

  @@items= [Item.new("goofy",1.00)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      # neither of the two conditions are going thru
      item_name = req.path.split("/items/")[-1]

       if @@items.find{ |i| i.name == item_name } != nil
         item = @@items.find{ |i| i.name == item_name }
         resp.write "#{item.price}"
         # resp.write item.price
         resp.status = 200
      else
         resp.write "Item not found"
         resp.status = 400
       end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
