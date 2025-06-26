
Private = Private

Private.private_BerranteStringIsBinary = function(path)
  local arquivo = io.open(path, "r")
  if arquivo then
    arquivo:close()
    return false
  end

  return true
end
