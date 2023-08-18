import sys
from game.world.managers.abstractions.Vector import Vector


class SqlManager:
    FILE_PATH = "/home/user/Documents/sql/modifications.sql"

    TABLES_FIELDS = {
        "spawns_gameobjects": {
            "guid": "spawn_id",
            "entry": "spawn_entry",
            "map": "spawn_map",
            "x": "spawn_positionX",
            "ignored": "ignored",
            "y": "spawn_positionY",
            "z": "spawn_positionZ",
            "o": "spawn_orientation",
        },
        "spawns_creatures": {
            "guid": "spawn_id",
            "entry": "spawn_entry",
            "map": "map",
            "x": "position_x",
            "ignored": "ignored",
            "y": "position_y",
            "z": "position_z",
            "o": "orientation",
            "movement_type": "movement_type",
        },
        "creature_template": {"guid": "entry", "display_id": "display_id"},
        "gameobject_template": {"guid": "entry", "display_id": "displayId"},
    }

    def __init__(self):
        self.OPERATION_TYPE = {
            "UPDATE": self._operation_update,
            "DELETE": self._operation_delete,
            "CREATE": self._operation_create,
            "CMOV": self._operation_create_movement,
        }

    def _format_update_data_to_sql(self, table, data) -> str:
        try:
            del data["z_locked"]
        except:
            pass

        data_sql = "\n"
        for key, value in data.items():
            data_sql += f"{self.TABLES_FIELDS[table][key]}={value},\n"

        # to pop the last commat
        data_sql = data_sql[0:-2] + "\n"

        return data_sql

    def _format_create_movement_data_to_sql(self, table, guid, x, y, z, o):
        return f"({guid}, X, {x}, {y}, {z}, {o}, 0, 0, 0)"

    def _format_create_data_to_sql(self, table, entry, movement_type, data) -> str:
        print("DATA", data)
        map_ = data.pop("map")

        try:
            del data["z_locked"]
        except:
            pass

        beginning_data_sql = f"(NULL, {entry}, "

        if "creatures" in table:
            beginning_data_sql += f"0, 0, 0, {map_}, "
            end_data_sql = f"300, 300, 3, 100, 0, 1, 0, 0, 0)"
        else:
            beginning_data_sql += f"{map_}, "
            end_data_sql = "0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)"

        for key, value in data.items():
            beginning_data_sql += f"{value}, "

        return beginning_data_sql + end_data_sql

    def _operation_update(self, table, guid, data) -> str:
        guid_field = self.TABLES_FIELDS[table]["guid"]
        data_sql = self._format_update_data_to_sql(table, data)

        return f"-- FIX {table} {guid}\nUPDATE {table} SET {data_sql}WHERE {guid_field}={guid};"

    def _operation_delete(self, table, guid, data) -> str:
        guid_field = self.TABLES_FIELDS[table]["guid"]

        return f"-- IGNORED {table} {guid}\nUPDATE {table} SET ignored=1\nWHERE {guid_field}={guid};"

    def _operation_create(self, table, entry, movement_type, data) -> str:
        return f"-- CREATE {table} {entry}\nINSERT INTO {table} VALUES {self._format_create_data_to_sql(table, entry, movement_type, data)};"

    def _operation_create_movement(self, table, guid, x, y, z, o) -> str:
        return f"-- CREATE WAYPOINT FOR SPAWN {guid} \nINSERT INTO {table} VALUES {self._format_create_movement_data_to_sql(table, guid, x, y, z, o)};"

    def _write_sql_request_to_file(self, sql_request) -> None:
        with open(self.FILE_PATH, "a") as f:
            f.write(sql_request + "\n\n")

    def format_movement_and_write_it(self, guid, x, y, z, o):
        formatted_request = self._operation_create_movement(
            "creature_movement", guid, x, y, z, o
        )
        self._write_sql_request_to_file(formatted_request)

    def format_sql_request_and_write_it(
        self, operation_type, table, guid, data=None, map_=None, movement_type=0
    ) -> None:
        if type(data) == type(Vector()):
            data = vars(data)
        if map_ != None:
            data["map"] = map_

        formatted_request = self.OPERATION_TYPE.get(operation_type)(
            table, guid, movement_type, data
        )
        self._write_sql_request_to_file(formatted_request)


if __name__ == "__main__":
    data = {"x": 766, "y": 8099, "z": 10, "o": 1.4}
    guid = 879879
    sql_mgr = SqlManager()
    sql_mgr.format_sql_request_and_write_it("DELETE", "spawns_creatures", guid, data)
