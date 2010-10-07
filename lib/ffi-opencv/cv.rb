module CV
  extend FFI::Library
  # IPL DEPTH
  IPL_DEPTH_32F = 32
  IPL_DEPTH_8U = 8
  IPL_DEPTH_1U = 1
  IPL_DEPTH_16U = 16

  CV_BGR2GRAY = 6

  class CvSize < FFI::Struct
    layout :width, :int,
      :height, :int
  end

  class CvRect < FFI::Struct
    layout :x, :int,
      :y, :int,
      :width, :int,
      :height, :int
  end
  
  class CvScalar < FFI::Struct
    layout :val, [:double,4]
  end

  class IplImage < FFI::Struct # see include/opencv/cxcore.h
    layout :nSize, :int,
      :ID, :int,
      :nChannels, :int,
      :alphaChannel, :int,
      :depth, :int,
      :colorModel, [:char, 4],
      :channelSeq, [:char, 4],
      :dataOrder, :int,
      :origin, :int,
      :align, :int,
      :width, :int,
      :height, :int,
      :roi, :pointer,
      :maskROI, :pointer,
      :imageId, :pointer,
      :tileInfo, :pointer,
      :imageSize, :int,
      :imageData, :string,
      :widthStep, :int,
      :BorderMode, [:int, 4],
      :BorderConst, [:int, 4],
      :imageDataOrigin, :string
  end
  attach_function :cvEqualizeHist, [:pointer,:pointer], :void
  attach_function :cvCvtColor, [:pointer,:pointer,:int], :void
  attach_function :cvCopy,[:pointer,:pointer,:pointer],:void 
  attach_function :cvCloneImage,[:pointer], :pointer # IplImage* 
  attach_function :cvSmooth, [:pointer, :pointer, :int, :int, :int, :double, :double ], :void
  attach_function :cvCreateImage, [CvSize.by_value,:int,:int],:pointer
  attach_function :cvGetSize, [:pointer], CvSize.by_value
  attach_function :cvSetImageROI, [:pointer, CvRect.by_value ], :void
  attach_function :cvResetImageROI, [:pointer], :void
  attach_function :cvAddS, [:pointer, CvScalar.by_value, :pointer, :pointer], :void
  attach_function :cvAdd, [:pointer, :pointer, :pointer,:pointer], :void 
  attach_function :cvSetZero, [:pointer], :void
  attach_function :cvAcc, [:pointer,:pointer,:pointer], :void
  attach_function :cvConvertScale, [:pointer,:pointer,:double,:double], :void
  attach_function :cvSub, [:pointer,:pointer,:pointer,:pointer], :void
  attach_function :cvPow, [:pointer, :pointer, :double], :void
  attach_function :cvInRange, [:pointer, :pointer, :pointer, :pointer] , :void
  attach_function :cvRunningAvg, [:pointer, :pointer, :double, :pointer], :void 
  attach_function :cvNot, [:pointer, :pointer], :void
  attach_function :cvErode, [:pointer, :pointer, :pointer, :int], :void
  attach_function :cvDilate, [:pointer, :pointer, :pointer, :int], :void
  attach_function :cvMerge, [:pointer,:pointer,:pointer,:pointer,:pointer], :void
  attach_function :cvCanny, [:pointer, :pointer, :double, :double, :int], :void

  def cvScalar(val0, val1=0.0,val2=0.0,val3=0.0)
    scl = CvScalar.new
    scl[:val][0] = val0
    scl[:val][1] = val1
    scl[:val][2] = val2
    scl[:val][3] = val3
    scl
  end

  def cvSubS(src,value,dst,mask=nil)
    cvAddS(src, cvScalar( -value[:val][0], - value[:val][1], - value[:val][2], - value[:val][3]),
           dst,mask)
  end

  def cvScalarAll(val)
    scl = CvScalar.new
    scl[:val][0] = val
    scl[:val][1] = val
    scl[:val][2] = val
    scl[:val][3] = val
    scl
  end

  def cvConvert(src,dst)
    cvConvertScale(src,dst,1.0,0.0)
  end

  def cvRect(x, y, width, height)
    rect = CvRect.new( FFI::MemoryPointer.new(:char, CvRect.size))
    rect[:x] = x
    rect[:y] = y
    rect[:width] = width
    rect[:height] = height
    rect
  end

  def cvSize(width,height)
    size = CvSize.new
    size[:width] = width
    size[:height] = height
    size
  end
  module_function :cvSubS,:cvScalarAll,:cvConvert,
    :cvRect, :cvSize, :cvScalar



end
