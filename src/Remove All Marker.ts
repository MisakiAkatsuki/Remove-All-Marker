/// <reference path="C:/Users/RUI/OneDrive/lib/aftereffects.d.ts/ae.d.ts"/>

(function () {
  const ADBE_MARKER: string = "ADBE Marker";

  const isCompActive = function (comp: CompItem) {
    if (!(comp && comp instanceof CompItem)) {
      return false;
    } else {
      return true;
    }
  }

  const isLayerSelected = function (layers: Layer[]) {
    if (layers.length === 0) {
      return false;
    } else {
      return true;
    }
  }

  const actComp: CompItem = <CompItem>app.project.activeItem;
  if (!isCompActive(actComp)) {
    return 0;
  }

  app.beginUndoGroup("Count Comment Marker");
  let keyNum: number = 0;
  let markerObj: MarkerValue;
  let actMarkerTime: number = 0;

  const selLayers: Layer[] = <Layer[]>actComp.selectedLayers;

  if (!isLayerSelected(selLayers)) {
    keyNum = <number>actComp.markerProperty.numKeys;

    for (let i = 1; i <= keyNum; i++) {
      actComp.markerProperty.removeKey(1);
    }
    return 0;
  }

  for (let i = 0; i < selLayers.length; i++) {
    keyNum = selLayers[i].property(ADBE_MARKER).numKeys;
    for (let j = 1; j <= keyNum; j++) {
      selLayers[i].property(ADBE_MARKER).removeKey(1);
    }
  }

  app.endUndoGroup();
}).call(this);
