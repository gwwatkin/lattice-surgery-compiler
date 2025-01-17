import patches
from qubit_state import ActivityType

styles_map = {patches.PatchType.Qubit : "darkkhaki",
              patches.PatchType.DistillationQubit : "orchid",
              patches.PatchType.Ancilla : "aquamarine",
              patches.Orientation.Top : "top",
              patches.Orientation.Bottom : "bottom",
              patches.Orientation.Left : "left",
              patches.Orientation.Right : "right",
              patches.EdgeType.Solid : "solid",
              patches.EdgeType.SolidStiched : "solid",
              patches.EdgeType.Dashed : "dotted",
              patches.EdgeType.DashedStiched : "dotted",
              patches.EdgeType.AncillaJoin : "solid",
              'edge_color': {
                   patches.EdgeType.Solid : "black",
                   patches.EdgeType.SolidStiched : "#37beff",
                   patches.EdgeType.Dashed : "black",
                   patches.EdgeType.DashedStiched : "#37beff",
                   patches.EdgeType.AncillaJoin : "aquamarine",
              },
              'activity_color':
                  {
                      ActivityType.Unitary : "#00baff",
                      ActivityType.Measurement : "#ff0000",
                  }
}