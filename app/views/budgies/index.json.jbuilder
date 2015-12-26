json.array!(@budgies) do |budgy|
  json.extract! budgy, :id, :name, :gender, :color_id, :age, :tribal
end
