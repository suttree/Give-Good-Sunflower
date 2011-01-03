class OutputCompressionFilter
  def self.filter(controller)
    controller.response.body = controller.response.body.gsub(/^\s+/, '').gsub(/\s+$/, $/)
  end
end
