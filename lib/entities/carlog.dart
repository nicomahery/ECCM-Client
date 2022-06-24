import 'package:intl/intl.dart';

import '../utils/static_const_values.dart';

class CarLog {
  DateTime deviceTime;
  String? carId;
  String? tripId;
  double? gpsLatitude;
  double? gpsLongitude;
  double? gpsAltitude;
  double? gpsSpeed;
  double? gpsTrack;
  double? engineLoad;
  double? coolantTemp;
  double? shortFuelTrim1;
  double? longFuelTrim1;
  double? shortFuelTrim2;
  double? longFuelTrim2;
  double? fuelPressure;
  double? intakePressure;
  double? rpm;
  double? speed;
  double? timingAdvance;
  double? intakeTemp;
  double? maf;
  double? throttlePos;
  String? airStatus;
  String? O2Sensors;
  double? O2B1S1;
  double? O2B1S2;
  double? O2B1S3;
  double? O2B1S4;
  double? O2B2S1;
  double? O2B2S2;
  double? O2B2S3;
  double? O2B2S4;
  String? obdCompliance;
  String? O2SensorsAlt;
  String? auxInputStatus;
  double? runTime;
  double? distanceWMIL;
  double? fuelRailPressureVAC;
  double? fuelRailPressureDirect;
  double? O2S1WRVoltage;
  double? O2S2WRVoltage;
  double? O2S3WRVoltage;
  double? O2S4WRVoltage;
  double? O2S5WRVoltage;
  double? O2S6WRVoltage;
  double? O2S7WRVoltage;
  double? O2S8WRVoltage;
  double? commandedEGR;
  double? EGRError;
  double? evaporativePurge;
  double? fuelLevel;
  double? warmupsSinceDTCClear;
  double? distanceSinceDTCClear;
  double? evapVaporPressure;
  double? barometricPressure;
  double? O2S1WRCurrent;
  double? O2S2WRCurrent;
  double? O2S3WRCurrent;
  double? O2S4WRCurrent;
  double? O2S5WRCurrent;
  double? O2S6WRCurrent;
  double? O2S7WRCurrent;
  double? O2S8WRCurrent;
  double? catalystTempB1S1;
  double? catalystTempB2S1;
  double? catalystTempB1S2;
  double? catalystTempB2S2;
  double? controlModuleVoltage;
  double? absoluteLoad;
  double? commandedEquivRatio;
  double? relativeThrottlePOS;
  double? ambiantAirTemp;
  double? throttlePOSB;
  double? throttlePOSC;
  double? throttlePOSD;
  double? throttlePOSE;
  double? throttlePOSF;
  double? throttleActuator;
  double? runTimeMIL;
  double? timeSinceDTCCleared;
  double? maxMAF;
  String? fuelType;
  double? ethanolPercent;
  double? absEvapVaporPressure;
  double? altEvapVaporPressure;
  double? shortO2TrimB1;
  double? longO2TrimB1;
  double? shortO2TrimB2;
  double? longO2TrimB2;
  double? fuelRailPressureABS;
  double? relativeAccelPOS;
  double? hybridBatteryRemaining;
  double? oilTemp;
  double? fuelInjectTiming;
  double? fuelRate;
  double? airFlowRate;

  static const String DEVICE_TIME_KEY = 'deviceTime';
  static const String CAR_ID_KEY = 'carId';
  static const String TRIP_ID_KEY = 'tripId';
  static const String GPS_LATITUDE_KEY = 'gpsLatitude';
  static const String GPS_LONGITUDE_KEY= 'gpsLongitude';
  static const String GPS_ALTITUDE_KEY= 'gpsAltitude';
  static const String GPS_SPEED_KEY = 'gpsSpeed';
  static const String GPS_TRACK_KEY = 'gpsTrack';
  static const String ENGINE_LOAD_KEY = 'engineLoad';
  static const String COOLANT_TEMP_KEY = 'coolantTemp';
  static const String SHORT_FUEL_TRIM_1_KEY = 'shortFuelTrim1';
  static const String LONG_FUEL_TRIM_1_KEY = 'longFuelTrim1';
  static const String SHORT_FUEL_TRIM_2_KEY = 'shortFuelTrim2';
  static const String LONG_FUEL_TRIM_2_KEY = 'longFuelTrim2';
  static const String FUEL_PRESSURE_KEY = 'fuelPressure';
  static const String INTAKE_PRESSURE_KEY = 'intakePressure';
  static const String RPM_KEY = 'rpm';
  static const String SPEED_KEY = 'speed';
  static const String TIMING_ADVANCE_KEY = 'timingAdvance';
  static const String INTAKE_TEMP_KEY = 'intakeTemp';
  static const String MAF_KEY = 'maf';
  static const String THROTTLE_POS_KEY = 'throttlePos';
  static const String AIR_STATUS_KEY = 'airStatus';
  static const String O2_SENSORS_KEY = 'O2Sensors';
  static const String O2_B1_S1_KEY = 'O2B1S1';
  static const String O2_B1_S2_KEY = 'O2B1S2';
  static const String O2_B1_S3_KEY = 'O2B1S3';
  static const String O2_B1_S4_KEY = 'O2B1S4';
  static const String O2_B2_S1_KEY = 'O2B2S1';
  static const String O2_B2_S2_KEY = 'O2B2S2';
  static const String O2_B2_S3_KEY = 'O2B2S3';
  static const String O2_B2_S4_KEY = 'O2B2S4';
  static const String OBD_COMPLIANCE_KEY = 'obdCompliance';
  static const String O2_SENSORS_ALT_KEY = 'O2SensorsAlt';
  static const String AUX_INPUT_STATUS_KEY = 'auxInputStatus';
  static const String RUN_TIME_KEY = 'runTime';
  static const String DISTANCE_W_MIL_KEY = 'distanceWMIL';
  static const String FUEL_RAIL_PRESSURE_VAC_KEY = 'fuelRailPressureVAC';
  static const String FUEL_RAIL_PRESSURE_DIRECT_KEY = 'fuelRailPressureDirect';
  static const String O2_S1_WR_VOLTAGE_KEY = 'O2S1WRVoltage';
  static const String O2_S2_WR_VOLTAGE_KEY = 'O2S2WRVoltage';
  static const String O2_S3_WR_VOLTAGE_KEY = 'O2S3WRVoltage';
  static const String O2_S4_WR_VOLTAGE_KEY = 'O2S4WRVoltage';
  static const String O2_S5_WR_VOLTAGE_KEY = 'O2S5WRVoltage';
  static const String O2_S6_WR_VOLTAGE_KEY = 'O2S6WRVoltage';
  static const String O2_S7_WR_VOLTAGE_KEY = 'O2S7WRVoltage';
  static const String O2_S8_WR_VOLTAGE_KEY = 'O2S8WRVoltage';
  static const String COMMANDED_EGR_KEY = 'commandedEGR';
  static const String EGR_ERROR_KEY = 'EGRError';
  static const String EVAPORATIVE_PURGE_KEY = 'evaporativePurge';
  static const String FUEL_LEVEL_KEY = 'fuelLevel';
  static const String WARMUPS_SINCE_DTC_CLEAR_KEY = 'warmupsSinceDTCClear';
  static const String DISTANCE_SINCE_DTC_CLEAR_KEY = 'distanceSinceDTCClear';
  static const String EVAP_VAPOR_PRESSURE_KEY = 'evapVaporPressure';
  static const String BAROMETRIC_PRESSURE_KEY = 'barometricPressure';
  static const String O2_S1_WR_CURRENT_KEY = 'O2S1WRCurrent';
  static const String O2_S2_WR_CURRENT_KEY = 'O2S2WRCurrent';
  static const String O2_S3_WR_CURRENT_KEY = 'O2S3WRCurrent';
  static const String O2_S4_WR_CURRENT_KEY = 'O2S4WRCurrent';
  static const String O2_S5_WR_CURRENT_KEY = 'O2S5WRCurrent';
  static const String O2_S6_WR_CURRENT_KEY = 'O2S6WRCurrent';
  static const String O2_S7_WR_CURRENT_KEY = 'O2S7WRCurrent';
  static const String O2_S8_WR_CURRENT_KEY = 'O2S8WRCurrent';
  static const String CATALYST_TEMP_B1_S1_KEY = 'catalystTempB1S1';
  static const String CATALYST_TEMP_B2_S1_KEY = 'catalystTempB2S1';
  static const String CATALYST_TEMP_B1_S2_KEY = 'catalystTempB1S2';
  static const String CATALYST_TEMP_B2_S2_KEY = 'catalystTempB2S2';
  static const String CONTROL_MODULE_VOLTAGE_KEY = 'controlModuleVoltage';
  static const String ABSOLUTE_LOAD_KEY = 'absoluteLoad';
  static const String COMMANDED_EQUIV_RATIO_KEY = 'commandedEquivRatio';
  static const String RELATIVE_THROTTLE_POS_KEY= 'relativeThrottlePOS';
  static const String AMBIANT_AIR_TEMP_KEY= 'ambiantAirTemp';
  static const String THROTTLE_POS_B_KEY = 'throttlePOSB';
  static const String THROTTLE_POS_C_KEY = 'throttlePOSC';
  static const String THROTTLE_POS_D_KEY = 'throttlePOSD';
  static const String THROTTLE_POS_E_KEY = 'throttlePOSE';
  static const String THROTTLE_POS_F_KEY = 'throttlePOSF';
  static const String THROTTLE_ACTUATOR_KEY = 'throttleActuator';
  static const String RUN_TIME_MIL_KEY = 'runTimeMIL';
  static const String TIME_SINCE_DTC_CLEARED_KEY = 'timeSinceDTCCleared';
  static const String MAX_MAF_KEY = 'maxMAF';
  static const String FUEL_TYPE_KEY = 'fuelType';
  static const String ETHANOL_PERCENT_KEY = 'ethanolPercent';
  static const String ABS_EVAP_VAPOR_PRESSURE_KEY = 'absEvapVaporPressure';
  static const String ALT_EVAP_VAPOR_PRESSURE_KEY = 'altEvapVaporPressure';
  static const String SHORT_O2_TRIM_B1_KEY = 'shortO2TrimB1';
  static const String LONG_O2_TRIM_B1_KEY = 'longO2TrimB1';
  static const String SHORT_O2_TRIM_B2_KEY = 'shortO2TrimB2';
  static const String LONG_O2_TRIM_B2_KEY = 'longO2TrimB2';
  static const String FUEL_RAIL_PRESSURE_ABS_KEY = 'fuelRailPressureABS';
  static const String RELATIVE_ACCEL_KEY = 'relativeAccelPOS';
  static const String HYBRID_BATTERY_REMAINING_KEY = 'hybridBatteryRemaining';
  static const String OIL_TEMP_KEY = 'oilTemp';
  static const String FUEL_INJECT_TIMING_KEY = 'fuelInjectTiming';
  static const String FUEL_RATE_KEY = 'fuelRate';
  static const String AIR_FLOW_RATE_KEY = 'airFlowRate';


  CarLog(this.deviceTime, this.carId, this.tripId, this.gpsLatitude,
      this.gpsLongitude, this.gpsAltitude, this.gpsSpeed, this.gpsTrack,
      this.engineLoad, this.coolantTemp, this.shortFuelTrim1,
      this.longFuelTrim1, this.shortFuelTrim2, this.longFuelTrim2,
      this.fuelPressure, this.intakePressure, this.rpm, this.speed,
      this.timingAdvance, this.intakeTemp, this.maf, this.throttlePos,
      this.airStatus, this.O2Sensors, this.O2B1S1, this.O2B1S2, this.O2B1S3,
      this.O2B1S4, this.O2B2S1, this.O2B2S2, this.O2B2S3, this.O2B2S4,
      this.obdCompliance, this.O2SensorsAlt, this.auxInputStatus, this.runTime,
      this.distanceWMIL, this.fuelRailPressureVAC, this.fuelRailPressureDirect,
      this.O2S1WRVoltage, this.O2S2WRVoltage, this.O2S3WRVoltage,
      this.O2S4WRVoltage, this.O2S5WRVoltage, this.O2S6WRVoltage,
      this.O2S7WRVoltage, this.O2S8WRVoltage, this.commandedEGR, this.EGRError,
      this.evaporativePurge, this.fuelLevel, this.warmupsSinceDTCClear,
      this.distanceSinceDTCClear, this.evapVaporPressure,
      this.barometricPressure, this.O2S1WRCurrent, this.O2S2WRCurrent,
      this.O2S3WRCurrent, this.O2S4WRCurrent, this.O2S5WRCurrent,
      this.O2S6WRCurrent, this.O2S7WRCurrent, this.O2S8WRCurrent,
      this.catalystTempB1S1, this.catalystTempB2S1, this.catalystTempB1S2,
      this.catalystTempB2S2, this.controlModuleVoltage, this.absoluteLoad,
      this.commandedEquivRatio, this.relativeThrottlePOS, this.ambiantAirTemp,
      this.throttlePOSB, this.throttlePOSC, this.throttlePOSD,
      this.throttlePOSE, this.throttlePOSF, this.throttleActuator,
      this.runTimeMIL, this.timeSinceDTCCleared, this.maxMAF, this.fuelType,
      this.ethanolPercent, this.absEvapVaporPressure, this.altEvapVaporPressure,
      this.shortO2TrimB1, this.longO2TrimB1, this.shortO2TrimB2,
      this.longO2TrimB2, this.fuelRailPressureABS, this.relativeAccelPOS,
      this.hybridBatteryRemaining, this.oilTemp, this.fuelInjectTiming,
      this.fuelRate, this.airFlowRate);

  factory CarLog.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = new DateFormat(DATE_TIME_FORMAT);
    return CarLog(
        dateFormat.parse(json[DEVICE_TIME_KEY]),
        json[CAR_ID_KEY],
        json[TRIP_ID_KEY],
        json[GPS_LATITUDE_KEY],
        json[GPS_LONGITUDE_KEY],
        json[GPS_ALTITUDE_KEY],
        json[GPS_SPEED_KEY],
        json[GPS_TRACK_KEY],
        json[ENGINE_LOAD_KEY],
        json[COOLANT_TEMP_KEY],
        json[SHORT_FUEL_TRIM_1_KEY],
        json[LONG_FUEL_TRIM_1_KEY],
        json[SHORT_FUEL_TRIM_2_KEY],
        json[LONG_FUEL_TRIM_2_KEY],
        json[FUEL_PRESSURE_KEY],
        json[INTAKE_PRESSURE_KEY],
        json[RPM_KEY],
        json[SPEED_KEY],
        json[TIMING_ADVANCE_KEY],
        json[INTAKE_TEMP_KEY],
        json[MAF_KEY],
        json[THROTTLE_POS_KEY],
        json[AIR_STATUS_KEY],
        json[O2_SENSORS_KEY],
        json[O2_B1_S1_KEY],
        json[O2_B1_S2_KEY],
        json[O2_B1_S3_KEY],
        json[O2_B1_S4_KEY],
        json[O2_B2_S1_KEY],
        json[O2_B2_S2_KEY],
        json[O2_B2_S3_KEY],
        json[O2_B2_S4_KEY],
        json[OBD_COMPLIANCE_KEY],
        json[O2_SENSORS_ALT_KEY],
        json[AUX_INPUT_STATUS_KEY],
        json[RUN_TIME_KEY],
        json[DISTANCE_W_MIL_KEY],
        json[FUEL_RAIL_PRESSURE_VAC_KEY],
        json[FUEL_RAIL_PRESSURE_DIRECT_KEY],
        json[O2_S1_WR_VOLTAGE_KEY],
        json[O2_S2_WR_VOLTAGE_KEY],
        json[O2_S3_WR_VOLTAGE_KEY],
        json[O2_S4_WR_VOLTAGE_KEY],
        json[O2_S5_WR_VOLTAGE_KEY],
        json[O2_S6_WR_VOLTAGE_KEY],
        json[O2_S7_WR_VOLTAGE_KEY],
        json[O2_S8_WR_VOLTAGE_KEY],
        json[COMMANDED_EGR_KEY],
        json[EGR_ERROR_KEY],
        json[EVAPORATIVE_PURGE_KEY],
        json[FUEL_LEVEL_KEY],
        json[WARMUPS_SINCE_DTC_CLEAR_KEY],
        json[DISTANCE_SINCE_DTC_CLEAR_KEY],
        json[EVAP_VAPOR_PRESSURE_KEY],
        json[BAROMETRIC_PRESSURE_KEY],
        json[O2_S1_WR_CURRENT_KEY],
        json[O2_S2_WR_CURRENT_KEY],
        json[O2_S3_WR_CURRENT_KEY],
        json[O2_S4_WR_CURRENT_KEY],
        json[O2_S5_WR_CURRENT_KEY],
        json[O2_S6_WR_CURRENT_KEY],
        json[O2_S7_WR_CURRENT_KEY],
        json[O2_S8_WR_CURRENT_KEY],
        json[CATALYST_TEMP_B1_S1_KEY],
        json[CATALYST_TEMP_B2_S1_KEY],
        json[CATALYST_TEMP_B1_S2_KEY],
        json[CATALYST_TEMP_B2_S2_KEY],
        json[CONTROL_MODULE_VOLTAGE_KEY],
        json[ABSOLUTE_LOAD_KEY],
        json[COMMANDED_EQUIV_RATIO_KEY],
        json[RELATIVE_THROTTLE_POS_KEY],
        json[AMBIANT_AIR_TEMP_KEY],
        json[THROTTLE_POS_B_KEY],
        json[THROTTLE_POS_C_KEY],
        json[THROTTLE_POS_D_KEY],
        json[THROTTLE_POS_E_KEY],
        json[THROTTLE_POS_F_KEY],
        json[THROTTLE_ACTUATOR_KEY],
        json[RUN_TIME_MIL_KEY],
        json[TIME_SINCE_DTC_CLEARED_KEY],
        json[MAX_MAF_KEY],
        json[FUEL_TYPE_KEY],
        json[ETHANOL_PERCENT_KEY],
        json[ABS_EVAP_VAPOR_PRESSURE_KEY],
        json[ALT_EVAP_VAPOR_PRESSURE_KEY],
        json[SHORT_O2_TRIM_B1_KEY],
        json[LONG_O2_TRIM_B1_KEY],
        json[SHORT_O2_TRIM_B2_KEY],
        json[LONG_O2_TRIM_B2_KEY],
        json[FUEL_RAIL_PRESSURE_ABS_KEY],
        json[RELATIVE_ACCEL_KEY],
        json[HYBRID_BATTERY_REMAINING_KEY],
        json[OIL_TEMP_KEY],
        json[FUEL_INJECT_TIMING_KEY],
        json[FUEL_RATE_KEY],
        json[AIR_FLOW_RATE_KEY]
    );
  }

  @override
  String toString() {
    return 'CarLog{deviceTime: $deviceTime, carId: $carId, tripId: $tripId, gpsLatitude: $gpsLatitude, gpsLongitude: $gpsLongitude, gpsAltitude: $gpsAltitude, gpsSpeed: $gpsSpeed, gpsTrack: $gpsTrack, engineLoad: $engineLoad, coolantTemp: $coolantTemp, shortFuelTrim1: $shortFuelTrim1, longFuelTrim1: $longFuelTrim1, shortFuelTrim2: $shortFuelTrim2, longFuelTrim2: $longFuelTrim2, fuelPressure: $fuelPressure, intakePressure: $intakePressure, rpm: $rpm, speed: $speed, timingAdvance: $timingAdvance, intakeTemp: $intakeTemp, maf: $maf, throttlePos: $throttlePos, airStatus: $airStatus, O2Sensors: $O2Sensors, O2B1S1: $O2B1S1, O2B1S2: $O2B1S2, O2B1S3: $O2B1S3, O2B1S4: $O2B1S4, O2B2S1: $O2B2S1, O2B2S2: $O2B2S2, O2B2S3: $O2B2S3, O2B2S4: $O2B2S4, obdCompliance: $obdCompliance, O2SensorsAlt: $O2SensorsAlt, auxInputStatus: $auxInputStatus, runTime: $runTime, distanceWMIL: $distanceWMIL, fuelRailPressureVAC: $fuelRailPressureVAC, fuelRailPressureDirect: $fuelRailPressureDirect, O2S1WRVoltage: $O2S1WRVoltage, O2S2WRVoltage: $O2S2WRVoltage, O2S3WRVoltage: $O2S3WRVoltage, O2S4WRVoltage: $O2S4WRVoltage, O2S5WRVoltage: $O2S5WRVoltage, O2S6WRVoltage: $O2S6WRVoltage, O2S7WRVoltage: $O2S7WRVoltage, O2S8WRVoltage: $O2S8WRVoltage, commandedEGR: $commandedEGR, EGRError: $EGRError, evaporativePurge: $evaporativePurge, fuelLevel: $fuelLevel, warmupsSinceDTCClear: $warmupsSinceDTCClear, distanceSinceDTCClear: $distanceSinceDTCClear, evapVaporPressure: $evapVaporPressure, barometricPressure: $barometricPressure, O2S1WRCurrent: $O2S1WRCurrent, O2S2WRCurrent: $O2S2WRCurrent, O2S3WRCurrent: $O2S3WRCurrent, O2S4WRCurrent: $O2S4WRCurrent, O2S5WRCurrent: $O2S5WRCurrent, O2S6WRCurrent: $O2S6WRCurrent, O2S7WRCurrent: $O2S7WRCurrent, O2S8WRCurrent: $O2S8WRCurrent, catalystTempB1S1: $catalystTempB1S1, catalystTempB2S1: $catalystTempB2S1, catalystTempB1S2: $catalystTempB1S2, catalystTempB2S2: $catalystTempB2S2, controlModuleVoltage: $controlModuleVoltage, absoluteLoad: $absoluteLoad, commandedEquivRatio: $commandedEquivRatio, relativeThrottlePOS: $relativeThrottlePOS, ambiantAirTemp: $ambiantAirTemp, throttlePOSB: $throttlePOSB, throttlePOSC: $throttlePOSC, throttlePOSD: $throttlePOSD, throttlePOSE: $throttlePOSE, throttlePOSF: $throttlePOSF, throttleActuator: $throttleActuator, runTimeMIL: $runTimeMIL, timeSinceDTCCleared: $timeSinceDTCCleared, maxMAF: $maxMAF, fuelType: $fuelType, ethanolPercent: $ethanolPercent, absEvapVaporPressure: $absEvapVaporPressure, altEvapVaporPressure: $altEvapVaporPressure, shortO2TrimB1: $shortO2TrimB1, longO2TrimB1: $longO2TrimB1, shortO2TrimB2: $shortO2TrimB2, longO2TrimB2: $longO2TrimB2, fuelRailPressureABS: $fuelRailPressureABS, relativeAccelPOS: $relativeAccelPOS, hybridBatteryRemaining: $hybridBatteryRemaining, oilTemp: $oilTemp, fuelInjectTiming: $fuelInjectTiming, fuelRate: $fuelRate, airFlowRate: $airFlowRate}';
  }

  num? getValueForMetricTitle(String metricTitle) {

    num? ret;
    switch (metricTitle) {
      case CarLog.SPEED_KEY:
        ret = this.speed;
        break;
      case CarLog.ABSOLUTE_LOAD_KEY:
        ret = this.absoluteLoad;
        break;
      case CarLog.ENGINE_LOAD_KEY:
        ret = this.engineLoad;
        break;
      case CarLog.INTAKE_TEMP_KEY:
        ret = this.intakeTemp;
        break;
      case CarLog.INTAKE_PRESSURE_KEY:
        ret = this.intakePressure;
        break;
      case CarLog.AMBIANT_AIR_TEMP_KEY:
        ret = this.ambiantAirTemp;
        break;
      case CarLog.COOLANT_TEMP_KEY:
        ret = this.coolantTemp;
        break;
      case CarLog.BAROMETRIC_PRESSURE_KEY:
        ret = this.barometricPressure;
        break;
      case CarLog.RUN_TIME_KEY:
        ret = this.runTime;
        break;
      case CarLog.EVAPORATIVE_PURGE_KEY:
        ret = this.evaporativePurge;
        break;
      case CarLog.EVAPORATIVE_PURGE_KEY:
        ret = this.oilTemp;
        break;
      case CarLog.FUEL_RATE_KEY:
        ret = this.fuelRate;
        break;
      case CarLog.AIR_FLOW_RATE_KEY:
        ret = this.airFlowRate;
        break;
      case CarLog.CONTROL_MODULE_VOLTAGE_KEY:
        ret = this.controlModuleVoltage;
        break;
      case CarLog.RPM_KEY:
        ret = this.rpm;
        break;
      case CarLog.RELATIVE_ACCEL_KEY:
        ret = this.relativeAccelPOS;
        break;
      case CarLog.RELATIVE_THROTTLE_POS_KEY:
        ret = this.relativeThrottlePOS;
        break;
      case CarLog.FUEL_RAIL_PRESSURE_ABS_KEY:
        ret = this.fuelRailPressureABS;
        break;
      case CarLog.EGR_ERROR_KEY:
        ret = this.EGRError;
        break;
      case CarLog.LONG_FUEL_TRIM_1_KEY:
        ret = this.longFuelTrim1;
        break;
      case CarLog.LONG_FUEL_TRIM_2_KEY:
        ret = this.longFuelTrim2;
        break;
      case CarLog.SHORT_FUEL_TRIM_1_KEY:
        ret = this.shortFuelTrim1;
        break;
      case CarLog.SHORT_FUEL_TRIM_2_KEY:
        ret = this.shortFuelTrim2;
        break;
      case CarLog.CATALYST_TEMP_B1_S1_KEY:
        ret = this.catalystTempB1S1;
        break;
      case CarLog.CATALYST_TEMP_B1_S2_KEY:
        ret = this.catalystTempB1S2;
        break;
      case CarLog.CATALYST_TEMP_B2_S1_KEY:
        ret = this.catalystTempB2S1;
        break;
      case CarLog.CATALYST_TEMP_B2_S2_KEY:
        ret = this.catalystTempB2S2;
        break;
      case CarLog.TIMING_ADVANCE_KEY:
        ret = this.timingAdvance;
        break;
      case CarLog.MAF_KEY:
        ret = this.maf;
        break;
      case CarLog.MAX_MAF_KEY:
        ret = this.maxMAF;
        break;
    }
    return ret;
  }
}