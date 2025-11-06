
var _baseY = menuY;
var _startX = itemSpacing + itemWidth

draw_set_font(cs);
draw_set_halign(fa_left)


for (var i = 0; i <  array_length(global.all_skills); i++) {
	var _elementX = _startX;
    var _elementY = _baseY + i * (itemHeight + itemSpacing);
	
	var _stat_name = global.all_skills[i].display_name;
	var _stat_value = variable_global_get(global.all_skills[i].var_name)
	
	draw_set_color(c_green);
	draw_text(_elementX, _elementY, string(_stat_name) + ":" + string(_stat_value))
	
}