SUMMARY = ""
DESCRIPTION = ""
SECTION = "tpm"
PR = "r0"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${WORKDIR}/COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI += " \
    file://COPYING \
    file://${BPN}.init.sh \
    file://${BPN}.service \
"

inherit systemd

SYSTEMD_SERVICE_${PN} = "${BPN}.service"

FILES_${PN} += " \
    ${libexecdir} \
    ${systemd_unitdir} \
"

do_install_append() {
    install -d ${D}${libexecdir}
    install -m 0755 ${WORKDIR}/${BPN}.init.sh ${D}${libexecdir}/${BPN}

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/${BPN}.service ${D}/${systemd_unitdir}/system/
}

