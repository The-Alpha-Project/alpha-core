from struct import pack
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import MirrorTimerTypes
from utils.constants.OpCodes import OpCode


class MirrorTimer(object):
    # Player guid, timer type, server side check interval, timer duration (seconds), scale (change per elapsed second), spell_id)
    def __init__(self, owner, type, interval, duration, scale, spell_id):
        self.owner = owner
        self.type = type
        self.interval = interval  # How often we check this timer.
        self.duration = duration  # In seconds, sent in milliseconds.
        self.scale = scale  # Time added/subtracted per elapsed second in seconds, for e.g. -1
        self.spell_id = spell_id
        self.active = False
        self.remaining = self.duration  # In seconds, sent in milliseconds.
        self.chunk_elapsed = 0  # Milliseconds

    def start(self, elapsed):
        if not self.active and self.owner.is_alive:
            self.remaining = self.duration
            self.chunk_elapsed = int(elapsed)
            self.active = True
            self.send_full_update()

    def resume(self):
        if not self.active and self.owner.is_alive:
            self.active = True
            data = pack('<IB', self.type, not self.active)
            packet = PacketWriter.get_packet(OpCode.SMSG_PAUSE_MIRROR_TIMER, data)
            self.owner.session.enqueue_packet(packet)

    def pause(self):
        if self.active:
            self.active = False
            data = pack('<IB', self.type, not self.active)
            packet = PacketWriter.get_packet(OpCode.SMSG_PAUSE_MIRROR_TIMER, data)
            self.owner.session.enqueue_packet(packet)

    def stop(self):
        if self.active:
            self.active = False
            data = pack('<I', self.type)
            packet = PacketWriter.get_packet(OpCode.SMSG_STOP_MIRROR_TIMER, data)
            self.owner.session.enqueue_packet(packet)

    def send_full_update(self):
        if self.active:
            data = pack('<3IiBI', self.type, self.remaining * 1000, self.duration * 1000, self.scale, not self.active, self.spell_id)
            packet = PacketWriter.get_packet(OpCode.SMSG_START_MIRROR_TIMER, data)
            self.owner.session.enqueue_packet(packet)

    def set_scale(self, scale):
        if scale != self.scale:
            self.scale = scale
            self.send_full_update()  # Scale changed, notify the client.

    def set_remaining(self, elapsed):
        if self.scale < 0:
            if self.remaining - elapsed <= 0:
                self.remaining = 0
            else:
                self.remaining -= int(elapsed)
        else:
            if self.remaining + self.scale >= self.duration:
                self.remaining = self.duration
            else:
                self.remaining += int(self.scale)

    def update(self, elapsed):
        if self.active and self.owner.is_alive:
            self.chunk_elapsed += elapsed
            if self.chunk_elapsed >= self.interval:
                self.set_remaining(self.chunk_elapsed)
                self.chunk_elapsed = 0

                if self.type == MirrorTimerTypes.BREATH:
                    self.handle_breathing(0.10)  # Damage: 10% of players max health.
                elif self.type == MirrorTimerTypes.FEIGNDEATH:
                    self.handle_feign_death()
                elif self.type == MirrorTimerTypes.FATIGUE:
                    self.handle_fatigue()
                else:
                    self.handle_environmental()

    # TODO, should we halt regeneration when drowning?
    #  CombatLog should display drown and fatigue.
    def handle_breathing(self, dmg_multiplier):
        if self.remaining == self.duration:
            self.stop()  # Replenished
        elif self.remaining == 0 and self.owner.health > 0:
            # TODO: Find drowning damage formula.
            damage = int(self.owner.max_health * dmg_multiplier)
            if self.owner.health - damage <= 0:
                self.owner.die()
            else:
                new_health = self.owner.health - damage
                self.owner.set_health(new_health)
                self.owner.set_dirty()

    def handle_fatigue(self):
        # Handle the same as breathing for now with different damage multiplier.
        self.handle_breathing(0.20)  # Damage: 20% of players max health.

    def handle_feign_death(self):
        pass

    def handle_environmental(self):
        pass
