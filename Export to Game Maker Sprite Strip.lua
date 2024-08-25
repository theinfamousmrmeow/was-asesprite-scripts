-- Export each tag into a different sprite sheet

local spr = app.activeSprite
if not spr then return print('No active sprite') end

local path,title = spr.filename:match("^(.+[/\\])(.-).([^.]*)$")
local msg = { "Do you want to export/overwrite the following files?" }

for i,tag in ipairs(spr.tags) do
  local fn = path .. title .. '_' .. tag.name
  table.insert(msg, '_' .. fn .. '_strip' .. tag.frames .. '.[png]')
end

if app.alert{ title="Export Sprite Sheets", text=msg,
              buttons={ "&Yes", "&No" } } ~= 1 then
  return
end

for i,tag in ipairs(spr.tags) do
  local frames = 1
  local fn = path .. '/' .. title .. '_' .. tag.name .. '_strip' .. tag.frames
  app.command.ExportSpriteSheet{
    ui=false,
    type=SpriteSheetType.HORIZONTAL,
    textureFilename=fn .. '.png',
    tag=tag.name,
    listLayers=false,
    listTags=false,
    listSlices=false,
  }
end
