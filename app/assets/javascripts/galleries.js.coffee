jQuery ->
  if($('img.crop')).length
    new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('img').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    console.log(coords)
