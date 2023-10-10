module Inflector
  def singular
    return irregular_singulars[self] unless irregular_singulars[self].nil?

    self.gsub(/(s|es)$/, '').gsub(/i$/, 'y').gsub(/v$/, 'f')
  end

  def plural
    downcased_string = self.downcase
    return irregular_plurals[downcased_string] unless irregular_plurals[downcased_string].nil?

    case downcased_string
    when /(ss|sh|ch)$/
      return self << 'es'
    when /[^aeiou\s]y$/
      return self.gsub(/(y|Y)$/, 'ies')
    when /f$/
      return self.gsub(/(f|F)$/, 'ves')
    else
      return self << 's'
    end
  end

  private
  def irregular_singulars
    irregular_plurals.invert
  end

  def irregular_plurals 
    @irregulars_path ||= File.expand_path("../irregular-plurals.json", __FILE__)
    @irregulars ||= JSON.parse(File.read(@irregulars_path))
  end
end

String.include(Inflector)

