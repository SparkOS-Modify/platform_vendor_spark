# Use 'export INPUT_ADBLOCK_FILE=<custom host file location>' before build/envsetup.sh to build custom adblock
INPUT_ADBLOCK_FILE ?= external/hosts/hosts

ADBLOCK_SCRIPT := vendor/spark/adaway/generate.py

TARGET_GENERATED_HOSTS_BLOCKER := $(TARGET_OUT_INTERMEDIATES)/ADBLOCK/hosts.spark_adblock
$(TARGET_GENERATED_HOSTS_BLOCKER): INTERMEDIATES := $(TARGET_OUT_INTERMEDIATES)/ADBLOCK
$(TARGET_GENERATED_HOSTS_BLOCKER): $(ADBLOCK_SCRIPT) $(INPUT_ADBLOCK_FILE)
	python3 $(ADBLOCK_SCRIPT) $@ $(INPUT_ADBLOCK_FILE)

include $(CLEAR_VARS)
LOCAL_MODULE := hosts.spark_adblock
LOCAL_MODULE_CLASS := ETC

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(TARGET_GENERATED_HOSTS_BLOCKER)
	@cp $< $@
