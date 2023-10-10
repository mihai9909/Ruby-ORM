module CaseConverter
  def snakecase
    self.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z])([A-Z])/,'\1_\2').downcase
  end

  def camelcase
    self.gsub(/_./) { |s| s[1].capitalize }.gsub(/^./){ |s| s.capitalize }
  end
end

String.include(CaseConverter)
