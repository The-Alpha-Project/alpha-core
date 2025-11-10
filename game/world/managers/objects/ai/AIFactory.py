from __future__ import annotations

from typing import TYPE_CHECKING

from game.world.managers.objects.ai.BasicCreatureAI import BasicCreatureAI
from game.world.managers.objects.ai.CreatureAI import CreatureAI
from game.world.managers.objects.ai.CritterAI import CritterAI
from game.world.managers.objects.ai.EscortAI import EscortAI
from game.world.managers.objects.ai.GuardAI import GuardAI
from game.world.managers.objects.ai.GuardianAI import GuardianAI
from game.world.managers.objects.ai.NullCreatureAI import NullCreatureAI
from game.world.managers.objects.ai.PetAI import PetAI
from game.world.managers.objects.ai.TotemAI import TotemAI
from utils.constants.CustomCodes import Permits

if TYPE_CHECKING:
    from game.world.managers.objects.units.creature.CreatureManager import CreatureManager


class AIFactory:
    # Dummy instances used to select creature AI based upon permits.
    AI_REGISTRY = \
        {
            'NullAI': NullCreatureAI(None),
            'BasicAI': BasicCreatureAI(None),
            'CritterAI': CritterAI(None),
            'GuardAI': GuardAI(None),
            'PetAI': PetAI(None),
            'GuardianAI': GuardianAI(None),
            'TotemAI': TotemAI(None),
            'EscortAI': EscortAI(None)
            # 'EventAI': EventAI(None),
            # 'PetEventAI': PetEventAI(None),
            # 'GuardEventAI': GuardEventAI(None)
        }

    # TODO: scripted AI's, EventAI.
    @staticmethod
    def build_ai(creature: CreatureManager) -> CreatureAI:
        # TODO
        #  if not creature.is_pet() and creature.is_charmed_by_player() and creature.is_possessed():
        #      return new NullCreatureAI(creature);

        ai_name = creature.creature_template.ai_name
        selected_ai_name = ''

        # TODO: Allow scripting AI for normal creatures and not controlled pets (guardians and mini-pets)
        #  if not creature.is_pet() or not creature.is_controlled() and not creature.is_charmed():
        #      selected_ai = ScriptManager.get_creature_ai(creature)
        #      if selected_ai:
        #          return selected_ai

        if creature.is_totem():
            selected_ai_name = TotemAI.__name__
        elif creature.is_guardian():
            selected_ai_name = GuardianAI.__name__
        elif creature.is_controlled():
            # Use PetAI for any controlled creature.
            selected_ai_name = PetAI.__name__

        # TODO: EventAI assigned but creature is Pet.
        #  if not selected_ai and ai_name and creature.is_pet() and ai_name == 'EventAI':
        #         selected_ai = PetEventAI(creature)

        # TODO: EventAI assigned but creature is Guard.
        #  if not selected_ai && ai_name and creature.is_guard() and ai_name == 'EventAI':
        #         selected_ai = GuardEventAI(creature)

        # Select by script name.
        if not selected_ai_name and ai_name:
            selected_ai_name = AIFactory._get_ai_name_by_ai_template_name(ai_name)

        if not selected_ai_name and creature.is_guard():
            selected_ai_name = GuardAI.__name__

        if not selected_ai_name and creature.is_critter():
            selected_ai_name = CritterAI.__name__

        # Select by permits.
        if not selected_ai_name:
            best_permit = Permits.PERMIT_BASE_NO
            best_ai_name = None
            for ai_name, instance in AIFactory.AI_REGISTRY.items():
                ai_permit = instance.permissible(creature)
                if ai_permit > best_permit:
                    best_permit = ai_permit
                    best_ai_name = ai_name

            if best_permit != Permits.PERMIT_BASE_NO and best_ai_name:
                selected_ai_name = AIFactory._get_ai_name_by_ai_template_name(best_ai_name)

        # Creature already has an AI set, and it did not change.
        if selected_ai_name and creature.object_ai and type(creature.object_ai).__name__ == selected_ai_name:
            return creature.object_ai

        if selected_ai_name:
            return eval(f'{selected_ai_name}(creature)')

        # Return NullCreatureAI.
        return NullCreatureAI(creature)

    @staticmethod
    def _get_ai_name_by_ai_template_name(ai_name):
        if ai_name == 'NullAI':
            return NullCreatureAI.__name__
        elif ai_name == 'BasicAI':
            return BasicCreatureAI.__name__
        elif ai_name == 'CritterAI':
            return CritterAI.__name__
        elif ai_name == 'GuardAI':
            return GuardAI.__name__
        elif ai_name == 'PetAI':
            return PetAI.__name__
        elif ai_name == 'TotemAI':
            return TotemAI.__name__
        elif ai_name == 'EscortAI':
            return EscortAI.__name__
        elif ai_name == 'GuardianAI':
            return GuardianAI.__name__
        # elif ai_name == 'EventAI':
        #    return EventAI.__name__
        # elif ai_name == 'PetEventAI':
        #    return PetEventAI.__name__
        # elif ai_name == 'GuardEventAI':
        #    return GuardEventAI.__name__
        return None
