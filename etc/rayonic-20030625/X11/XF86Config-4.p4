Section "ServerLayout"
	Identifier     "XFree86 Configured"
	Screen      0  "Screen0" 0 0
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
	RgbPath      "/usr/X11R6/lib/X11/rgb"
	FontPath     "/usr/X11R6/lib/X11/fonts/misc/"
#	FontPath     "/usr/X11R6/lib/X11/fonts/Speedo/"
#	FontPath     "/usr/X11R6/lib/X11/fonts/Type1/"
	FontPath     "/usr/X11R6/lib/X11/fonts/75dpi/"
#	FontPath     "/usr/X11R6/lib/X11/fonts/100dpi/"
EndSection

Section "Module"
EndSection

Section "InputDevice"
	Identifier  "Keyboard0"
	Driver      "keyboard"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option	    "Protocol" "IMPS/2"
	Option	    "Device" "/dev/misc/psaux"
	Option      "ZAxisMapping" "4 5"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Monitor Vendor"
	ModelName    "Monitor Model"
	HorizSync    28.0 - 78.0
	VertRefresh  50.0 - 76.0
EndSection

Section "Monitor"
	Identifier	"Monitor0"
	VendorName	"Monitor Vendor"
	ModelName	"Monitor Model"
	HorizSync	28.0 - 78.0
	VertRefresh	50.0 - 76.0
	Modeline	"640x480"   25.175 640  664  760  800   480  491  493  525 
	# 640x240 Rand unten
	Modeline	"640x240ru" 25.175 640  664  760  800   240  491  493  525 
	# 640x240 Bild mittig
	Modeline	"640x240"   25.175 640  664  760  800   240  371  373  525 
EndSection

Section "Device"
	Identifier  "Card0"
	Driver      "vesa"
	VendorName  "ATI Technologies Inc"
	BoardName   "Radeon R250 If [Radeon 9000]"
	BusID       "PCI:1:0:0"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "Card0"
	Monitor    "Monitor0"
	SubSection "Display"
		Depth     8
		Modes     "640x480"
	EndSubSection
	
	SubSection "Display"
		Depth     16
		Modes     "640x480"
	EndSubSection
	
	SubSection "Display"
		Depth     24
		Modes     "640x480"
	EndSubSection
EndSection
