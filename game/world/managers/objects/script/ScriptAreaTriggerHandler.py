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
        unit.teleport(unit.map_id, Vector(-5187.56, -2804.52, -8.37701, 5.761), delay_secs=2)


AREA_TRIGGER_HANDLERS = {
    246 : ScriptAreaTriggerHandler.handle_test_of_faith
}
