class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      resp.write handle_items
    elsif req.path.match(/cart/)
      resp.write handle_cart
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write handle_add(search_term)
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_items
    @@items.each_with_object("") {|item, item_string| item_string << "#{item}\n"}
  end

  def handle_cart
    if @@cart.empty?
      return "Your cart is empty"
    else
      return @@cart.each_with_object("") {|item, item_string| item_string << "#{item}\n"}
    end
  end

  def handle_add(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      return "added #{search_term}"
    else
      return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
