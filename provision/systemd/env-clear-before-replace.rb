class << ENV
  alias orig_replace replace
  def replace(h)
    clear
    orig_replace(h)
  end
end
