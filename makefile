INSTALL_PATH	= $(CURDIR)/install
NTRDMA_PATH	= $(CURDIR)/ntrdma
NTRDMA_LIB_PATH	= $(CURDIR)/ntrdma-lib

LX_OPTS	= INSTALL_MOD_PATH=$(INSTALL_PATH)
AM_OPTS	= DESTDIR=$(INSTALL_PATH)

LX_VERS = `cat $(NTRDMA_PATH)/include/config/kernel.release 2> /dev/null`

all: ntrdma ntrdma-lib

ntrdma:
	cp config-ntrdma $(NTRDMA_PATH)/.config
	mkdir -p $(INSTALL_PATH)/{,boot,lib/modules}
	$(MAKE) -C $(NTRDMA_PATH) $(LX_OPTS) olddefconfig
	$(MAKE) -C $(NTRDMA_PATH) $(LX_OPTS)
	$(MAKE) -C $(NTRDMA_PATH) $(LX_OPTS) modules_install
	cp $(NTRDMA_PATH)/arch/x86/boot/bzImage $(INSTALL_PATH)/boot/vmlinuz-$(LX_VERS)
	cp $(NTRDMA_PATH)/System.map $(INSTALL_PATH)/boot/System.map-$(LX_VERS)
	cp $(NTRDMA_PATH)/.config $(INSTALL_PATH)/boot/config-$(LX_VERS)

ntrdma-lib:
	cd $(NTRDMA_LIB_PATH) && libtoolize
	cd $(NTRDMA_LIB_PATH) && aclocal
	cd $(NTRDMA_LIB_PATH) && autoconf
	cd $(NTRDMA_LIB_PATH) && autoheader
	cd $(NTRDMA_LIB_PATH) && automake --add-missing
	cd $(NTRDMA_LIB_PATH) && ./configure --libdir=/usr/lib64 --sysconfdir=/etc
	$(MAKE) -C $(NTRDMA_LIB_PATH) $(AM_OPTS)
	$(MAKE) -C $(NTRDMA_LIB_PATH) $(AM_OPTS) install

deploy:
	deploy.sh 192.168.122.10
	deploy.sh 192.168.122.11

.PHONY: all ntrdma ntrdma-lib deploy