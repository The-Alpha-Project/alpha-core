from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.MiscCodes import CreatureAIEventTypes
import random

class AIEventHandler():
    def __init__(self, creature):
        self.creature = creature

    def on_spawn(self):
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(self.creature.entry)        
        if events:
            for event in events:
                if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_CAST_SPELL_ON_SPAWN:
                    chance_roll = random.randint(0, 100)
                    if chance_roll <= event.event_chance:
                        script = WorldDatabaseManager.creature_ai_script_get_by_id(event.action1_script)
                        if script:
                            self.creature.script_handler.enqueue_ai_script(self.creature, script)
                    break
    
    def on_enter_combat(self):        
        self.creature.script_handler.reset() # Reset any scripts that were queued before combat (e.g. on spawn).

        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(self.creature.entry)

        if events:            
            for event in events:
               if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_RANDOM_SAY_ON_AGGRO:                    
                    chance_roll = random.randint(0, 100)                    
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
                            self.creature.script_handler.enqueue_ai_script(self.creature, script)
                    break

    def on_damage_taken(self):
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(self.creature.entry)

        if events:
            for event in events:
                if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_FLEE_AT_LOW_HP:
                    # In rare cases event_param1 is not the health breakpoint but something else?
                    if event.event_param1 > 0 and event.event_param1 <= 100: 
                        current_health_percent = (self.creature.health / self.creature.max_health) * 100                       
                        if current_health_percent <= event.event_param1 and self.creature.script_handler.last_flee_event != event: 
                            script = WorldDatabaseManager.creature_ai_script_get_by_id(event.action1_script)
                            if script:
                                self.creature.script_handler.last_flee_event = event
                                self.creature.script_handler.enqueue_ai_script(self.creature, script)
                        # If event1_param is zero the script should be run on aggro.
                        elif event.event_param1 == 0 and self.creature.script_handler.last_flee_event != event:
                            script = WorldDatabaseManager.creature_ai_script_get_by_id(event.action1_script)
                            if script:
                                self.creature.script_handler.last_flee_event = event
                                self.creature.script_handler.enqueue_ai_script(self.creature, script)
                        break
    
    def on_idle(self): 
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(self.creature.entry)

        if events:
            for event in events:
                if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_RANDOM_EMOTE_OOC:
                    self.creature.script_handler.set_random_ooc_event(self.creature, event)
                    break

    def on_death(self):
        events = WorldDatabaseManager.creature_ai_event_get_by_creature_id(self.creature.entry)

        if events:
            for event in events:
                if event.event_type == CreatureAIEventTypes.AI_EVENT_TYPE_ON_DEATH:                    
                    chance_roll = random.randint(0, 100)                    
                    if chance_roll <= event.event_chance:

                        choices = []
                        if event.action1_script > 0:
                            choices.append(event.action1_script)
                        if event.action2_script > 0:
                            choices.append(event.action2_script)
                        if event.action3_script > 0:
                            choices.append(event.action3_script)

                        script = WorldDatabaseManager.creature_ai_script_get_by_id(random.choice(choices))
                        if script:
                            self.creature.script_handler.enqueue_ai_script(self.creature, script)
                            break
                    
        