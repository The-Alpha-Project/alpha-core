from game.world.managers.objects.spell.aura.AppliedAura import AppliedAura
from game.world.managers.objects.spell.aura.AuraEffectHandler import AuraEffectHandler


class AreaAuraHolder:

    def __init__(self, effect):
        self.spell_id = effect.casting_spell.spell_entry.ID
        self.effect = effect
        self.current_targets = dict()

    def update(self, now):
        if self.effect.applied_aura_duration != -1:
            self.effect.update_effect_aura(now)
        self.effect.handle_periodic_resource_cost(now)

        self.update_effect_on_targets()
        self.effect.remove_old_periodic_effect_ticks()

    def update_effect_on_targets(self, remove=False):
        # Effect updates/other events can cause a change in current targets - copy values for iteration.
        for target, aura_index in list(self.current_targets.values()):
            aura = target.aura_manager.get_aura_by_index(aura_index)
            if not aura:
                self.current_targets.pop(target.guid)
                continue
            if remove or aura.is_periodic():
                AuraEffectHandler.handle_aura_effect_change(aura, target, remove=remove)

    def add_target(self, target):
        new_aura = AppliedAura(self.effect.casting_spell.spell_caster, self.effect.casting_spell, self.effect, target)
        aura_index = target.aura_manager.add_aura(new_aura)
        self.current_targets[target.guid] = (target, aura_index)
        if self.effect.casting_spell.dynamic_object:
            self.effect.casting_spell.dynamic_object.add_dynamic_target(target)

    def remove_target(self, target_guid):
        target, aura_index = self.current_targets.pop(target_guid, (None, -1))
        if not target:
            return

        from game.world.managers.objects.units.UnitManager import UnitManager
        if not isinstance(target, UnitManager):
            return

        aura = target.aura_manager.get_aura_by_index(aura_index)
        if aura:
            target.aura_manager.remove_aura(aura)

    def destroy(self):
        self.update_effect_on_targets(remove=True)
        for target, aura_index in list(self.current_targets.values()):
            aura = target.aura_manager.get_aura_by_index(aura_index)
            target.aura_manager.remove_aura(aura)
        self.current_targets.clear()
