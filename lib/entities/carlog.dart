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
        dateFormat.parse(json['deviceTime']),
        json['carId'],
        json['tripId'],
        json['gpsLatitude'],
        json['gpsLongitude'],
        json['gpsAltitude'],
        json['gpsSpeed'],
        json['gpsTrack'],
        json['engineLoad'],
        json['coolantTemp'],
        json['shortFuelTrim1'],
        json['longFuelTrim1'],
        json['shortFuelTrim2'],
        json['longFuelTrim2'],
        json['fuelPressure'],
        json['intakePressure'],
        json['rpm'],
        json['speed'],
        json['timingAdvance'],
        json['intakeTemp'],
        json['maf'],
        json['throttlePos'],
        json['airStatus'],
        json['O2Sensors'],
        json['O2B1S1'],
        json['O2B1S2'],
        json['O2B1S3'],
        json['O2B1S4'],
        json['O2B2S1'],
        json['O2B2S2'],
        json['O2B2S3'],
        json['O2B2S4'],
        json['obdCompliance'],
        json['O2SensorsAlt'],
        json['auxInputStatus'],
        json['runTime'],
        json['distanceWMIL'],
        json['fuelRailPressureVAC'],
        json['fuelRailPressureDirect'],
        json['O2S1WRVoltage'],
        json['O2S2WRVoltage'],
        json['O2S3WRVoltage'],
        json['O2S4WRVoltage'],
        json['O2S5WRVoltage'],
        json['O2S6WRVoltage'],
        json['O2S7WRVoltage'],
        json['O2S8WRVoltage'],
        json['commandedEGR'],
        json['EGRError'],
        json['evaporativePurge'],
        json['fuelLevel'],
        json['warmupsSinceDTCClear'],
        json['distanceSinceDTCClear'],
        json['evapVaporPressure'],
        json['barometricPressure'],
        json['O2S1WRCurrent'],
        json['O2S2WRCurrent'],
        json['O2S3WRCurrent'],
        json['O2S4WRCurrent'],
        json['O2S5WRCurrent'],
        json['O2S6WRCurrent'],
        json['O2S7WRCurrent'],
        json['O2S8WRCurrent'],
        json['catalystTempB1S1'],
        json['catalystTempB2S1'],
        json['catalystTempB1S2'],
        json['catalystTempB2S2'],
        json['controlModuleVoltage'],
        json['absoluteLoad'],
        json['commandedEquivRatio'],
        json['relativeThrottlePOS'],
        json['ambiantAirTemp'],
        json['throttlePOSB'],
        json['throttlePOSC'],
        json['throttlePOSD'],
        json['throttlePOSE'],
        json['throttlePOSF'],
        json['throttleActuator'],
        json['runTimeMIL'],
        json['timeSinceDTCCleared'],
        json['maxMAF'],
        json['fuelType'],
        json['ethanolPercent'],
        json['absEvapVaporPressure'],
        json['altEvapVaporPressure'],
        json['shortO2TrimB1'],
        json['longO2TrimB1'],
        json['shortO2TrimB2'],
        json['longO2TrimB2'],
        json['fuelRailPressureABS'],
        json['relativeAccelPOS'],
        json['hybridBatteryRemaining'],
        json['oilTemp'],
        json['fuelInjectTiming'],
        json['fuelRate'],
        json['airFlowRate']);
  }

  @override
  String toString() {
    return 'CarLog{deviceTime: $deviceTime, carId: $carId, tripId: $tripId, gpsLatitude: $gpsLatitude, gpsLongitude: $gpsLongitude, gpsAltitude: $gpsAltitude, gpsSpeed: $gpsSpeed, gpsTrack: $gpsTrack, engineLoad: $engineLoad, coolantTemp: $coolantTemp, shortFuelTrim1: $shortFuelTrim1, longFuelTrim1: $longFuelTrim1, shortFuelTrim2: $shortFuelTrim2, longFuelTrim2: $longFuelTrim2, fuelPressure: $fuelPressure, intakePressure: $intakePressure, rpm: $rpm, speed: $speed, timingAdvance: $timingAdvance, intakeTemp: $intakeTemp, maf: $maf, throttlePos: $throttlePos, airStatus: $airStatus, O2Sensors: $O2Sensors, O2B1S1: $O2B1S1, O2B1S2: $O2B1S2, O2B1S3: $O2B1S3, O2B1S4: $O2B1S4, O2B2S1: $O2B2S1, O2B2S2: $O2B2S2, O2B2S3: $O2B2S3, O2B2S4: $O2B2S4, obdCompliance: $obdCompliance, O2SensorsAlt: $O2SensorsAlt, auxInputStatus: $auxInputStatus, runTime: $runTime, distanceWMIL: $distanceWMIL, fuelRailPressureVAC: $fuelRailPressureVAC, fuelRailPressureDirect: $fuelRailPressureDirect, O2S1WRVoltage: $O2S1WRVoltage, O2S2WRVoltage: $O2S2WRVoltage, O2S3WRVoltage: $O2S3WRVoltage, O2S4WRVoltage: $O2S4WRVoltage, O2S5WRVoltage: $O2S5WRVoltage, O2S6WRVoltage: $O2S6WRVoltage, O2S7WRVoltage: $O2S7WRVoltage, O2S8WRVoltage: $O2S8WRVoltage, commandedEGR: $commandedEGR, EGRError: $EGRError, evaporativePurge: $evaporativePurge, fuelLevel: $fuelLevel, warmupsSinceDTCClear: $warmupsSinceDTCClear, distanceSinceDTCClear: $distanceSinceDTCClear, evapVaporPressure: $evapVaporPressure, barometricPressure: $barometricPressure, O2S1WRCurrent: $O2S1WRCurrent, O2S2WRCurrent: $O2S2WRCurrent, O2S3WRCurrent: $O2S3WRCurrent, O2S4WRCurrent: $O2S4WRCurrent, O2S5WRCurrent: $O2S5WRCurrent, O2S6WRCurrent: $O2S6WRCurrent, O2S7WRCurrent: $O2S7WRCurrent, O2S8WRCurrent: $O2S8WRCurrent, catalystTempB1S1: $catalystTempB1S1, catalystTempB2S1: $catalystTempB2S1, catalystTempB1S2: $catalystTempB1S2, catalystTempB2S2: $catalystTempB2S2, controlModuleVoltage: $controlModuleVoltage, absoluteLoad: $absoluteLoad, commandedEquivRatio: $commandedEquivRatio, relativeThrottlePOS: $relativeThrottlePOS, ambiantAirTemp: $ambiantAirTemp, throttlePOSB: $throttlePOSB, throttlePOSC: $throttlePOSC, throttlePOSD: $throttlePOSD, throttlePOSE: $throttlePOSE, throttlePOSF: $throttlePOSF, throttleActuator: $throttleActuator, runTimeMIL: $runTimeMIL, timeSinceDTCCleared: $timeSinceDTCCleared, maxMAF: $maxMAF, fuelType: $fuelType, ethanolPercent: $ethanolPercent, absEvapVaporPressure: $absEvapVaporPressure, altEvapVaporPressure: $altEvapVaporPressure, shortO2TrimB1: $shortO2TrimB1, longO2TrimB1: $longO2TrimB1, shortO2TrimB2: $shortO2TrimB2, longO2TrimB2: $longO2TrimB2, fuelRailPressureABS: $fuelRailPressureABS, relativeAccelPOS: $relativeAccelPOS, hybridBatteryRemaining: $hybridBatteryRemaining, oilTemp: $oilTemp, fuelInjectTiming: $fuelInjectTiming, fuelRate: $fuelRate, airFlowRate: $airFlowRate}';
  }
}