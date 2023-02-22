from utils.Logger import Logger
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.ScriptHandler import ScriptHandler
from utils.constants.MiscCodes import CreatureAIEventTypes
import random
import numpy as np

class AIEventHandler():

    @staticmethod
    def on_spawn(creature):
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(creature.entry)
        Logger.info('AIEventHandler.on_spawn() called')
        if events:
            for event in events:
                if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_CAST_SPELL_ON_SPAWN:
                    chance_roll = random(0, 100)
                    if chance_roll <= event.event_chance:
                        script = WorldDatabaseManager.creature_ai_script_get_by_id(event.action1_script)
                        if script:
                            ScriptHandler.enqueue_ai_script(creature, script)
                    break

    @staticmethod
    def on_enter_combat(creature):
        Logger.info('AIEventHandler.on_enter_combat() called')
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(creature.entry)

        if events:
            for event in events:
               if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_RANDOM_SAY_ON_AGGRO:
                    chance_roll = random(0, 100)
                    if chance_roll <= event.event_chance:
                        choices = []
                        if event.action1_script > 0:
                            choices.append(event.action1_script)
                        if event.action2_script > 0:
                            choices.append(event.action2_script)
                        if event.action3_script > 0:
                            choices.append(event.action3_script)

                        script = WorldDatabaseManager.creature_ai_script_get_by_id(np.random.choice(choices))
                        if script:
                            ScriptHandler.enqueue_ai_script(creature, script)
                    break

    @staticmethod
    def on_low_health(creature):
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(creature.entry)

        if events:
            for event in events:
                if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_FLEE_AT_LOW_HP:
                    # TODO: Implement flee at low hp
                    break
    
    @staticmethod
    def on_idle(creature): # TODO: implement initial and repeat delay
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(creature.entry)

        if events:
            for event in events:
                if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_RANDOM_EMOTE_OOC:
                    chance_roll = random(0, 100)
                    if chance_roll <= event.event_chance:
                        script = WorldDatabaseManager.creature_ai_script_get_by_id(event.event_script_id)
                        if script:
                            ScriptHandler.enqueue_ai_script(creature, script)
        