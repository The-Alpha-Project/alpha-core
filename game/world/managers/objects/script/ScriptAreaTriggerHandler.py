from game.world.managers.abstractions.Vector import Vector


class ScriptAreaTriggerHandler:

    @staticmethod
    def handle_area_trigger(trigger_id, unit):
        if trigger_id not in AREA_TRIGGER_HANDLERS:
            return False

        AREA_TRIGGER_HANDLERS[trigger_id](unit)

        return True

    @staticmethod
    def handle_test_of_faith(unit):
        # Teleports player back to quest giver Dorn Plainstalker.
        unit.teleport(unit.map_id, Vector(-5191.74, -2802.54, -8.1978, 5.792), delay_secs=3)


AREA_TRIGGER_HANDLERS = {
    246 : ScriptAreaTriggerHandler.handle_test_of_faith
}
