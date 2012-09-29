$(document).ready ->
  
  # Cache the Window object
  $window = $(window)
  
  # Cache the Y offset and the speed of each sprite
  $("[data-type]").each ->
    $(this).data "offsetY", parseInt($(this).attr("data-offsetY"))
    $(this).data "Xposition", $(this).attr("data-Xposition")
    $(this).data "speed", $(this).attr("data-speed")

  
  # For each element that has a data-type attribute
  $("section[data-type=\"background\"]").each ->
    
    # Store some variables based on where we are
    $self = $(this)
    offsetCoords = $self.offset()
    topOffset = offsetCoords.top
    
    # When the window is scrolled...
    $(window).scroll ->
      
      # If this section is in view
      if ($window.scrollTop() + $window.height()) > (topOffset) and ((topOffset + $self.height()) > $window.scrollTop())
        
        # Scroll the background at var speed
        # the yPos is a negative value because we're scrolling it UP!               
        yPos = -($window.scrollTop() / $self.data("speed"))
        
        # If this element has a Y offset then add it on
        yPos += $self.data("offsetY")  if $self.data("offsetY")
        
        # Put together our final background position
        coords = "50% " + yPos + "px"
        
        # Move the background
        $self.css backgroundPosition: coords
        
        # Check for other sprites in this section 
        $("[data-type=\"sprite\"]", $self).each ->
          
          # Cache the sprite
          $sprite = $(this)
          
          # Use the same calculation to work out how far to scroll the sprite
          yPos = -($window.scrollTop() / $sprite.data("speed"))
          coords = $sprite.data("Xposition") + " " + (yPos + $sprite.data("offsetY")) + "px"
          $sprite.css backgroundPosition: coords

        # sprites
        
        # Check for any Videos that need scrolling
        $("[data-type=\"video\"]", $self).each ->
          
          # Cache the video
          $video = $(this)
          
          # There's some repetition going on here, so 
          # feel free to tidy this section up. 
          yPos = -($window.scrollTop() / $video.data("speed"))
          coords = (yPos + $video.data("offsetY")) + "px"
          $video.css top: coords


