// В Collision Event с пулей врага:
if (other.can_damage) {
    hp -= global.crit_dmg_mod * global.dmg
    // Дополнительные эффекты: анимация, звук и т.д.
}