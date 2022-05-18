echo "Printing dmidecode output.........:\n"
sudo dmidecode --type memory journalctl | egrep -ie "Error Correction Type|Total Width|Data Width|Size:"

echo "Printing error correction type.........:\n"
cat /sys/devices/system/edac/mc/mc0/rank?/dimm_edac_mode
echo "Printing corrected errors.........:\n"
cat /sys/devices/system/edac/mc/mc0/rank*/dimm_ce_count
echo "Printing uncorrected errors.........:\n"
cat /sys/devices/system/edac/mc/mc0/rank*/dimm_ue_count

sudo apt install edac-utils
echo "Printing edac-utils output.........:\n"
sudo edac-utils -vs

echo "Printing hardware failures.........:\n"
journalctl -rt kernel | grep -F '[Hardware Error]'
echo "Printing memory failures.........:\n"
journalctl -rt kernel | grep -F 'Memory failure'

echo "Printing rasdaemon output.........:\n"
ras-mc-ctl --error-count
