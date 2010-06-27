module CodeRay
  class Tokens
    AbbreviationForKind = Hash.new do |h, k|  # :nodoc:
      if $CODERAY_DEBUG
        raise 'Undefined Token kind: %p' % [k]  # :nodoc:
      else
        false
      end
    end
    AbbreviationForKind.update with = {  # :nodoc:
      :annotation => 'at',
      :attribute_name => 'an',
      :attribute_value => 'av',
      :bin => 'bi',
      :char => 'ch',
      :class => 'cl',
      :class_variable => 'cv',
      :color => 'cr',
      :comment => 'c',
      :complex => 'cm',
      :constant => 'co',
      :content => 'k',
      :decorator => 'de',
      :definition => 'df',
      :delimiter => 'dl',
      :directive => 'di',
      :doc => 'do',
      :doctype => 'dt',
      :doc_string => 'ds',
      :entity => 'en',
      :error => 'er',
      :escape => 'e',
      :exception => 'ex',
      :filename => 'filename',
      :float => 'fl',
      :function => 'fu',
      :global_variable => 'gv',
      :hex => 'hx',
      :imaginary => 'cm',
      :important => 'im',
      :include => 'ic',
      :inline => 'il',
      :inline_delimiter => 'idl',
      :instance_variable => 'iv',
      :integer => 'i',
      :interpreted => 'in',
      :key => 'ke',
      :keyword => 'kw',
      :label => 'la',
      :local_variable => 'lv',
      :modifier => 'mod',
      :namespace => 'ns',
      :oct => 'oc',
      :predefined => 'pd',
      :preprocessor => 'pp',
      :pre_constant => 'pc',
      :pre_type => 'pt',
      :pseudo_class => 'ps',
      :regexp => 'rx',
      :reserved => 'r',
      :shell => 'sh',
      :string => 's',
      :symbol => 'sy',
      :tag => 'ta',
      :tag_special => 'ts',
      :type => 'ty',
      :value => 'vl',
      :variable => 'v',
      
      :insert => 'ins',
      :delete => 'del',
      :change => 'chg',
      :head => 'head',
      
      :eyecatcher => 'eye',
      
      :ident => false, # 'id'
      :operator => false,  # 'op'
      
      :space => false,  # 'sp'
      :plain => false,
    }
    AbbreviationForKind[:method] = AbbreviationForKind[:function]
    AbbreviationForKind[:nesting_delimiter] = AbbreviationForKind[:delimiter]
    AbbreviationForKind[:escape] = AbbreviationForKind[:delimiter]
    AbbreviationForKind[:docstring] = AbbreviationForKind[:comment]
    #AbbreviationForKind.default = AbbreviationForKind[:error] or raise 'no class found for :error!'
  end
end
