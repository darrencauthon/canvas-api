module Canvas

  class ResultSet < Array
    def initialize(api, arr)
      @api = api
      super(arr)
    end
    attr_accessor :next_endpoint
    attr_accessor :link
    
    def more?
      !!next_endpoint
    end
    
    def next_page!
      ResultSet.new(@api, []) unless next_endpoint
      more = @api.get(next_endpoint)
      concat(more)
      @next_endpoint = more.next_endpoint
      @link = more.link
      more
    end
  end

end
