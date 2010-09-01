# I need to stringify keys, but I don't want to include the whole Rails framework, so I'm going extend Hash myself.
class Hash
  def stringify_keys!
    keys.each do |key|
      self[key.to_s] = delete(key)
    end
    self
  end
end