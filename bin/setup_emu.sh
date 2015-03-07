if [-x out/host/linux-x86]; then
	echo "Find out/host/linux-x86."
else
	echo "Cannot find out/host/linux-x86."
fi

case "$1" in
armemu)
	echo Please run this script from the root of AOSP. Setup armemu ...
	cd out/host/linux-x86
	pwd
	ln -s ../../../../adt-bundle-linux-x86_64-20140702/sdk/platforms/ .
	mkdir -p system-images/android-19
	cd system-images/android-19
	ln -s ../../../../target/product/$1/ armeabi-v7a
	cd armeabi-v7a
	ln -s ./kernel kernel-qemu
	cd ../../..
	
    ;;
aosp_arm-eng)
	echo Please run this script from the root of AOSP. Setup aosp_arm-eng ...
	cd out/host/linux-x86
	ln -s ../../../../adt-bundle-linux-x86_64-20140702/sdk/platforms/ .
	mkdir -p system-images/android-19
	cd system-images/android-19
	ln -s ../../../../target/product/generic/ armeabi-v7a
	cd ../../..
    ;;
*)
	echo Un-supported configuration
    ;;
esac

