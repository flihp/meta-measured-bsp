FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://${BPN}.service"

inherit systemd

SYSTEMD_SERVICE_${PN} = "${BPN}.service"

FILES_${PN} += " \
    ${libexecdir} \
    ${systemd_unitdir} \
"

do_install_append() {
    install -d ${D}${libexecdir}
    install -m 0755 ${WORKDIR}/${PN}.init.sh ${D}${libexecdir}/${PN}

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/${PN}.service ${D}/${systemd_unitdir}/system/
}

