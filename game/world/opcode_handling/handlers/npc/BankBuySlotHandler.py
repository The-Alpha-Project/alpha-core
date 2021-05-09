class BankBuySlotHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Client validates coinage before triggering CMSG_BUY_BANK_SLOT
        world_session.player_mgr.add_bank_slot()
        return 0
