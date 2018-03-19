# NavigateMe
Native iOS project for Masters program in HS Fulda University of Applied Sciences.

# Description
Using this application, students can easily find which rooms are lecture free in a specific floor of a building. It also shows navigation to that room.

# How to run in Xcode:
1. This project has 4 dependencies. All are exist within NavigateMe/Pods directory.

2. If anyone wants to update these, please remove NavigateMe/Pods directory and Podfile.lock

3. Then please enter inside the directory NavigateMe/ using "cd" where Podfile exists.

        cd NavigateMe/

4. After that, please run command "pod install"

        If CocoaPods is not install in machine then please install it using "sudo gem install cocoapods" command.

5. The above command will install all dependencies mentioned in the Podfile.

6. After successful dependecies installation, please run NavigateMe.xcworkspace instead of NavigateMe.xcodeproj

7. Finally, please check followings:

        please click "Project Navigator" tab in left pannel, then
                NavigateMe(Top in 1st Tree) Targets -> NavigateMe -> Build Settings -> Enable Bitcode -> Yes
                Pods(Top in 2nd Tree) -> Targets -> TesseractOCRiOS -> Build Settings -> Enable Bitcode -> Yes

   If "Enable Bitcode" is set to "No", then please change the value to "Yes".     
