module Highgui
  extend FFI::Library
  CV_WINDOW_AUTOSIZE = 1
  
  # capture property
  CV_CAP_PROP_POS_MSEC = 0
  CV_CAP_PROP_POS_FRAMES = 1
  CV_CAP_PROP_FPS = 5
  CV_CAP_PROP_FOURCC = 6
  CV_CAP_PROP_FRAME_COUNT = 7
  CV_CAP_PROP_FORMAT = 8
  CV_CAP_PROP_MODE = 9

  attach_function :cvCreateFileCapture, [:string], :pointer #highgui 
  attach_function :cvCreateCameraCapture,[:int],:pointer  # highgui
  attach_function :cvNamedWindow,[:string, :int], :int # highgui 
  attach_function :cvQueryFrame, [:pointer], CV::IplImage # highgui
  attach_function :cvShowImage, [:string,:pointer], :void # highgui 
  attach_function :cvReleaseCapture,  [:pointer], :void  # highgui
  attach_function :cvReleaseImage, [:pointer], :void # highgui
  attach_function :cvDestroyWindow, [:string], :void  # highgui
  attach_function :cvWaitKey, [:int], :int # highgui
  attach_function :cvSetCaptureProperty, [:pointer,:int,:double] , :int # highgui
  attach_function :cvGetCaptureProperty, [:pointer, :int], :double # highgui
  attach_function :cvStartWindowThread, [], :int # highgui
  attach_function :cvDestroyAllWindows, [], :void # highgui



end
