local fibaro = {}

function fibaro.get(deviceId,values)
  print('get');
  if (deviceId == 100) then
    return 120;
  elseif(deviceId == 200) then
    return 40;
  elseif(deviceId == 300) then
    return 0;
  end
end

function fibaro.call(deviceId,actionType,values)
print('call');
end


return fibaro
