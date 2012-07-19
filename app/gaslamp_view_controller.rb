class GaslampViewController < UIViewController
  def viewDidLoad

    @device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

    flashInput = AVCaptureDeviceInput.deviceInputWithDevice(@device, error: nil)
    output = AVCaptureVideoDataOutput.alloc.init

    session = AVCaptureSession.alloc.init
    session.beginConfiguration
    session.addInput(flashInput)
    session.addOutput(output)
    session.commitConfiguration
    session.startRunning

    # set background image
    bg_image = UIImage.imageNamed "background.png"
    bg_image_view = UIImageView.alloc.initWithFrame(self.view.bounds)
    bg_image_view.image = bg_image
    view.addSubview(bg_image_view)

    # set us up the button
    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.setImage(UIImage.imageNamed("button.png"), forState:UIControlStateHighlighted)
    button.frame = [[75, 210],  [170, 170]]
    button.addTarget(self, action: :buttonIsTapped, forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(button)
    

  end

  def buttonIsTapped

    # toggle the light
    if @device.hasTorch && @device.hasFlash
      if @device.torchMode == AVCaptureTorchModeOff
        @device.lockForConfiguration(nil)
        @device.setTorchMode(AVCaptureTorchModeOn)
        @device.setFlashMode(AVCaptureFlashModeOn)
        @device.unlockForConfiguration
      else
        @device.lockForConfiguration(nil)
        @device.setTorchMode(AVCaptureTorchModeOff)
        @device.setFlashMode(AVCaptureFlashModeOn)
        @device.unlockForConfiguration
       end 
    end
    
    #play the sound
    Dispatch::Queue.concurrent.async do
      fart_sound = ["grim_fart", "little_parp", "fart_montage"].sample
      mainBundle = NSBundle.mainBundle
      filePath = mainBundle.pathForResource(fart_sound, ofType:"mp3")
      fileData = NSData.dataWithContentsOfFile(filePath)
      error = Pointer.new(:object)

      @audio_player = AVAudioPlayer.alloc.initWithData(fileData, error:error)

      unless @audio_player.nil?
        @audio_player.delegate = self
        @audio_player.prepareToPlay
        @audio_player.play
      end

    end
  end
end