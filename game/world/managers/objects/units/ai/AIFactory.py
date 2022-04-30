from game.world.managers.objects.units.ai.BasicCreatureAI import BasicCreatureAI
from game.world.managers.objects.units.ai.CritterAI import CritterAI
from game.world.managers.objects.units.ai.GuardAI import GuardAI
from game.world.managers.objects.units.ai.NullCreatureAI import NullCreatureAI
from game.world.managers.objects.units.ai.PetAI import PetAI
from game.world.managers.objects.units.ai.TotemAI import TotemAI
from utils.Logger import Logger


class AIFactory:

    # TODO, scripted AI's, EventAI.
    @staticmethod
    def build_ai(creature):
        # TODO, Pet check.
        if creature.is_pet():
            return PetAI(creature)

        # TODO, Totem check.
        if creature.is_totem():
            return TotemAI(creature)

        if creature.is_guard():
            return GuardAI(creature)

        if creature.is_critter():
            return CritterAI(creature)

        if creature.creature_template.ai_name:
            ai_name = creature.creature_template.ai_name
            return AIFactory.get_ai_by_ai_name(ai_name, creature)

        return NullCreatureAI(creature)

    @staticmethod
    def get_ai_by_ai_name(ai_name, creature):
        if ai_name == 'NullAI':
            return NullCreatureAI(creature)
        elif ai_name == 'BasicAI':
            return BasicCreatureAI(creature)
        elif ai_name == 'CritterAI':
            return CritterAI(creature)
        elif ai_name == 'GuardAI':
            return GuardAI(creature)
        elif ai_name == 'PetAI':
            return PetAI(creature)
        elif ai_name == 'TotemAI':
            return TotemAI(creature)
        # TODO, EventAI's.
        else:
            Logger.warning(f'Unimplemented ai {ai_name}')
            return BasicCreatureAI(creature)
