json.array! @colors do |color|
  json.extract! color, :id, :name
end
