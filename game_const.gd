extends Reference
class_name GameConst

enum Character {
	GENERAL,
	PALADIN,
	SWORDSMAN,
	MAGE,
}

enum CardType {
	ATTACK,
	DEFEND,
	SKILL,
	CURSE,
}

enum CardRarity {
	COMMON,
	UNCOMMON,
	RARE,
}

# 节点类型
enum NodeTypeEnum {
	# 空
	EMPTY,
	# 怪物
	MONSTER,
	# 商人
	BUSINESS_MAN,
	# 学者
	SCHOLAR,
	# 苦行僧
	ASCETIC_MONK,
	# 宝箱
	TREASURE,
	# 瞭望塔
	WATCH_TOWER,
	# 火树
	FIRE_TREE,
	# 方尖碑
	OBELISK,
	# 神庙
	TEMPLE,
	# 女巫小屋
	WITCH_HUT,
	# 起点
	STARTING_POINT,
	# 终点
	DESTINATION,
}
