from struct import pack
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class MirrorTimer(object):
    def __init__(self, owner, type, interval, duration, scale, spell_id):
        self.owner = owner
        self.type = type
        self.interval = interval
        self.duration = duration
        self.scale = scale
        self.spell_id = spell_id
        self.active = False
        self.remaining = self.duration
        self.chunk_elapsed = 0

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
            data = pack('<3IiBI', self.type, self.remaining, self.duration, self.scale, self.active, self.spell_id)
            packet = PacketWriter.get_packet(OpCode.SMSG_START_MIRROR_TIMER, data)
            self.owner.session.enqueue_packet(packet)

    def set_scale(self, scale):
        if scale != self.scale:
            self.scale = scale

    # TODO: Base timer class, children override update().
    def update(self, elapsed):
        if self.active and self.owner.is_alive:
            self.chunk_elapsed += elapsed
            if self.chunk_elapsed >= self.interval:
                if self.scale < 0:
                    self.remaining -= int(self.chunk_elapsed)
                    if self.remaining <= 0:
                        self.remaining = 0
                        # TODO: Find drowning damage formula.
                        damage = int(self.owner.max_health * 0.10)
                        new_health = self.owner.health - damage
                        self.owner.set_health(new_health)
                        self.owner.set_dirty()
                else:
                    self.remaining += int(self.scale)
                    if self.remaining >= self.duration:
                        self.stop()

                self.chunk_elapsed = 0
                # If timer did not stop in this tick, send update.
                if self.active:
                    self.send_full_update()
