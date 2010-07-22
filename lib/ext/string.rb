class String
  def strip_http
    self.gsub(/^http\:\/\//,'').gsub(/\/$/,'')
  end
end