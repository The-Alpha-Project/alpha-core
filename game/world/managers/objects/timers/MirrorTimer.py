from struct import pack
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import MirrorTimerTypes
from utils.constants.OpCodes import OpCode


class MirrorTimer(object):
    # Player, timer type, server side interval, timer duration (seconds), scale (change per elapsed second), spell_id)
    def __init__(self, owner, timer_type, interval, duration, scale=-1, spell_id=0):
        self.owner = owner
        self.type = timer_type
        self.interval = interval  # Seconds, How often we check this timer.
        self.duration = duration  # In seconds, sent in milliseconds.
        self.scale = scale  # Time added / subtracted per elapsed second in seconds, e.g. -1
        self.spell_id = spell_id
        self.active = False
        self.remaining = self.duration  # In seconds, sent in milliseconds.
        self.chunk_elapsed = 0  # Seconds, compared versus interval.
        self.stop_on_next_tick = False
        self.has_water_breathing = False

    def start(self, elapsed, spell_id=0):
        if not self.active and self.owner.is_alive:
            self.spell_id = spell_id
            self.remaining = self.duration
            self.chunk_elapsed = int(elapsed)
            self.active = True
            self.stop_on_next_tick = False
            self.send_full_update()

    def resume(self):
        if not self.active and self.owner.is_alive:
            self.active = True
            self._send_pause_mirror_timer_packet(1)

    def pause(self):
        if self.active:
            self.active = False
            self._send_pause_mirror_timer_packet(0)

    def _send_pause_mirror_timer_packet(self, state):
        self.stop_on_next_tick = False
        data = pack('<IB', self._get_type(), state)
        packet = PacketWriter.get_packet(OpCode.SMSG_PAUSE_MIRROR_TIMER, data)
        self.owner.enqueue_packet(packet)

    def stop(self):
        if not self.active:
            return
        self.active = False
        self.stop_on_next_tick = False
        data = pack('<I', self._get_type())
        packet = PacketWriter.get_packet(OpCode.SMSG_STOP_MIRROR_TIMER, data)
        self.owner.enqueue_packet(packet)

    # There are only two available 'types' (Timer colors): Dark Yellow (0) or Blue (1).
    # We use Dark Yellow (Fatigue) for Feign Death since the actual value for Feign Death (2) will trigger
    # LUA errors.
    def _get_type(self):
        if self.type == MirrorTimerTypes.FEIGNDEATH:
            return MirrorTimerTypes.FATIGUE.value
        return self.type.value

    def update_water_breathing(self, state):
        self.has_water_breathing = state
        self.send_full_update()

    def send_full_update(self):
        if not self.active:
            return
        scale = self.scale if not self.has_water_breathing else 0
        data = pack('<3IiBI', self._get_type(), self.remaining * 1000, self.duration * 1000, scale, not self.active, self.spell_id)
        packet = PacketWriter.get_packet(OpCode.SMSG_START_MIRROR_TIMER, data)
        self.owner.enqueue_packet(packet)

    def set_scale(self, scale):
        if scale == self.scale:
            return
        self.scale = scale
        self.send_full_update()  # Scale changed, notify the client.

    def set_remaining(self, elapsed):
        if self.scale < 0:
            if self.has_water_breathing and self.remaining == self.duration:
                self.remaining = max(0, int(self.duration - 1))
                return
            self.remaining = max(0, self.remaining - int(elapsed))
        else:
            self.remaining = min(self.duration, self.remaining + int(self.scale))

    def update(self, elapsed):
        if not (self.active and self.owner.is_alive):
            return

        self.chunk_elapsed += elapsed

        # Early return if the interval hasn't been reached.
        if self.chunk_elapsed < self.interval:
            return

        # Replenished, stop.
        if self.stop_on_next_tick:
            self.stop()
            return

        self.set_remaining(self.chunk_elapsed)
        self.chunk_elapsed = 0

        if self.type == MirrorTimerTypes.BREATH:
            self.handle_damage_timer(0.10)
        elif self.type == MirrorTimerTypes.FATIGUE:
            self.handle_damage_timer(0.20)
        else:
            self.handle_feign_death_timer()

    # TODO: should we halt regeneration when drowning or fatigue?
    #  Find drowning damage formula.
    def handle_damage_timer(self, dmg_multiplier):
        if self.remaining == self.duration:
            # Replenished, stop next tick since scale is greater than 1 and client needs to fill its timer bar.
            self.stop_on_next_tick = True
            return

        if not (self.remaining == 0 and self.owner.health > 0):
            return

        damage = int(self.owner.max_health * dmg_multiplier)
        self.send_mirror_timer_damage(damage)

        if self.owner.health <= damage:
            self.owner.die()
        else:
            self.owner.set_health(self.owner.health - damage)

    # Will display damage on player portrait and combat log.
    def send_mirror_timer_damage(self, damage):
        data = pack('<Q2I', self.owner.guid, self.type, damage)
        packet = PacketWriter.get_packet(OpCode.SMSG_MIRRORTIMERDAMAGELOG, data)
        self.owner.enqueue_packet(packet)

    def handle_feign_death_timer(self):
        if self.remaining <= 0:
            self.stop()
            self.owner.die()
