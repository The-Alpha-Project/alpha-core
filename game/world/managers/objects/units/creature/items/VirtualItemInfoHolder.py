from dataclasses import dataclass


@dataclass
class VirtualItemInfoHolder:
    display_id: int = 0
    info_packed: int = 0  # ClassID, SubClassID, Material, InventoryType.
    info_packed_2: int = 0  # Sheath, Padding, Padding, Padding.
