fibaro = require("Fibaro")

ArtWallController = {};
ArtWallController.__index = ArtWallController;

sensor = 100;
dimmer = 200;
alarm = 300;

function ArtWallController:setIntervalVeryficationForSensor(deviceId,values)
  fibaro.call(deviceId,'interval',values)
end

function ArtWallController:getLightPowerFromTools(deviceId)
  local value = fibaro.get(deviceId,'brightness');
  return value;
end

function ArtWallController:setLightPowerForDimmer(deviceId,values)
  fibaro.call(deviceId,'brightness',values);
end

function ArtWallController:getAlarmStatus(deviceId)
  local value = fibaro.get(deviceId,"alarmStatus");
  return value;
end

function ArtWallController:lightCalculator(deviceIdSensor, deviceIdDimmer, limit)

  local roomAllLight = artWallController:getLightPowerFromTools(deviceIdSensor);
  local artificialLight = artWallController:getLightPowerFromTools(deviceIdDimmer);
  local newPowerLight = 0;

  if(roomAllLight < 100) then
    local value = 100 - roomAllLight;
    newPowerLight = value;
  elseif(roomAllLight > 100) then
    local value = roomAllLight - 100;
    if(value >= artificialLight) then
      newPowerLight = 0;
    else
      newPowerLight = artificialLight - value;
    end
  end

  return newPowerLight;

end

function ArtWallController:main()
  artWallController = ArtWallController;
  artWallController:setIntervalVeryficationForSensor(sensor,10);

  local alarm = artWallController:getAlarmStatus(alarm);
  if(alarm == 0) then

    local newPowerLight = artWallController:lightCalculator(sensor,dimmer,100);
    artWallController:setLightPowerForDimmer(dimmer,newPowerLight)
  else

    artWallController:setLightPowerForDimmer(dimmer,0);

  end
end

artWallController = ArtWallController:main();
