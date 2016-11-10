#########
######
###
  Remove All Marker
    (C) あかつきみさき(みくちぃP)

  このスクリプトについて
    選択したレイヤーのマーカーをすべて削除します.

  使用方法
    レイヤーを選択してからスクリプトを実行してください.

  動作環境
    Adobe After Effects CS5以上

  バージョン情報
    2014/09/15 Ver 1.0.0 Release
###
######
#########

RAMData = (->
  scriptName          = "Remove All Marker"
  scriptURLName       = "RemoveAllMarker"
  scriptVersionNumber = "1.0.0"
  scriptURLVersion    = 100
  canRunVersionNum    = 10.0
  canRunVersionC      = "CS5"
  guid                = "{C479125A-708F-4E65-9093-D0251374BD00}"

  getScriptName: ->
    scriptName

  getScriptURLName: ->
    scriptURLName

  getScriptVersionNumber: ->
    scriptVersionNumber

  getScriptURLVersion: ->
    scriptURLVersion

  getCanRunVersionNum: ->
    canRunVersionNum

  getCanRunVersionC: ->
    canRunVersionC

  getGuid: ->
    guid

)()

ADBE_MARKER = "ADBE Marker"

# 選択されたプロパティのキーフレーム時間のインデックスを返す
Property::keyTimes = () ->
  index = []
  for j in [1..@numKeys] by 1
    index.push @keyTime(j)
  return index

# 選択されたプロパティのキーフレーム値のインデックスを返す
Property::keyValues = () ->
  index = []
  for j in [1..@numKeys] by 1
    index.push @keyValue(j)
  return index


isCompActive = (selComp) ->
  unless(selComp and selComp instanceof CompItem)
    alert "Select Composition"
    return false
  else
    return true

isLayerSelected = (selLayers) ->
  if selLayers.length is 0
    alert "Select Layers & Properties"
    return false
  else
    return true

# 許容バージョンを渡し,実行できるか判別
runAEVersionCheck = (AEVersion) ->
  if parseFloat(app.version) < AEVersion.getCanRunVersionNum()
    alert "This script requires After Effects #{AEVersion.getCanRunVersionC()} or greater."
    return false
  else
    return true

getLocalizedText = (str) ->
  (if app.language is Language.JAPANESE then str.jp else str.en)

entryFunc = () ->
  for i in [0...selLayers.length] by 1
    keys = selLayers[i].property(ADBE_MARKER).keyTimes()
    for j in [0...keys.length] by 1
      selLayers[i].property(ADBE_MARKER).removeKey(1)

  return 0

undoEntryFunc = (data) ->
  app.beginUndoGroup data.getScriptName()
  entryFunc()
  app.endUndoGroup()
  return 0


# バージョン判定
return 0  unless runAEVersionCheck(RAMData)

actComp = app.project.activeItem
return 0 unless isCompActive actComp

selLayers = actComp.selectedLayers
return 0 unless isLayerSelected selLayers

undoEntryFunc RAMData
return 0
