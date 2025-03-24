#!/bin/bash

# Limpiar directorios existentes
rm -rf .repo/local_manifests/
rm -rf hardware/qcom-caf/common

# Inicializar el repositorio
echo "================="
echo "Inicializando repo..."
echo "================="
repo init -u https://github.com/Project-Mist-OS/manifest -b qpr3 --git-lfs
echo "================="
echo "Repo init success"
echo "================="
echo ""

# Clonar el repositorio local_manifests
echo "============================"
echo "Clonando local_manifests..."
echo "============================"
git clone https://github.com/Angelpro09xd/local_manifests_sapphire.git --depth 1 -b sapphire .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"
echo ""

# Sincronizar los repositorios
echo "============================"
echo "Sincronizando repositorios..."
echo "============================"
echo ""
/opt/crave/resync.sh
echo "============================"
echo "Repositorios sincronizados"
echo "============================"
echo ""

# Clonar los H.A.L.s (Hardware Abstraction Layers) para sm6225
echo "============================"
echo "Clonando HALs para sm6225..."
echo "============================"

rm -rf hardware/qcom-caf/common
git clone --depth 1 -b lineage-22.1 https://github.com/sapphire-sm6225/android_hardware_qcom-caf_common.git hardware/qcom-caf/common

rm -rf hardware/qcom-caf/sm6225/audio/agm
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/vendor_qcom_opensource_agm.git hardware/qcom-caf/sm6225/audio/agm

rm -rf hardware/qcom-caf/sm6225/audio/pal
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/vendor_qcom_opensource_arpal-lx.git hardware/qcom-caf/sm6225/audio/pal

rm -rf hardware/qcom-caf/sm6225/data-ipa-cfg-mgr
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/vendor_qcom_opensource_data-ipa-cfg-mgr.git hardware/qcom-caf/sm6225/data-ipa-cfg-mgr

rm -rf hardware/qcom-caf/sm6225/dataipa
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/vendor_qcom_opensource_dataipa.git hardware/qcom-caf/sm6225/dataipa

rm -rf hardware/qcom-caf/sm6225/display
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/hardware_qcom_display.git hardware/qcom-caf/sm6225/display

rm -rf hardware/qcom-caf/sm6225/media
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/hardware_qcom_media.git hardware/qcom-caf/sm6225/media

rm -rf hardware/qcom-caf/sm6225/audio/primary-hal
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/hardware_qcom_audio.git hardware/qcom-caf/sm6225/audio/primary-hal

rm -rf device/qcom/sepolicy_vndr/sm6225
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/device_qcom_sepolicy_vndr.git device/qcom/sepolicy_vndr/sm6225

echo "============================"
echo "Clone HALs para sm6225 success"
echo "============================"
echo ""

# Iniciar la construcción del sistema
echo "============================"
echo "Iniciando la construcción del sistema..."
echo "============================"

source build/envsetup.sh
export BUILD_USERNAME="@Angelpro09_Dev"
export BUILD_HOSTNAME="T800-machine"
export ALLOW_MISSING_DEPENDENCIES=true

lunch aosp_sapphire-ap4a-user
mka bacon

echo "============================"
echo "Build completado con éxito"
echo "============================"
