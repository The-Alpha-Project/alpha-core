class LootMoneyHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        world_session.player_mgr.loot_money()
        return 0
