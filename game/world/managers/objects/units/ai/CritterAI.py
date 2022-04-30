from game.world.managers.objects.units.ai.CreatureAI import CreatureAI


class CritterAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)
        self.combat_timer = 0

    # override
    def update_ai(self, elapsed):
        pass

    # override
    def permissible(self, creature):
        pass

    # override
    def damage_taken(self, attacker, damage):
        pass

    # override
    def spell_hit(self, caster, spell_entry):
        pass
