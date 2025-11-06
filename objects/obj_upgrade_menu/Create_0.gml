// Макросы для разделов меню
#macro MENU_MAIN 0
#macro MENU_DAMAGE 1
#macro MENU_DEFENSE 2
#macro MENU_ECONOMY 3

// Текущий активный раздел и выбранный элемент
currentMenu = MENU_MAIN;
currentIndex = 0;
selectedIndex = -1;

// Позиция и размеры меню
menuY = display_get_gui_height() - 150;
menuHeight = 150;
itemWidth = 120;
itemHeight = 100;
itemSpacing = 10;

// Переменные для прокрутки
currentScroll = 0;
maxScroll = 0;
isDragging = false;
dragStartX = 0;
scrollVelocity = 0;

// Структура меню
menu = [];

// Главное меню (категории)
menu[MENU_MAIN] = [
    "Урон",
    "Защита", 
    "Экономика"
];

// Меню раздела "Урон"
menu[MENU_DAMAGE] = [];
menu[MENU_DAMAGE][0] = { name: "Урон", sprite: Sprite5, currentLevel: 1, maxLevel: 3000, cost: 10, desc: "Увеличивает урон" };
menu[MENU_DAMAGE][1] = { name: "Скорость атаки", sprite: Sprite5, currentLevel: 1, maxLevel: 41, cost: 15, desc: "Ускоряет атаку" };
menu[MENU_DAMAGE][2] = { name: "Шанс крита", sprite: Sprite5, currentLevel: 1, maxLevel: 200, cost: 5, desc: "Увеличивает шанс крита" };
menu[MENU_DAMAGE][3] = { name: "Урон крита", sprite: Sprite5, currentLevel: 1, maxLevel: 3000, cost: 5, desc: "Увеличивает множитель крита" };
menu[MENU_DAMAGE][4] = { name: "Радиус атаки", sprite: spr_upgrade_radius, currentLevel: 1, maxLevel: 69, cost: 5, desc: "Увеличивает радиус атаки" };
menu[MENU_DAMAGE][5] = "Назад";

// Меню раздела "Защита"
menu[MENU_DEFENSE] = [];
menu[MENU_DEFENSE][0] = { name: "ХП", sprite: Sprite5, currentLevel: 1, maxLevel: 3000, cost: 10, desc: "Увеличивает здоровье" };
menu[MENU_DEFENSE][1] = { name: "Реген", sprite: Sprite5, currentLevel: 1, maxLevel: 3000, cost: 10, desc: "Увеличение регенерации" };
menu[MENU_DEFENSE][2] = { name: "Броня", sprite: Sprite5, currentLevel: 1, maxLevel: 3000, cost: 20, desc: "Плоское снижение урона" };
menu[MENU_DEFENSE][3] = { name: "Процент брони", sprite: spr_armor_percent, currentLevel: 1, maxLevel: 99, cost: 15, desc: "Процент снижения урона" };
menu[MENU_DEFENSE][4] = { name: "Вампиризм", sprite: Sprite5, currentLevel: 1, maxLevel: 100, cost: 15, desc: "Процент восстановления от урона" };
menu[MENU_DEFENSE][5] = "Назад";

// Меню раздела "Экономика"  
menu[MENU_ECONOMY] = [];
menu[MENU_ECONOMY][0] = { name: "Золото с врага", sprite: Sprite5, currentLevel: 1, maxLevel: 3000, cost: 15, desc: "Увеличивает золото" };
menu[MENU_ECONOMY][1] = { name: "Бонус к опыту", sprite: Sprite5, currentLevel: 1, maxLevel: 3000, cost: 15, desc: "Увеличивает опыт" };
menu[MENU_ECONOMY][2] = "Назад";