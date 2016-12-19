/// <reference path="C:/Users/RUI/OneDrive/lib/aftereffects.d.ts/ae.d.ts"/>
(function () {
    var ADBE_MARKER = "ADBE Marker";
    var isCompActive = function (comp) {
        if (!(comp && comp instanceof CompItem)) {
            return false;
        }
        else {
            return true;
        }
    };
    var isLayerSelected = function (layers) {
        if (layers.length === 0) {
            return false;
        }
        else {
            return true;
        }
    };
    var actComp = app.project.activeItem;
    if (!isCompActive(actComp)) {
        return 0;
    }
    app.beginUndoGroup("Count Comment Marker");
    var keyNum = 0;
    var markerObj;
    var actMarkerTime = 0;
    var selLayers = actComp.selectedLayers;
    if (!isLayerSelected(selLayers)) {
        if (parseFloat(app.version) < 14 /* CC2017 */) {
            return 0;
        }
        keyNum = actComp.markerProperty.numKeys;
        for (var i = 1; i <= keyNum; i++) {
            actComp.markerProperty.removeKey(1);
        }
        return 0;
    }
    for (var i = 0; i < selLayers.length; i++) {
        keyNum = selLayers[i].property(ADBE_MARKER).numKeys;
        for (var j = 1; j <= keyNum; j++) {
            selLayers[i].property(ADBE_MARKER).removeKey(1);
        }
    }
    app.endUndoGroup();
}).call(this);
