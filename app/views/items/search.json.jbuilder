json.array! @m_category do |m|
	json.id  m.id
	json.name m.name
end

json.array! @s_category do |s|
	json.id s.id
	json.name s.name
end
