from utils.Logger import Logger
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.ScriptHandler import ScriptHandler
from utils.constants.MiscCodes import CreatureAIEventTypes
import random

class AIEventHandler():

    @staticmethod
    def on_spawn(creature):
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(creature.entry)
        Logger.info('AIEventHandler.on_spawn() called')
        if events:
            for event in events:
                if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_CAST_SPELL_ON_SPAWN:
                    chance_roll = random.randint(0, 100)
                    if chance_roll <= event.event_chance:
                        script = WorldDatabaseManager.creature_ai_script_get_by_id(event.action1_script)
                        if script:
                            creature.script_handler.enqueue_ai_script(creature, script)
                    break

    @staticmethod
    def on_enter_combat(creature):
        Logger.info('AIEventHandler.on_enter_combat() called')
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(creature.entry)

        if events:
            Logger.debug('AIEventHandler.on_enter_combat() events found')
            for event in events:
               if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_RANDOM_SAY_ON_AGGRO:
                    Logger.debug('AIEventHandler.on_enter_combat() AI_EVENT_TYPE_RANDOM_SAY_ON_AGGRO found')
                    chance_roll = random.randint(0, 100)
                    Logger.debug('AIEventHandler.on_enter_combat() chance_roll: ' + str(chance_roll) + " event_chance: " + str(event.event_chance))
                    if chance_roll <= event.event_chance:
                        choices = []
                        if event.action1_script > 0:
                            choices.append(event.action1_script)
                        if event.action2_script > 0:
                            choices.append(event.action2_script)
                        if event.action3_script > 0:
                            choices.append(event.action3_script)

                        script = WorldDatabaseManager.creature_ai_script_get_by_id(choices[random.randint(0, len(choices) - 1)])
                        if script:
                            creature.script_handler.enqueue_ai_script(creature, script)
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
                    creature.script_handler.set_random_ooc_event(creature, event)
                    break
        