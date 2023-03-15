import math
import random


class MiningNodeManager(object):
    def __init__(self, mining_node):
        self.mining_node = mining_node
        self.min_restock = mining_node.gobject_template.data4
        self.max_restock = mining_node.gobject_template.data5
        self.attempts = 0

    # TODO: Need to handle chance also on spell effect.
    def handle_looted(self, player):
        self.attempts += 1
        amount_rate = 1.0
        min_amount = self.min_restock * amount_rate
        max_amount = self.max_restock * amount_rate

        # Max attempts, despawn.
        if self.attempts >= max_amount:
            self.mining_node.despawn()
            return

        # 100% chance until min uses.
        if self.attempts < min_amount:
            self.mining_node.set_ready()
            self.mining_node.loot_manager.generate_loot(player)
            return

        chance_rate = 1.0
        # TODO: need to override required_value from Locks.dbc, if available.
        required_value = 175
        skill_total = player.skill_manager.get_total_skill_value(11) / (required_value + 25)
        chance = math.pow(0.8 * chance_rate, 4 * (1 / self.max_restock) * self.attempts)
        succeed_roll = 100.0 * chance + skill_total > random.uniform(0.0, 99.9999999)

        # Failed chance roll, despawn.
        if not succeed_roll:
            self.mining_node.despawn()
            return

        # Node still alive, regenerate loot.
        self.mining_node.set_ready()
        self.mining_node.loot_manager.generate_loot(player)
