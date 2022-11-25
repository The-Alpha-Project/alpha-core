from multiprocessing import RLock

from game.world.managers.objects.farsight.Camera import Camera

CAMERAS_BY_SOURCE_OBJECT = dict()
CAMERAS_BY_CELL = dict()


class FarSightManager:
    LOCK = RLock()

    @staticmethod
    def add_camera(world_object, player_mgr):
        camera = FarSightManager._get_camera_by_object(world_object)

        if not camera:
            camera = Camera(world_object)

        camera.push_player(player_mgr)
        FarSightManager._add_or_update_camera_by_source(world_object, camera)
        FarSightManager._add_or_update_camera_by_cell(world_object.current_cell, camera)
        player_mgr.set_far_sight(world_object.guid)

    @staticmethod
    def remove_camera(world_object):
        FarSightManager._remove_cell_camera(world_object)
        FarSightManager._remove_source_camera(world_object)

    @staticmethod
    def object_is_camera_view_point(world_object):
        with FarSightManager.LOCK:
            return world_object.guid in CAMERAS_BY_SOURCE_OBJECT

    @staticmethod
    def get_camera_by_object(world_object):
        return FarSightManager._get_camera_by_object(world_object)

    @staticmethod
    def update_camera_cell_placement(world_object, cell):
        with FarSightManager.LOCK:
            camera = FarSightManager._get_camera_by_object(world_object)
            # If the camera changed cells, update its placement.
            if camera and camera.cell_key != cell.key:
                # Remove existent camera from cell.
                if camera.cell_key in CAMERAS_BY_CELL:
                    CAMERAS_BY_CELL[camera.cell_key].remove(camera)
                    # Cell has no more cameras, remove cell entry.
                    if len(CAMERAS_BY_CELL[camera.cell_key]) == 0:
                        del CAMERAS_BY_CELL[camera.cell_key]
                # Create the new cell if needed.
                if cell.key not in CAMERAS_BY_CELL:
                    CAMERAS_BY_CELL[cell.key] = set()
                # Set the camera in the new cell.
                CAMERAS_BY_CELL[cell.key].add(camera)
                camera.cell_key = cell.key

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

    @staticmethod
    def _get_camera_by_object(world_object):
        with FarSightManager.LOCK:
            return CAMERAS_BY_SOURCE_OBJECT.get(world_object.guid)

    @staticmethod
    def _remove_cell_camera(world_object):
        with FarSightManager.LOCK:
            camera = FarSightManager._get_camera_by_object(world_object)
            if camera and world_object.current_cell in CAMERAS_BY_CELL:
                CAMERAS_BY_CELL[world_object.current_cell].remove(camera)
                # If this cell no longer contains more cameras, destroy.
                if len(CAMERAS_BY_CELL[world_object.current_cell]) == 0:
                    del CAMERAS_BY_CELL[world_object.current_cell]

    @staticmethod
    def _remove_source_camera(world_object):
        with FarSightManager.LOCK:
            camera = FarSightManager._get_camera_by_object(world_object)
            if camera and world_object.guid in CAMERAS_BY_SOURCE_OBJECT:
                del CAMERAS_BY_SOURCE_OBJECT[world_object.guid]
                camera.flush()

    @staticmethod
    def _add_or_update_camera_by_cell(cell_key, camera):
        with FarSightManager.LOCK:
            if cell_key not in CAMERAS_BY_CELL:
                CAMERAS_BY_CELL[cell_key] = set()
            CAMERAS_BY_CELL[cell_key].add(camera)

    @staticmethod
    def _add_or_update_camera_by_source(world_object, camera):
        CAMERAS_BY_SOURCE_OBJECT[world_object.guid] = camera
