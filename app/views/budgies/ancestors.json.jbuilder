json.array! @budgies do |budgie|
  json.extract! budgie, :id, :name, :gender, :color_id, :age, :tribal, :father_id, :mother_id
end
