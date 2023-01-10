from utils.constants.UpdateFields import PlayerFields


class Camera:
    def __init__(self, world_object):
        self.world_object = world_object
        self.cell_key = world_object.current_cell
        self.players = dict()  # Subscribed players.

    def broadcast_packet(self, packet, exclude=None):
        for player_mgr in list(self.players.values()):
            # Player went offline/crashed, pop.
            if not player_mgr.online or not player_mgr.is_alive:
                self.pop_player(player_mgr)
                continue
            # Player is not using camera view point, skip redirect.
            if not self.is_player_active_viewer(player_mgr):
                continue
            # Player already notified with this packet (near cell), skip.
            if exclude and player_mgr.guid in exclude:
                continue
            player_mgr.enqueue_packet(packet)

    def update_camera_on_players(self):
        for player_mgr in list(self.players.values()):
            player_mgr.update_known_objects_on_tick = True

    def has_player(self, player_mgr):
        return player_mgr.guid in self.players

    def push_player(self, player_mgr):
        self.players[player_mgr.guid] = player_mgr

    def is_player_active_viewer(self, player_mgr):
        current = player_mgr.get_uint64(PlayerFields.PLAYER_FARSIGHT)
        return current == self.world_object.guid

    def pop_player(self, player_mgr):
        if player_mgr.guid in self.players:
            current = player_mgr.get_uint64(PlayerFields.PLAYER_FARSIGHT)
            if current == self.world_object.guid:
                player_mgr.set_far_sight(0)
            del self.players[player_mgr.guid]

    def flush(self):
        for player_mgr in list(self.players.values()):
            self.pop_player(player_mgr)
            player_mgr.update_known_objects_on_tick = True
            spell = player_mgr.spell_manager.get_casting_spell()
            if spell and spell.is_far_sight() and spell.is_channeled():
                player_mgr.spell_manager.interrupt_casting_spell()
