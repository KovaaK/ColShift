### [ Download Latest Version. (right click, save link as )](https://github.com/KovaaK/ColShift/raw/master/ColShift.fx)
# Colorblind Assistance Shader

This repo contains a shader for ReShade that replaces pixels in a range of colors close to reds with either yellows or greens.  It is intended for use by colorblind individuals (especially protans) who have trouble seeing red colors that are used in games to highlight important things such as flashing red low health meters, red text, enemy outlines, enemy attack tracers, or circles indicating an incoming AOE attack.

Note that anti-cheat methods in some games have been known to block ReShade from working.  Overwatch, in particular, intentionally crashes the game when ReShade attempts to inject.  Still, it can be useful for games such as the FarCry series, Paladins, Quake Champions, Guild Wars 2, and more.

# Installation

1. Download and run [ReShade](https://reshade.me).
2. Click "Select game".
3. Find the install folder of the game you want to install it to, and double click on the exe that would run the game.
4. Select the correct rendering API (these days, Direct3D 10+ is most common, but you might need to Google it for your game to verify).
5. When it asks if you wish to download standard effects say Yes. (One of the files it downloads is required, so don't click No here)
6. Uncheck all of the effects and click OK. (or leave the other effects checked that you might want to use)
7. Close the installer.
8. Download [ColShift.fx](https://github.com/KovaaK/ColShift/raw/master/ColShift.fx) and copy it to <Game's exe folder>\reshade-shaders\Shaders\
9. Run the game.  When it starts up, the top of your screen should show that ReShade is running, and you can press a hotkey to start the tutorial (Home currently, Shift+F2 for old versions).
10. Then you add a preset, name it whatever you want, and click on the checkbox next to "ColShift" in the list.

# Notes

The default variables should be a good starting point, but if you want to tweak it, here are a few things to be aware of:

- The color replacement happens when the amount of red in a pixel is *greater than* the red cutoff, and the amount of green is *less than* green cutoff, and the amount of blue is *less than* the blue cutoff.
- When the above conditions are met, it either _swaps_ the value of the red and green for that pixel (red becomes green), or it sets the green value of that pixel to the same as the red (red becomes yellow).
- The Soft Cutoff variables are for linearly interpolating the colors between unmodified and modified.  I added this feature because I found some situations where the color shifting/shading resulted in sharp edges of greens turning into reds.  To use them, make sure the Soft Cutoff for Red is less than the Hard Cutoff for Red, and the opposite for green - Soft Cutoff for Green is greater than the Hard Cutoff for Green.
- If you don't want to use the Soft Cutoff variables, just make them match the Hard Cutoff of the same color.

-KovaaK