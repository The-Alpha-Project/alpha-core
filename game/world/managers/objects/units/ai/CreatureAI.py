class CreatureAI(object):
    # Creature spell lists should be updated every 1.2 seconds according to research.
    # https://www.reddit.com/r/wowservers/comments/834nt5/felmyst_ai_system_research/
    CREATURE_CASTING_DELAY = 1200

    def __init__(self, unit):
        self.unit = unit
        self.use_ai_at_control = False
        self.melee_attack = True  # If we allow melee auto attack.
        self.combat_movement = True  # If we allow targeted movement gen (chasing target).
        self.casting_delay = 0  # Cool-down before updating spell list again.
        self.last_alert_time = 0
        self.creature_spells = []  # Contains the currently used creature_spells template.
        self.set_spell_list()

    # Called at World update tick
    def update_ai(self, elapsed):
        pass

    # Like UpdateAI, but only when the creature is a dead corpse.
    def update_ai_corpse(self, elapsed):
        pass

    def permissible(self, creature):
        pass

    # Distract creature, if player gets too close while stealth/prowling.
    def trigger_alert(self, unit):
        pass

    # Called when the creature is killed.
    def just_died(self, unit):
        pass

    # Called when the creature summon is killed.
    def summoned_creature_just_died(self, creature):
        pass

    # Group member just died.
    def group_member_just_died(self, unit, is_leader):
        pass

    # Called when the creature kills a unit.
    def killed_unit(self, unit):
        pass

    # Called when owner of m_creature (if m_creature is PROTECTOR_PET) kills a unit.
    def owner_killed_unit(self, unit):
        pass

    # Called only for pets.
    # override
    def owner_attacked_by(self, attacker):
        pass

    # Called only for pets.
    # override
    def owner_attacked(self, target):
        pass

    # Called before being removed from the map.
    def on_remove_from_world(self):
        pass

    # Called when the corpse of this creature gets removed.
    def corpse_removed(self, respawn_delay):
        pass

    # Called by another script.
    def on_script_happened(self, event, data, world_object):
        pass

    # Called when hit by a spell.
    def spell_hit(self, caster, spell_entry):
        pass

    # Called when spell hits creature's target.
    def spell_hit_target(self, unit, spell_entry):
        pass

    # Called when creature is spawned or respawned (for reseting variables).
    def just_respawned(self):
        # Reset spells template to default on respawn.
        # Reset combat movement and melee attack.
        pass

    # Called when the creature summon successfully other creature or gameobject.
    def just_summoned(self, world_object):
        pass

    # Called at waypoint reached or point movement finished.
    def movement_inform(self, move_type, data):
        pass

    # Called at text emote receive from player.
    def receive_emote(self, player, emote):
        pass

    # Called if a temporary summoned of m_creature reach a move point.
    def summoned_movement_inform(self, creature, motion_type, point_id):
        pass

    # Called when the creature summon despawn.
    def summoned_creatures_despawn(self, creature):
        pass

    # Called when the creature is target of hostile action: swing, hostile spell landed, fear/etc).
    def attacked_by(self, attacker):
        pass

    # Called when creature attack expected (if creature can and no have current victim).
    # Note: for reaction at hostile action must be called AttackedBy function.
    def attack_start(self, victim):
        pass

    def can_cast_spell(self, target, spell_entry, triggered):
        pass

    def do_cast_spell_if_can(self, target, spell_id, cast_flags, original_caster_guid):
        pass

    def set_spell_list(self, spell_list):
        pass

    def update_spell_list(self, elapsed):
        pass

    def do_spell_list_cast(self, elapsed):
        pass

    def do_cast(self, victim, spell_id, triggered):
        pass

    def do_cast_aoe(self, spell_id, triggered):
        pass

    # Will auto attack if the swing timer is ready.
    def do_melee_attack_if_ready(self):
        pass

    # Might not need below, or just use LootManagers.
    # Is corpse looting allowed?
    def can_be_looted(self):
        return True

    # Might not need below, or just use LootManagers.
    # Is corpse looting allowed?
    def fill_loot(self):
        pass

    def is_combat_movement_enabled(self):
        return self.combat_movement

    def is_melee_attack_enabled(self):
        return self.melee_attack

    def set_melee_attack(self, enabled):
        pass

    def set_combat_movement(self, enabled):
        pass

    # Called for reaction at enter to combat if not in combat yet (enemy can be None).
    def enter_combat(self, unit):
        pass

    # Called when leaving combat.
    def on_combat_stop(self):
        # Reset back to default spells template. This also resets timers.
        # Reset combat movement and melee attack.
        pass

    # Called at any Damage to any victim (before damage apply).
    def damage_deal(self, unit, damage):
        pass

    # Called at any Damage from any attacker (before damage apply).
    # Note: it for recalculation damage or special reaction at damage
    # for attack reaction use AttackedBy called for not DOT damage in Unit::DealDamage also
    def damage_taken(self, attacker, damage):
        pass

    # Called at any heal cast/item used (call non implemented).
    def healed_by(self):
        pass

    # Called at reaching home after evade.
    def just_reached_home(self):
        pass

    # Called when an unit moves within visibility distance.
    def move_in_line_of_sight(self, unit):
        pass

    # Called for reaction at stopping attack at no attackers or targets.
    def enter_evade_mode(self):
        pass







