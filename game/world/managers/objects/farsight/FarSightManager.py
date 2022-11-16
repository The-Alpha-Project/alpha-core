from game.world.managers.objects.farsight.Camera import Camera

CAMERAS_BY_SOURCE_OBJECT = dict()
CAMERAS_BY_CELL = dict()


class FarSightManager:

    @staticmethod
    def add_camera(world_object, player_mgr):
        if world_object.guid not in CAMERAS_BY_SOURCE_OBJECT:
            CAMERAS_BY_SOURCE_OBJECT[world_object.guid] = Camera(world_object)
        if world_object.current_cell not in CAMERAS_BY_CELL:
            CAMERAS_BY_CELL[world_object.current_cell] = set()

        CAMERAS_BY_CELL[world_object.current_cell].add(CAMERAS_BY_SOURCE_OBJECT[world_object.guid])
        CAMERAS_BY_SOURCE_OBJECT[world_object.guid].push_player(player_mgr)

    @staticmethod
    def remove_camera(world_object):
        if world_object.guid in CAMERAS_BY_SOURCE_OBJECT:
            CAMERAS_BY_SOURCE_OBJECT[world_object.guid].flush()
            if world_object.current_cell in CAMERAS_BY_CELL:
                CAMERAS_BY_CELL[world_object.current_cell].remove(CAMERAS_BY_SOURCE_OBJECT[world_object.guid])
                if len(CAMERAS_BY_CELL[world_object.current_cell]) == 0:
                    del CAMERAS_BY_CELL[world_object.current_cell]
            del CAMERAS_BY_SOURCE_OBJECT[world_object.guid]

    @staticmethod
    def object_is_camera_view_point(world_object):
        return world_object.guid in CAMERAS_BY_SOURCE_OBJECT

    @staticmethod
    def get_camera_for_player(player_mgr):
        for camera in list(CAMERAS_BY_SOURCE_OBJECT.values()):
            if camera.has_player(player_mgr):
                return camera
        return None

    @staticmethod
    def has_camera_in_cell(cell):
        return cell.key in CAMERAS_BY_CELL

    @staticmethod
    def get_cell_cameras(cell):
        if cell.key in CAMERAS_BY_CELL:
            return [camera for camera in CAMERAS_BY_CELL[cell.key]]
        return []

    @staticmethod
    def broadcast_packet(cameras, packet, exclude=None):
        for camera in cameras:
            camera.broadcast_packet(packet, exclude=exclude)

