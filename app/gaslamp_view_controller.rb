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
    bg_image = UIImage.imageNamed "bkrnd.png"
    bg_image_view = UIImageView.alloc.initWithFrame(self.view.bounds)
    bg_image_view.image = bg_image
    view.addSubview(bg_image_view)

    # set the logo
    logo_image = UIImage.imageNamed "logo.png"
    @logo_view = UIImageView.alloc.initWithFrame [[32.5, 69], [253.5, 81.5]]
    @logo_view.image = logo_image
    view.addSubview(@logo_view)

    #logo_active_image = UIImage.imageNamed "logo-active.png" 
    #logo_active_view = UIImageView.alloc.initWithFrame [[0, 0], [320, 201]]
    #logo_active_view.image = logo_active_image
    #view.addSubview(logo_active_view)

    # set us up the buttons
    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.setImage(UIImage.imageNamed("bttn-reg.png"), forState:UIControlStateNormal)
    button.setImage(UIImage.imageNamed("bttn-active.png"), forState:UIControlStateHighlighted)
    button.frame = [[74, 212],  [170, 169]]
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
        @logo_view.image = UIImage.imageNamed "logo-active.png"
        @logo_view.frame = [[0, 0], [320, 201]]
      else
        @device.lockForConfiguration(nil)
        @device.setTorchMode(AVCaptureTorchModeOff)
        @device.setFlashMode(AVCaptureFlashModeOn)
        @device.unlockForConfiguration
        @logo_view.image = UIImage.imageNamed "logo.png"
        @logo_view.frame = [[32.5, 69], [253.5, 81.5]]
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